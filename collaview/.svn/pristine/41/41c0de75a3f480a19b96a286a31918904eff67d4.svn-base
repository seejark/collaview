package egovframework.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.service.RecruitVO;
import egovframework.service.ChannelService;
import egovframework.service.ChannelVO;
import egovframework.service.UserVO;
import egovframework.service.VideoVO;

@Service("channelService")
public class ChannelServiceImpl implements ChannelService {


	@Resource(name="channelMapper")
	private ChannelMapper channelMapper;

	@Override
	public String insertChannel(ChannelVO channelVO, MultipartFile file) throws Exception {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		String band_chk = channelVO.getBand_chk();
		String recruit_band = channelVO.getRecruit_band();
		String recruit_company = channelVO.getRecruit_company();
		
		channelVO.setBand_chk(band_chk.equals("true") ? "y" : "n");
		channelVO.setRecruit_band(recruit_band.equals("true") ? "y" : "n");
		channelVO.setRecruit_company(recruit_company.equals("true") ? "y" : "n");
		
		int data = channelMapper.insertChannel(channelVO);
		if(data == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	@Override
	public int selectKey(String key) {
		return channelMapper.selectKey(key);
	}
	
	@Override
	public UserVO selectId(String id) {
		return channelMapper.selectId(id);
	}
	
	@Override
	public String insertBandMember(ChannelVO channelVO, String memberId, String managerCheck) throws Exception {
		int channelIdx = channelMapper.selectChannelIdx(channelVO.getKey());
		int result = 0;
		String memberIdArr[] = memberId.split("/");
		String managerCheckArr[] = managerCheck.split("/");
		for(int i = 0; i < memberIdArr.length; i++) {
			UserVO userVO = new UserVO();
			if(managerCheckArr[i].equals("true")) {
				managerCheckArr[i] = "y";
			}
			else {
				managerCheckArr[i] = "n";
			}
			userVO = channelMapper.selectId(memberIdArr[i]);
			result += channelMapper.insertChanelMember(channelIdx, managerCheckArr[i], userVO);
		}
		if(result == 0) {
			return "fail";
		}
		else {
			return "success";
		}
	}
	
	@Override
	public ChannelVO selectChannel(int idx) {
		return channelMapper.selectChannel(idx);
	}
	
	@Override
	public List<UserVO> selectChannelMember(int idx) {
		return channelMapper.selectChannelMember(idx);
	}

	@Override
	public List<VideoVO> selectVideoList(int idx, int videoPage, int videoPageSize) {
		int offset = (videoPage - 1) * videoPageSize;
        return channelMapper.selectVideoList(idx, offset, videoPageSize);
	}

	@Override
	public List<RecruitVO> selectRecruitList(int idx) {
        return channelMapper.selectRecruitList(idx);
	}
	
	@Override
	public List<RecruitVO> selectRecruitApplyList(int idx, int applyPage, int applyPageSize) {
		int offset = (applyPage - 1) * applyPageSize;
		return channelMapper.selectRecruitApplyList(idx, offset, applyPageSize);
	}
	
	@Override
	public int getTotalVideoCount(int idx) {
		return channelMapper.getTotalVideoCount(idx);
	}
	
	@Override
	public int getTotalAplicationCount(int idx) {
		return channelMapper.getTotalAplicationCount(idx);
	}
	
	@Override
	public int selectChannelViewCnt(int idx) {
		return channelMapper.selectChannelViewCnt(idx);
	}
	
	@Override
	public Double selectAuraAvg(int idx) {
		return channelMapper.selectAuraAvg(idx);
	}
	
	@Override
	public Double selectSkillAvg(int idx) {
		return channelMapper.selectSkillAvg(idx);
	}
	
	@Override
	public String deleteMember(String removedMemberIds) {
		String userIds[] = removedMemberIds.split("/");
		int result = 0;
		for(String user : userIds) {
			result += channelMapper.deleteMember(user);
		}
		if(result != 0) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	@Override
	public String updateChannel(ChannelVO channelVO, MultipartFile file) throws Exception {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		String band_chk = channelVO.getBand_chk();
		String recruit_band = channelVO.getRecruit_band();
		String recruit_company = channelVO.getRecruit_company();
		
		channelVO.setBand_chk(band_chk.equals("true") ? "y" : "n");
		channelVO.setRecruit_band(recruit_band.equals("true") ? "y" : "n");
		channelVO.setRecruit_company(recruit_company.equals("true") ? "y" : "n");
		
		if(file != null) {
			channelVO.setThumbnail_origin(file.getOriginalFilename());
			channelVO.setThumbnail_file(file.getOriginalFilename() + "_" + sdf.format(date));
		}
		int data = channelMapper.updateChannel(channelVO);
		if(data == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	@Override
	public String updateBandMember(ChannelVO channelVO, String memberId, String managerCheck) throws Exception {
		int channelIdx = channelMapper.selectChannelIdx(channelVO.getKey());
		int result = 0;
		String memberIdArr[] = memberId.split("/");
		String managerCheckArr[] = managerCheck.split("/");
		for(int i = 0; i < memberIdArr.length; i++) {
			if(managerCheckArr[i].equals("true")) {
				managerCheckArr[i] = "y";
			}
			else {
				managerCheckArr[i] = "n";
			}
			result += channelMapper.updateChanelMember(channelIdx, memberIdArr[i], managerCheckArr[i]);
		}
		if(result == 0) {
			return "fail";
		}
		else {
			return "success";
		}
	}
	@Override
	public void deleteAllMembers(Integer idx) {
		channelMapper.deleteAllMembers(idx);
	}
	
	@Override
	public String insertBookmark(int idx, String id, int bookCnt) {
		int result = channelMapper.insertBookmark(idx, id, bookCnt);
		if(result != 0) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	@Override
	public ChannelVO selectBookmark(int idx, String id) {
		return channelMapper.selectBookmark(idx, id);
	}
	
	@Override
	public String deleteBookmark(int idx, String id) {
		return channelMapper.deleteBookmark(idx, id);
	}
	
	@Override
	public RecruitVO selectMyApplication(int idx) {
		return channelMapper.selectMyApplication(idx);
	}
	
	@Override
	public int updateStatus(int idx, String processing) {
		return channelMapper.updateStatus(idx, processing);
	}
	
	@Override
	public List<ChannelVO> selectChannelChart(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return channelMapper.selectChannelChart(offset, pageSize);
	}
	
	@Override
	public List<VideoVO> selectVideoChart(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return channelMapper.selectVideoChart(offset, pageSize);
	}
	
	@Override
	public List<ChannelVO> selectChannelList(String id, int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return channelMapper.selectChannelList(id, offset, pageSize);
	}
	
	@Override
	public int selectBookmarkCnt(int idx) {
		return channelMapper.selectBookmarkCnt(idx);
	}
	
	@Override
	public int selectBookmarkUserCnt(String id) {
		return channelMapper.selectBookmarkUserCnt(id);
	}

	@Override
	public int updateChannelDel(int idx, String id) {
		return channelMapper.updateChannelDel(idx, id);
	}
	@Override
	public List<ChannelVO> selectBookmarkChannelList(String id, int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return channelMapper.selectBookmarkChannelList(id, offset, pageSize);
	}
	
	@Override
	public List<VideoVO> selectVideoAll(int idx) {
		return channelMapper.selectVideoAll(idx);
	}

	@Override
	public void updateBookmarkOrderBeforeDel(int idx, String id) {
		channelMapper.updateBookmarkOrderBeforeDel(idx, id);
	}
	
	@Override
	public int updateChannelOrder(String id, int idx, int order) {
		return channelMapper.updateChannelOrder(id, idx, order);
	}
}
