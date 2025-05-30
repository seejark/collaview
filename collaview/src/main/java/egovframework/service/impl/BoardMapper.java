package egovframework.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.service.BoardChatVO;
import egovframework.service.BoardVO;
import egovframework.service.ChannelVO;
import egovframework.service.FileVO;
import egovframework.service.RecruitVO;

@Mapper("BoardMapper")
public interface BoardMapper {
	Integer selectBoardTotCnt();
	
    List<BoardVO> selectBoardList(@Param("offset") Integer offset, @Param("boardPageSize") Integer boardPageSize);
    
	int insertRecruit(@Param("boardVO") BoardVO boardVO);

	int insertBoard(@Param("boardVO") BoardVO boardVO);
	
	int selectLastRecruit();

	int selectLastBoard();
	
	List<ChannelVO> selectChannelList(@Param("id") String id);
	
	BoardVO selectBoardDetail(@Param("table") String table, @Param("idx") Integer idx);
	
	List<FileVO> selectBoardFile(@Param("table") String table, @Param("idx") Integer idx);
	
	List<BoardChatVO> selectBoardChat(@Param("idx") Integer idx);

	List<ChannelVO> selectChannelListAll(String id);

	int insertRecruitApply(RecruitVO recruitVO);
}