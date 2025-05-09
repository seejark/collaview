package egovframework.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.service.RecruitVO;
import egovframework.service.ChannelService;
import egovframework.service.ChannelVO;
import egovframework.service.EgovCvService;
import egovframework.service.UserVO;
import egovframework.service.VideoVO;

@Controller
public class ChannelController {
	
	@Resource(name = "egovCvService")
	private EgovCvService egovCvService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
	/** ChanelService*/
	@Resource(name = "channelService")
	private ChannelService channelService;
	
	@GetMapping("/channel_setting.do")
	public String settingChannel(Model model,
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx
	) {
		if(idx != 0) {
			ChannelVO channelVO = channelService.selectChannel(idx);
			List<UserVO> userList = channelService.selectChannelMember(idx);
			model.addAttribute("channelVO", channelVO);
			model.addAttribute("userList", userList);
			model.addAttribute("idx", idx);
		}
		return "channel/channel_setting";
	}
	
	@Transactional(rollbackFor = Exception.class)
	@ResponseBody
	@PostMapping(value = "/ajax_createChannel.do", produces="application/json;charset=UTF-8")
	public Map<String, Object> ajax_createChannel(HttpServletRequest request, HttpSession session, ChannelVO channelVO,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "memberId", required = false) String memberId,
			@RequestParam(value = "managerCheck", required = false) String managerCheck
	) throws Exception {
		
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData == null || userData.get("id") == null) {
	    	return Collections.singletonMap("status", "notLogin");
	    }
	    
	    id = userData.get("id").toString();
	    channelVO.setUser(id);
	    
		/* 파일 업로드 - S */
        String rootFolder = request.getSession().getServletContext().getRealPath("/"); // 현재 작업 디렉토리를 가져옴
        // (현재 작업 폴더)\collaview\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\collaview
        String beforeMetadata = rootFolder.substring(0, rootFolder.indexOf(".metadata"));
        String uploadDir = beforeMetadata + "collaview" + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "file" + File.separator + "thumbnail";

        createFolder(uploadDir);

		String savedName;
        if (!file.isEmpty()) {
            String originalName = file.getOriginalFilename();
            long unixTimestamp = System.currentTimeMillis() / 1000L;
            savedName = unixTimestamp + "_" + channelVO.getUser() + "_" + originalName;

            File saveFile = new File(uploadDir, savedName);
            file.transferTo(saveFile); // 파일 전송
            
            channelVO.setThumbnail_file(savedName);
            channelVO.setThumbnail_origin(originalName);
        }
		/* 파일 업로드 - E */
        
        //--- 채널 생성 & 키(idx) 채워오기 ---
        channelService.insertChannel(channelVO, file);
        // 이제 channelVO.getIdx() 에 AUTO_INCREMENT 값이 들어있음
        //--- 밴드 멤버 추가가 필요한 경우 ---
        boolean memberOk = true;
        if (StringUtils.hasText(memberId) && "y".equalsIgnoreCase(channelVO.getBand_chk())) {
            String addMember = channelService.insertBandMember(channelVO, memberId, managerCheck);
            memberOk = "success".equals(addMember);
        }

        //--- 결과 맵 생성 ---
        Map<String, Object> resp = new HashMap<>();
        if (memberOk) {
            resp.put("status", "success");
            resp.put("idx", channelVO.getIdx());
        } else {
            resp.put("status", "fail");
        }
        return resp;
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/ajax_updateChannel.do")
	public Map<String, Object> ajax_updateChannel(HttpServletRequest request, HttpSession session, ChannelVO channelVO,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "memberId", required = false) String memberId,
			@RequestParam(value = "managerCheck", required = false) String managerCheck,
			@RequestParam(value = "removedMemberIds", required = false) String removedMemberIds
	) throws Exception {
		Map<String, Object> result = new HashMap<>();
		result.put("idx", channelVO.getIdx());
		
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		channelVO.setUser(id);
		
	    String channelUpdateResult = channelService.updateChannel(channelVO, file);

	    if (removedMemberIds != null && !removedMemberIds.isEmpty()) {
	        channelService.deleteMember(removedMemberIds);
	    }

	    if (memberId != null && !memberId.isEmpty() &&
	        ("true".equalsIgnoreCase(channelVO.getBand_chk()) || "y".equalsIgnoreCase(channelVO.getBand_chk()))) {
	        
	        String[] submittedMembers = memberId.split("/");
	        String[] submittedManagerChecks = managerCheck.split("/");

	        List<UserVO> currentMemberList = channelService.selectChannelMember(channelVO.getIdx());

	        Set<String> currentMemberSet = new HashSet<>();
	        Map<String, String> currentMemberAdminMap = new HashMap<>();
	        for (UserVO user : currentMemberList) {
	            currentMemberSet.add(user.getId());
	            currentMemberAdminMap.put(user.getId(), user.getAdmin());  
	        }
	        
	        List<String> newMembers = new ArrayList<>();
	        List<String> newMemberMidManagers = new ArrayList<>();
	        List<String> updateMembers = new ArrayList<>();
	        List<String> updateMembersMidManager = new ArrayList<>();
	        
	        for (int i = 0; i < submittedMembers.length; i++) {
	            String submittedMember = submittedMembers[i];
	            String submittedMidCheck = submittedManagerChecks[i];
	            
	            if (currentMemberSet.contains(submittedMember)) {
	                String dbMidCheck = currentMemberAdminMap.get(submittedMember);
	                if (!dbMidCheck.equalsIgnoreCase(submittedMidCheck)) {
	                    updateMembers.add(submittedMember);
	                    updateMembersMidManager.add(submittedMidCheck);
	                }
	            } else {
	                newMembers.add(submittedMember);
	                newMemberMidManagers.add(submittedMidCheck);
	            }
	        }
	        
	        String updateMemberResult = "";
	        if (!updateMembers.isEmpty()) {
	            updateMemberResult = channelService.updateBandMember(
	                    channelVO, 
	                    String.join("/", updateMembers), 
	                    String.join("/", updateMembersMidManager)
	            );
	        } else {
	            updateMemberResult = channelUpdateResult;
	        }
	        
	        String addMemberResult = "";
	        if (!newMembers.isEmpty()) {
	            addMemberResult = channelService.insertBandMember(
	                    channelVO, 
	                    String.join("/", newMembers), 
	                    String.join("/", newMemberMidManagers)
	            );
	        } else {
	            addMemberResult = channelUpdateResult;
	        }
	        
	        if (updateMemberResult.equals(channelUpdateResult) && addMemberResult.equals(channelUpdateResult)) {
	        	result.put("status", "success");
	            return result;
	        } else {
	        	result.put("status", "fail");
	            return result;
	        }
	    }
	    else {
	    	result.put("status", channelUpdateResult);
	        return result;
	    }
	}
	
	@ResponseBody
	@PostMapping("/duplicationKey.do")
	public String duplicationKey(String key) {
		
		int result = channelService.selectKey(key);
		if(result == 1) {
			return "y";
		}
		else {
			return "n";
		}
	}
	
	@ResponseBody
	@PostMapping(value="/ajax_bandMemberIdSearch.do", produces="application/text; charset=UTF-8")
	public String ajax_bandMemberIdSearch(String id) {
		UserVO userVO = channelService.selectId(id);
		if(userVO != null) {
			return userVO.getNick();
		}
		else {
			return null;
		}
	}
	
	@GetMapping("/channel_self.do")
	public String channel_self(Model model, HttpSession session, int idx,
			@RequestParam(name = "videoPage", defaultValue = "1") int videoPage,
		    @RequestParam(name = "videoPageSize", defaultValue = "8") int videoPageSize,
		    @RequestParam(name = "applyPage", defaultValue = "1") int applyPage,
		    @RequestParam(name = "applyPageSize", defaultValue = "5") int applyPageSize
	) throws Exception {
		
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
        model.addAttribute("id", id);
		
		List<UserVO> userList = channelService.selectChannelMember(idx);
		model.addAttribute("userList", userList);
		
		int bookmark = channelService.selectBookmarkCnt(idx);
		model.addAttribute("bookmark", bookmark);
		
		UserVO userVO = channelService.selectId(id);
		model.addAttribute("userVO", userVO);
		
		ChannelVO channelVO = channelService.selectChannel(idx);
		model.addAttribute("channelVO", channelVO);
		
		List<VideoVO> videoList = channelService.selectVideoList(idx, videoPage, videoPageSize);
	    if (videoList == null) {
	        videoList = new ArrayList<>();
	    }
	    
		int totalVideoCount = channelService.getTotalVideoCount(idx);
	    int videoTotal = (int) Math.ceil((double) totalVideoCount / videoPageSize);
	    model.addAttribute("videoList", videoList);
	    model.addAttribute("videoPage", videoPage);
	    model.addAttribute("videoTotal", videoTotal);
	    model.addAttribute("videoPageSize", videoPageSize);
	    
	    List<RecruitVO> recruitList = channelService.selectRecruitList(idx);
	    model.addAttribute("recruitList", recruitList);
	    
	    List<RecruitVO> recruit_applyList = channelService.selectRecruitApplyList(idx, applyPage, applyPageSize);
	    if (recruitList == null) {
	        recruitList = new ArrayList<>();
	    }
	    int totalAplicationCount = channelService.getTotalAplicationCount(idx);
	    int aplicationTotal = (int) Math.ceil((double) totalAplicationCount / applyPageSize);
	    model.addAttribute("recruit_applyList", recruit_applyList);
	    model.addAttribute("applyTotal", aplicationTotal);
	    model.addAttribute("applyPageSize", applyPageSize);
	    model.addAttribute("applyPage", applyPage);
	    
	    String last_upload_date = "";
	    if (videoList != null && !videoList.isEmpty() && videoList.get(0).getRegister_date() != null) {
	    	videoList.get(0).getRegister_date().toString();
	        last_upload_date = videoList.get(0).getRegister_date().toString();
	        last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
	    } else {
	        last_upload_date = "영상없음";
	    }
	    model.addAttribute("last_upload_date", last_upload_date);
	    
	    int totViewCnt = channelService.selectChannelViewCnt(idx);
	    model.addAttribute("totViewCnt", totViewCnt);
	    
	    Double aura_score = channelService.selectAuraAvg(idx);
	    model.addAttribute("aura_score", aura_score);
	    
	    Double skill_score = channelService.selectSkillAvg(idx);
	    model.addAttribute("skill_score", skill_score);
	    System.out.println("userList : " + userList);
		return "channel/channel_self";
	}
	
	@GetMapping("/videoListPartial.do")
	public String videoListPartial(Model model,
	    @RequestParam(name = "idx") int channelId,
	    @RequestParam(name = "videoPage", defaultValue = "1") int videoPage,
	    @RequestParam(name = "videoPageSize", defaultValue = "8") int videoPageSize) throws Exception {
	    
	    List<VideoVO> videoList = channelService.selectVideoList(channelId, videoPage, videoPageSize);
	    model.addAttribute("videoList", videoList);
	    return "channel/videoListPartial";
	}
	
	@GetMapping("/applyListPartial.do")
	public String pplyListPartial(Model model,
			@RequestParam(name = "idx") int channelId,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "pageSize", defaultValue = "5") int pageSize) throws Exception {
		
		List<RecruitVO> recruit_applyList = channelService.selectRecruitApplyList(channelId, page, pageSize);
		model.addAttribute("recruit_applyList", recruit_applyList);
		return "channel/applyListPartial";
	}
	
	@GetMapping("/channel_detail.do")
	public String channel_detail(Model model, int idx,
			@RequestParam(name = "videoPage", defaultValue = "1") int videoPage,
		    @RequestParam(name = "videoPageSize", defaultValue = "8") int videoPageSize
	) {
		ChannelVO channelVO = channelService.selectChannel(idx);
		model.addAttribute("channelVO", channelVO);
		
		List<VideoVO> videoList = channelService.selectVideoList(idx, videoPage, videoPageSize);
		model.addAttribute("videoList", videoList);
		
	    UserVO userVO = channelService.selectId(channelVO.getUser());
	    model.addAttribute("userVO", userVO);
	    System.out.println("userVO : " + userVO);
		
		String last_upload_date = "";
		if (videoList != null && !videoList.isEmpty()) {
            last_upload_date = videoList.get(0).getRegister_date().toString();
            last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
        } else {
            last_upload_date = "영상 없음";
        }
		model.addAttribute("last_upload_date", last_upload_date);
	    
	    int bookmarkCnt = 0;
	    for(VideoVO video : videoList) {
	    	bookmarkCnt += video.getBookmark();
	    }
	    model.addAttribute("bookmarkCnt", bookmarkCnt);
	    model.addAttribute("videoPage", videoPage);
	    
		if(channelVO.getBand_chk().equals("y")) {
			List<UserVO> memberList = channelService.selectChannelMember(idx);
			model.addAttribute("memberList", memberList);
			return "channel/channel_band";
		}
		else {
			return "channel/channel_user";
		}
	    
	}
	
	@PostMapping("/loadMoreVideos.do")
	public String loadMoreVideos(Model model, int idx,
			@RequestParam(name = "videoPage", defaultValue = "1") int videoPage,
		    @RequestParam(name = "videoPageSize", defaultValue = "8") int videoPageSize
    ){
		List<VideoVO> videoList = channelService.selectVideoList(idx, videoPage, videoPageSize);
        model.addAttribute("videoList", videoList);
		return "channel/channel_user_videoItem";
	}
	
	@ResponseBody
	@PostMapping("/addBookmark.do")
	public String addBookmark(HttpSession session, int idx){
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
        int bookCnt = channelService.selectBookmarkUserCnt(id);
        
		return channelService.insertBookmark(idx, id, (bookCnt + 1));
	}
	
	@ResponseBody
	@PostMapping("/removeBookmark.do")
	public String removeBookmark(HttpSession session, int idx){
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		channelService.updateBookmarkOrderBeforeDel(idx, id);
		return channelService.deleteBookmark(idx, id);
	}
	
	@ResponseBody
	@PostMapping("/checkBookmark.do")
	public String checkBookmark(HttpSession session, int idx){
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		ChannelVO bookmark = channelService.selectBookmark(idx, id);
		if(bookmark != null) {
			return "true";
		}
		else {
			return "false";
		}
	}
	
	@GetMapping("/channel_application.do")
	public String channel_application(Model model, int idx) {
		RecruitVO applicationVO = channelService.selectMyApplication(idx);
		model.addAttribute("applicationVO", applicationVO);
		UserVO managerInfo = channelService.selectId(applicationVO.getUser());
		String manager = managerInfo.getNick();
		model.addAttribute("manager", manager);
		
		ChannelVO channelVO = channelService.selectChannel(applicationVO.getChannel());
		model.addAttribute("channelVO", channelVO);
		
		List<UserVO> userList = channelService.selectChannelMember(applicationVO.getChannel());
		model.addAttribute("userList", userList);
		
		model.addAttribute("idx", idx);
		return "channel/channel_application";
	}
	
	@ResponseBody
	@PostMapping("/processing.do")
	public int processing(int idx, String processing) {
		return channelService.updateStatus(idx, processing);
	}
	
	@GetMapping("/channel_recruit.do")
	public String channel_recruit(Model model, int idx) {
		RecruitVO applicationVO = channelService.selectMyApplication(idx);
		model.addAttribute("applicationVO", applicationVO);
		UserVO managerInfo = channelService.selectId(applicationVO.getUser());
		String manager = managerInfo.getNick();
		model.addAttribute("manager", manager);
		
		ChannelVO channelVO = channelService.selectChannel(applicationVO.getChannel());
		model.addAttribute("channelVO", channelVO);
		
		List<UserVO> userList = channelService.selectChannelMember(applicationVO.getChannel());
		model.addAttribute("userList", userList);
		
		model.addAttribute("idx", idx);
		return "channel/channel_recruit";
	}
	
	@ResponseBody
	@PostMapping("/channel_recruitCancel.do")
	public int channel_recruitCancel(int idx) {
		return channelService.updateStatus(idx, "취소");
	}
	
	@GetMapping("/channel_chartList.do")
	public String channel_chartList(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize
	) {
		List<ChannelVO> chartList = channelService.selectChannelChart(page, pageSize);
		String last_upload_date = "";
		for(ChannelVO chart : chartList) {
			List<VideoVO> videoList = channelService.selectVideoList(chart.getChannel(), page, pageSize);
			if (videoList != null && !videoList.isEmpty()) {
	            last_upload_date = videoList.get(0).getRegister_date().toString();
	            last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
	        } else {
	            last_upload_date = "영상 없음";
	        }
			chart.setLast_upload(last_upload_date);
		}
		model.addAttribute("chartList", chartList);
		
		
		return "channel/channel_chartList";
	}
	
	@PostMapping("/channel_loadChartChannel.do")
	public String channel_loadChartChannel(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize
	) {
		List<ChannelVO> chartList = channelService.selectChannelChart(page, pageSize);
		String last_upload_date = "";
		for(ChannelVO chart : chartList) {
			List<VideoVO> videoList = channelService.selectVideoList(chart.getChannel(), 1, pageSize);
			if (videoList != null && !videoList.isEmpty()) {
	            last_upload_date = videoList.get(0).getRegister_date().toString();
	            last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
	        } else {
	            last_upload_date = "영상 없음";
	        }
			chart.setLast_upload(last_upload_date);
		}
		model.addAttribute("chartList", chartList);
		
		return "channel/channel_loadChartChannel";
	}
	
	@PostMapping("/channel_loadChartVideo.do")
	public String channel_loadChartVideo(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "PageSize", defaultValue = "10") int pageSize
			) {
		List<VideoVO> chartList = channelService.selectVideoChart(page, pageSize);
		model.addAttribute("chartList", chartList);
		return "channel/channel_loadChartVideo";
	}
	
	@GetMapping("/channel_list.do")
	public String channel_list(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize
	) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = channelService.selectChannelList(id, page, pageSize);
		String last_upload_date = "";
		for(ChannelVO channel : channelList) {
			List<VideoVO> videoList = channelService.selectVideoList(channel.getChannel(), 1, pageSize);
			if (videoList != null && !videoList.isEmpty()) {
	            last_upload_date = videoList.get(0).getRegister_date().toString();
	            last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
	        } else {
	            last_upload_date = "영상 없음";
	        }
			channel.setLast_upload(last_upload_date);
			if(channel.getMember() != null) {
				String channelMembers[] = channel.getMember().split(", ");
				String isMember = "false";
				for(String member : channelMembers) {
					if(member.trim().equals(id)) {
						isMember = "true";
						break;
					}
					else {
						isMember = "false";
					}
				}
				channel.setIsMember(isMember);
			}
			else {
				channel.setIsMember(null);
			}
		}
		model.addAttribute("channelList", channelList);
		
		return "channel/channel_list";
	}
	
	@PostMapping("/channel_loadChannelList.do")
	public String channel_loadChannelList(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "PageSize", defaultValue = "10") int pageSize
	) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = channelService.selectChannelList(id, page, pageSize);
		String last_upload_date = "";
		for(ChannelVO channel : channelList) {
			List<VideoVO> videoList = channelService.selectVideoList(channel.getChannel(), 1, pageSize);
			if (videoList != null && !videoList.isEmpty()) {
	            last_upload_date = videoList.get(0).getRegister_date().toString();
	            last_upload_date = last_upload_date.substring(0, 10).replace("-", ".");
	        } else {
	            last_upload_date = "영상 없음";
	        }
			channel.setLast_upload(last_upload_date);
			if(channel.getMember() != null) {
				String channelMembers[] = channel.getMember().split(", ");
				String isMember = "false";
				for(String member : channelMembers) {
					if(member.trim().equals(id)) {
						isMember = "true";
						break;
					}
					else {
						isMember = "false";
					}
				}
				channel.setIsMember(isMember);
			}
			else {
				channel.setIsMember(null);
			}
		}
		model.addAttribute("channelList", channelList);
		return "channel/channel_loadChannelList";
	}
	
	@ResponseBody
	@PostMapping("/channel_userDel.do")
	public int channel_userDel(HttpSession session, int idx) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		return channelService.updateChannelDel(idx, id);
	}

	@GetMapping("/channel_bookmarkList.do")
	public String channel_bookmarkList(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize
	) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = channelService.selectBookmarkChannelList(id, page, pageSize);
		model.addAttribute("channelList", channelList);
		for(ChannelVO channel :channelList) {
			List<VideoVO> videoList = channelService.selectVideoAll(channel.getChannel());
			if (videoList == null) {
		        videoList = new ArrayList<>();
		    }
			channel.setVideoList(videoList);
		}
		return "channel/channel_bookmarkList";
	}
	
	@PostMapping("/channel_loadBookmarkList.do")
	public String channel_loadBookmarkList(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "PageSize", defaultValue = "10") int pageSize
	) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = channelService.selectBookmarkChannelList(id, page, pageSize);
		model.addAttribute("channelList", channelList);
		for(ChannelVO channel :channelList) {
			List<VideoVO> videoList = channelService.selectVideoAll(channel.getChannel());
			if (videoList == null) {
		        videoList = new ArrayList<>();
		    }
			channel.setVideoList(videoList);
		}
		
		return "channel/channel_loadBookmarkList";
	}
	
//	즐겨찾기 순서 변경 모달
	@GetMapping("/channel_changeOrder.do")
	public String channel_changeOrder(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
		    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize
    ) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		List<ChannelVO> channelList = channelService.selectBookmarkChannelList(id, page, pageSize);
		model.addAttribute("channelList", channelList);
		return "channel/channel_changeOrder";
	}
	
	@ResponseBody
	@PostMapping("/sortChannel.do")
	public int sortChannel(HttpSession session, int order[]) {
		@SuppressWarnings("unchecked")
		HashMap userData = (HashMap)session.getAttribute("userData");
	    String id = null;
	    if (userData != null && userData.get("id") != null) {
	        id = userData.get("id").toString();
	    }
		int res = 0;
	    int total = order.length;
	    for (int i = 0; i < total; i++) {
	        int rank = total - i;
	        res = channelService.updateChannelOrder(id, order[i], rank);
	    }
		return res;
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
}
