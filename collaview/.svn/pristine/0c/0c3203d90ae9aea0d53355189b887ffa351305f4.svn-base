package egovframework.web;

import java.io.File;
import java.lang.reflect.Field;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.json.simple.JSONObject;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.service.ChannelVO;
import egovframework.service.LoginVO;
import egovframework.service.ProfileService;
import egovframework.service.UserVO;

@Controller
public class ProfileController {

	@Resource(name = "profileService")
	private ProfileService profileService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@RequestMapping(value = "/profileView.do")
	public String profileView(HttpSession session, Integer idx, ModelMap model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "5") int pageSize
	) throws Exception {
		
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
	    
		if(idx == null) {
	        return "redirect:/index.do";
		}
		JSONObject jsonObject = new JSONObject(profileService.selectUserProfile(idx));
		model.addAttribute("data", jsonObject);
		
		List<ChannelVO> channelList = profileService.selectMyChannel(idx, page, pageSize);
		for(ChannelVO channel : channelList) {
			if(channel.getAdmin() == null) {
				channel.setAdmin("리더");
			}
			else {
				if(channel.getAdmin().equals("y")) {
					channel.setAdmin("중간 관리자");
				}
				else {
					channel.setAdmin("멤버");
				}
			}
		}
		
		System.out.println("channelList : " + channelList);
		model.addAttribute("channelList", channelList);
		return "profile/profileView";
	}
	
	@RequestMapping(value = "/profile_loadChannelList.do")
	public String profile_loadChannelList(HttpSession session, Integer idx, ModelMap model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "pageSize", defaultValue = "5") int pageSize
			) throws Exception {
		
		
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
		String id = null;
		if (userData != null && userData.get("id") != null) {
			id = userData.get("id").toString();
		}
		
		if(idx == null) {
			return "redirect:/index.do";
		}
		
		List<ChannelVO> channelList = profileService.selectMyChannel(idx, page, pageSize);
		for(ChannelVO channel : channelList) {
			if(channel.getAdmin() == null) {
				channel.setAdmin("리더");
			}
			else {
				if(channel.getAdmin().equals("y")) {
					channel.setAdmin("중간 관리자");
				}
				else {
					channel.setAdmin("멤버");
				}
			}
		}
		
		model.addAttribute("channelList", channelList);
		System.out.println("channelList : " + channelList);
		return "profile/profile_moreView";
	}
	
	@GetMapping("/profile_update.do")
	public String profile_update(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
		String id = null;
		if (userData != null && userData.get("id") != null) {
			id = userData.get("id").toString();
		}
		
		if(id == null) {
			return "redirect:/index.do";
		}
		
		UserVO userVO = profileService.selectMyInfo(id);
		System.out.println("userVO : " + userVO);
		model.addAttribute("userVO", userVO);
		
//		이메일 받아오기
		String email[] = userVO.getEmail().split("@");
		model.addAttribute("email1", email[0]);
		model.addAttribute("email2", email[1]);
		
//		전화번호 받아오기
		String phone[] = userVO.getPhone().split("-");
		model.addAttribute("phone1", phone[0]);
		model.addAttribute("phone2", phone[1]);
		model.addAttribute("phone3", phone[2]);
		
//		생년월일 받아오기
		Date birth = userVO.getBirth();
		LocalDate localBirth = birth.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		int year = localBirth.getYear();
		int month = localBirth.getMonthValue();
		int day = localBirth.getDayOfMonth();
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		
		return "profile/profile_update";
	}
	
	@PostMapping("/profile_update.do")
	public String profile_update_submit(UserVO userVO) {
		System.out.println("userVO : " + userVO);
		return "";
	}


	// 회원탈퇴 프로세스
	@ResponseBody
	@RequestMapping(value = "/ajax_cancelAccount.do")
	public String cancelAccountProcess(LoginVO input, HttpSession session, HttpServletResponse response) throws Exception {
        profileService.deleteUser(input);
        String result = profileService.selectUserDelDate(input);
		if(result != null) {
			return "success";
		}else {
			return "fail";
		}
	}
	


	// 업로드 폴더 생성
	private void createFolder(String uploadDir) {
		File folder = new File(uploadDir);
		if (!folder.exists()) {
		    boolean created = folder.mkdirs();
		    if (created) {
		        System.out.println("업로드 폴더 생성됨: " + uploadDir);
		    } else {
		        System.out.println("업로드 폴더 생성 실패!");
		    }
		}
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
}
