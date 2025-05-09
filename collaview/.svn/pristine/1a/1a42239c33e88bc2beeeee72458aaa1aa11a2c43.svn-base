package egovframework.service.impl;

import java.util.List;

import egovframework.service.EgovCvService;
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
import egovframework.service.impl.EgovCvMapper;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service("egovCvService")
public class EgovCvServiceImpl extends EgovAbstractServiceImpl implements EgovCvService {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovCvServiceImpl.class);

	@Resource(name="egovCvMapper")
	private EgovCvMapper egovDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	@Override
	public LoginResultVO selectUserLogin(LoginVO input) throws Exception {
		return (LoginResultVO) egovDAO.selectUserLogin(input);
	}

	@Override
	public UserVO selectUser(String input) throws Exception {
		return (UserVO) egovDAO.selectUser(input);
	}

	@Override
	public List<MainVideoVO> selectMainVideoNoneUser(MainInputVO input) throws Exception {
		return (List<MainVideoVO>) egovDAO.selectMainVideoNoneUser(input);
	}

	@Override
	public List<MainBbsVO> selectMainBbsNoneUser(MainInputVO input) throws Exception {
		return (List<MainBbsVO>) egovDAO.selectMainBbsNoneUser(input);
	}

	@Override
	public int insertUser(UserInputVO input) throws Exception {
		return (int) egovDAO.insertUser(input);
	}
	
	@Override
	public int insertReports(String id, ReportsVO reportsVO) {
		
		reportsVO.setUser(id);
		reportsVO.setCategory("신고");
		if(reportsVO.getEmail_chk().equals("true") || reportsVO.getEmail_chk().equals("on")) {
			reportsVO.setEmail_chk("y");
		}
		else {
			reportsVO.setEmail_chk("n");
		}
		return egovDAO.insertReports(reportsVO);
	}
	
	@Override
	public void insertFile(FileVO fileVO) {
		egovDAO.insertFile(fileVO);
	}

	@Override
	public VideoVO selectFirstVideo() {
		return egovDAO.selectFirstVideo();
	}

}
