package egovframework.service;

import java.util.List;



public interface EgovCvService {
	LoginResultVO selectUserLogin(LoginVO input) throws Exception;

	UserVO selectUser(String input) throws Exception;

	List<MainVideoVO> selectMainVideoNoneUser(MainInputVO input) throws Exception ;

	List<MainBbsVO> selectMainBbsNoneUser(MainInputVO input) throws Exception;

	int insertUser(UserInputVO input) throws Exception;

	int insertReports(String id, ReportsVO reportsVO);

	void insertFile(FileVO fileVO);

	VideoVO selectFirstVideo();

}
