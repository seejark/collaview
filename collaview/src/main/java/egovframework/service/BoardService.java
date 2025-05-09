package egovframework.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BoardService {
	Integer selectBoardTotCnt();

    List<BoardVO> selectBoardList(Integer offset, Integer boardPageSize);

	int insertBoard(BoardVO boardVO);

	int selectLastPost(BoardVO boardVO);

	List<ChannelVO> selectChannelList(String id);
	
	BoardVO selectBoardDetail(String table, Integer idx);
	
	List<FileVO> selectBoardFile(String table, Integer idx);
	
	List<BoardChatVO> selectBoardChat(Integer idx);

	List<ChannelVO> selectChannelListAll(String id);
	
	int insertRecruitApply(RecruitVO recruitVO);
	
}