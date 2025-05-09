package egovframework.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

public interface ChannelService {

	String insertChannel(ChannelVO channelVO, MultipartFile file) throws Exception;

	int selectKey(String key);

	UserVO selectId(String id);

	String insertBandMember(ChannelVO channelVO, String memberId, String managerCheck) throws Exception;

	ChannelVO selectChannel(int idx);

	List<UserVO> selectChannelMember(int idx);

	List<VideoVO> selectVideoList(int idx, int videoPage, int videoPageSize);

	List<RecruitVO> selectRecruitList(int idx);

	int getTotalVideoCount(int idx);

	int getTotalAplicationCount(int idx);

	int selectChannelViewCnt(int idx);

	Double selectAuraAvg(int idx);

	Double selectSkillAvg(int idx);

	List<RecruitVO> selectRecruitApplyList(int idx, int applyPage, int applyPageSize);

	String deleteMember(String removedMemberIds);

	String updateChannel(ChannelVO channelVO, MultipartFile file) throws Exception;

	String updateBandMember(ChannelVO channelVO, String memberId, String managerCheck) throws Exception;

	void deleteAllMembers(Integer idx);

	String insertBookmark(int idx, String id, int bookCnt);

	ChannelVO selectBookmark(int idx, String id);

	String deleteBookmark(int idx, String id);

	RecruitVO selectMyApplication(int idx);

	int updateStatus(int idx, String processing);

	List<ChannelVO> selectChannelChart(int page, int pageSize);

	List<VideoVO> selectVideoChart(int page, int pageSize);

	List<ChannelVO> selectChannelList(String id, int page, int pageSize);

	int selectBookmarkCnt(int idx);

	int selectBookmarkUserCnt(String id);
	
	int updateChannelDel(int idx, String id);

	List<ChannelVO> selectBookmarkChannelList(String id, int page, int pageSize);

	List<VideoVO> selectVideoAll(int idx);

	void updateBookmarkOrderBeforeDel(@Param("idx") int idx, @Param("id") String id);

	int updateChannelOrder(String id, int idx, int order);

}
