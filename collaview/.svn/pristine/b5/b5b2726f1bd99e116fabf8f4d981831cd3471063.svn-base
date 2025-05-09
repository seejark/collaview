package egovframework.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.service.RecruitVO;
import egovframework.service.ChannelVO;
import egovframework.service.UserVO;
import egovframework.service.VideoVO;

@Mapper("channelMapper")
public interface ChannelMapper {

	int insertChannel(@Param("channelVO") ChannelVO channelVO) throws Exception;

	int selectKey(@Param("key") String key);

	UserVO selectId(@Param("id") String id);

	int selectChannelIdx(@Param("key") String key);

	int insertChanelMember(@Param("channelIdx") int channelIdx, @Param("managerCheck") String managerCheck, @Param("userVO") UserVO userVO) throws Exception;

	ChannelVO selectChannel(@Param("idx") int idx);

	List<UserVO> selectChannelMember(@Param("idx") int idx);

	List<VideoVO> selectVideoList(@Param("idx") int idx, @Param("offset") int offset, @Param("videoPageSize") int videoPageSize);

	List<RecruitVO> selectRecruitList(@Param("idx") int idx);

	int getTotalVideoCount(@Param("idx") int idx);

	int getTotalAplicationCount(@Param("idx") int idx);

	int selectChannelViewCnt(@Param("idx") int idx);

	Double selectAuraAvg(@Param("idx") int idx);

	Double selectSkillAvg(@Param("idx") int idx);

	List<RecruitVO> selectRecruitApplyList(@Param("idx") int idx, @Param("offset") int offset, @Param("applyPageSize") int applyPageSize);

	int deleteMember(@Param("user") String user);

	int updateChannel(@Param("channelVO") ChannelVO channelVO) throws Exception;

	int updateChanelMember(@Param("channelIdx") int channelIdx, @Param("memberId") String memberId, @Param("managerCheck") String managerCheck);

	void deleteAllMembers(@Param("idx") Integer idx);

	int insertBookmark(@Param("idx") int idx, @Param("id") String id, @Param("bookCnt") int bookCnt);

	ChannelVO selectBookmark(@Param("idx") int idx, @Param("id") String id);

	String deleteBookmark(@Param("idx") int idx, @Param("id") String id);

	RecruitVO selectMyApplication(@Param("idx") int idx);

	int updateStatus(@Param("idx") int idx, @Param("processing") String processing);

	List<ChannelVO> selectChannelChart(@Param("offset") int offset, @Param("pageSize") int pageSize);

	List<VideoVO> selectVideoChart(@Param("offset") int offset, @Param("pageSize") int pageSize);

	List<ChannelVO> selectChannelList(@Param("id") String id, @Param("offset") int offset, @Param("pageSize") int pageSize);

	int selectBookmarkCnt(@Param("idx") int idx);

	int selectBookmarkUserCnt(@Param("id") String id);

	int updateChannelDel(@Param("idx") int idx, @Param("id") String id);

	List<ChannelVO> selectBookmarkChannelList(@Param("id") String id, @Param("offset") int offset, @Param("pageSize") int pageSize);

	List<VideoVO> selectVideoAll(@Param("idx") int idx);

	void updateBookmarkOrderBeforeDel(@Param("idx") int idx, @Param("id") String id);

	int updateChannelOrder(@Param("id") String id, @Param("idx") int idx, @Param("order") int order);
}
