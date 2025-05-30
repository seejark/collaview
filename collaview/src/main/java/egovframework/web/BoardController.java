package egovframework.web;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.cj.xdevapi.JsonArray;
import com.mysql.cj.xdevapi.JsonValue;

import egovframework.service.BoardChatVO;
import egovframework.service.BoardService;
import egovframework.service.BoardVO;
import egovframework.service.ChannelService;
import egovframework.service.ChannelVO;
import egovframework.service.EgovCvService;
import egovframework.service.FileVO;
import egovframework.service.RecruitVO;


@Controller
public class BoardController {
	
	/** VideoService*/
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "egovCvService")
	private EgovCvService egovCvService;
	
    // 게시글 목록 페이지
	@GetMapping("/board_list.do")
    public String boardList(Model model) {
		Integer boardTotCnt = boardService.selectBoardTotCnt();
		model.addAttribute("boardTotCnt", boardTotCnt);
		
        return "board/BoardList";
    }

    // 게시글 목록 페이지 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/ajax_moreBoard.do", produces="application/text; charset=UTF-8")
	public String moreBoard(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletResponse response) throws Exception {
		List<BoardVO> boardList = boardService.selectBoardList(Integer.parseInt((String) params.get("offset")),Integer.parseInt((String) params.get("boardPageSize")));

	    JSONArray jsonArray = new JSONArray();

	    for (BoardVO vo : boardList) {
	        JSONObject jsonObject = voToJson(vo); // VO 객체를 JSON으로 변환
        	jsonArray.add(jsonObject);
	    }
	    JSONObject result = new JSONObject();
	    result.put("data", jsonArray);
	    result.put("result", "success");
	    
        return result.toString();
	}
	
	@GetMapping("/board_insert.do")
	public String board_insert(HttpSession session, Model model) {
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = boardService.selectChannelList(id);
		model.addAttribute("channelList", channelList);
		return "board/BoardInsert";
	}
	
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	@PostMapping("/board_insert.do")
	public String board_insertPost(HttpServletRequest request, HttpSession session, BoardVO boardVO, MultipartFile file[])
			throws IllegalStateException, IOException {
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
	    else {
	    	return "notLogin";
	    }
	    boardVO.setUser(id);
		
	    
//	    게시물 등록
		int res = boardService.insertBoard(boardVO);
		
//		등록한 게시물의 idx
		int lastPostIdx = boardService.selectLastPost(boardVO);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		

		/* 파일 업로드 - S */
		String table;
		if(boardVO.getCategory().equals("hire") || boardVO.getCategory().equals("scout")) {
			table = "recruit";
		}
		else {
			table = "board";
		}
		
        String rootFolder = request.getSession().getServletContext().getRealPath("/"); // 현재 작업 디렉토리를 가져옴
        // (현재 작업 폴더)\collaview\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\collaview
        String beforeMetadata = rootFolder.substring(0, rootFolder.indexOf(".metadata")); // 테스트용 경로
        String uploadDir = beforeMetadata + "collaview" + File.separator + "src" + File.separator + "main"
        		+ File.separator + "webapp" + File.separator + "file" + File.separator;

        for (MultipartFile fileObject : file) {
        	FileVO fileVO = fileUpload(uploadDir + "bbs", fileObject, id, table, lastPostIdx); // 사진 파일 업로드
    		
        	if(fileVO != null && fileVO.getUser() != null) {
        		egovCvService.insertFile(fileVO);
        	}
        }
		/* 파일 업로드 - E */
		if(res != 0) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	

	
    // 게시글 상세 페이지
	@GetMapping("/board_detail.do")
    public String boardView(@RequestParam(name = "table", required = false) String table,
    		@RequestParam(name = "idx", required = false) Integer idx, HttpSession session, Model model) {
		if((!table.equals("board") && !table.equals("recruit")) || idx == null) {
			return "redirect:/index.do";
		}
		BoardVO board = boardService.selectBoardDetail(table, idx);
		List<FileVO> fileList = boardService.selectBoardFile(table, idx);
		List<BoardChatVO> chatList = boardService.selectBoardChat(idx);

		model.addAttribute("board", board);
		model.addAttribute("fileLIst", fileList);
		model.addAttribute("chatList", chatList);
		
		
		HashMap userData = (HashMap) session.getAttribute("userData");
	    if (userData != null && userData.get("id") != null) {
	    	String id = (String) userData.get("id");
			model.addAttribute("channelList", boardService.selectChannelListAll(id));
	    }

        return "board/BoardView";
    }

    // 게시글 상세 페이지 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/ajax_recruitApply.do", produces="application/text; charset=UTF-8")
	public String insertRecruitApply(@RequestParam("recruit") int recruit, @RequestParam("channel") int channel,
			HttpSession session, HttpServletResponse response) throws Exception {
//		RecruitVO recruitVO = new RecruitVO();
//		int idx = boardService.insertRecruitApply(recruitVO);

        return "success";
//	    if(idx > 0) {
//	        return "success";
//	    }else {
//	        return "fail";
//	    }
	}
	
    // VO 객체를 JSONObject로 자동 변환하는 메서드
    private JSONObject voToJson(Object vo) {
        JSONObject jsonObject = new JSONObject();
        try {
            for (Field field : vo.getClass().getDeclaredFields()) {
                field.setAccessible(true); // private 필드 접근 허용
                jsonObject.put(field.getName(), field.get(vo)); // 키: 필드명, 값: 필드 값
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return jsonObject;
    }
    
    // object 객체를 list 형태로 변환
    private List<?> objectToList(Object obj){
        List<Object> resultList = new ArrayList<>();

        if (obj == null) {
            return resultList; // null이면 빈 리스트 반환
        }

        if (obj instanceof List<?>) {
            return (List<?>) obj; // 이미 List<?>이면 그대로 반환
        } else if (obj instanceof String) {
            // GET 방식에서 "1,2,3" 형태로 들어왔을 경우 변환
            return Arrays.asList(((String) obj).split(","));
        }

        return resultList;
    }
    

    // 파일 업로드
    private FileVO fileUpload(String uploadDir, MultipartFile file, String id, String table, int idx)
    		throws IllegalStateException, IOException {
    	File folder = new File(uploadDir);
		if (!folder.exists()) {
		    boolean created = folder.mkdirs();
		    if (created) {
		        System.out.println("업로드 폴더 생성됨: " + uploadDir);
		    } else {
		        System.out.println("업로드 폴더 생성 실패!");
		    }
		}

		String savedName;
        if (!file.isEmpty()) {
            String originalName = file.getOriginalFilename();
            long unixTimestamp = System.currentTimeMillis() / 1000L;
            savedName = unixTimestamp + "_" + id + "_" + originalName;

            File saveFile = new File(uploadDir, savedName);
            file.transferTo(saveFile); // 파일 전송
            
            FileVO vo = new FileVO();
            vo.setFile_name(savedName);
            vo.setOrigin_name(originalName);
            vo.setUser(id);
            vo.setTable(table);
            vo.setNum(idx);
            
            return vo;
        }else {
        	return null;
        }
    }
}