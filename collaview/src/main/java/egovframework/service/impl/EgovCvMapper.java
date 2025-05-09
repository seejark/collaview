package egovframework.service.impl;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.service.FileVO;
import egovframework.service.LoginResultVO;
import egovframework.service.LoginVO;
import egovframework.service.MainBbsVO;
import egovframework.service.MainInputVO;
import egovframework.service.MainVideoVO;
import egovframework.service.ReportsVO;
import egovframework.service.UserInputVO;
import egovframework.service.UserVO;
import egovframework.service.VideoVO;

@Mapper("egovCvMapper")
public interface EgovCvMapper {
	LoginResultVO selectUserLogin(LoginVO input) throws Exception;

	UserVO selectUser(String input) throws Exception;

	List<MainVideoVO> selectMainVideoNoneUser(MainInputVO input) throws Exception;

	List<MainBbsVO> selectMainBbsNoneUser(MainInputVO input) throws Exception;

	int insertUser(UserInputVO input) throws Exception;

	int insertReports(@Param("reportsVO") ReportsVO reportsVO);

	void insertFile(@Param("fileVO") FileVO fileVO);

	VideoVO selectFirstVideo();
}
