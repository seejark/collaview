package egovframework.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.service.FileVO;
import egovframework.service.KeywordVO;
import egovframework.service.MainBbsVO;
import egovframework.service.MainInputVO;
import egovframework.service.MainVideoVO;
import egovframework.service.ReportsVO;
import egovframework.service.UserVO;
import egovframework.service.VideoVO;

@Mapper("videoMapper")
public interface VideoMapper {

	List<KeywordVO> selectKeywordList();
	
	int insertVideo(VideoVO videoVO);

	int selectVideoIdx();

	int insertFile(@Param("id") String id, @Param("table") String table, @Param("videoIdx") int videoIdx, @Param("file_name") String file_name, @Param("origin_name") String origin_name);

	int selectKeywordIdx(@Param("keyword") String keyword);

	void insertKeyword(@Param("videoIdx") int videoIdx, @Param("keywordIdx") int keywordIdx);

	List<KeywordVO> selectMyKeywordList(int idx);

	VideoVO selectVideoInfo(@Param("idx") int idx);

	List<FileVO> selectVideoFile(@Param("idx") int idx);
	
	List<FileVO> selectFileList(@Param("idx") int idx, @Param("table") String table);

	List<MainVideoVO> selectMainVideoNoneUser(MainInputVO input);

	UserVO selectEmsembleDuplication(@Param("id") String id, @Param("num") int num, @Param("table") String table);

	int insertRating(@Param("id") String id, @Param("idx") int idx, @Param("skill") int skill, @Param("manner") int manner, @Param("charisma") int charisma, @Param("perform") int perform);

	UserVO selectRatingCheck(@Param("idx") int idx, @Param("id") String id);

	void insertView(@Param("idx") int idx, @Param("id") String id, @Param("ip") String ip);

	VideoVO selectVideoView(@Param("idx") int idx, @Param("ip") String ip);

	ReportsVO selectReportsCheck(@Param("id") String id, @Param("idx") int idx);

}
