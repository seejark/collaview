package egovframework.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.service.ChannelVO;
import egovframework.service.LoginVO;
import egovframework.service.ProfileService;
import egovframework.service.UserVO;
import egovframework.service.impl.EgovCvMapper;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service("profileService")
public class ProfileServiceImpl extends EgovAbstractServiceImpl implements ProfileService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProfileServiceImpl.class);

	@Resource(name="profileMapper")
	private ProfileMapper profileDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	@Override
	public HashMap selectUserProfile(Integer idx) throws Exception {
		HashMap user = profileDAO.selectUser(idx);
		user.put("history", (List<HashMap>) profileDAO.selectUserHistory(idx));
		user.put("keyword", (List<HashMap>) profileDAO.selectUserKeyword(idx));

		if((String) user.get("artist_chk") ==  "y"){
			user.put("artist", (List<HashMap>) profileDAO.selectUserArtist(idx));
		}
		if((String) user.get("company_chk") == "y"){
			user.put("company", (List<HashMap>) profileDAO.selectUserCompany(idx));
		}
		return user;
	}

	@Override
	public void deleteUser(LoginVO input) throws Exception {
		profileDAO.deleteUser(input);
	}

	@Override
	public String selectUserDelDate(LoginVO input) throws Exception {
		return profileDAO.selectUserDelDate(input);
	}

	@Override
	public List<ChannelVO> selectMyChannel(Integer idx, int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return profileDAO.selectMyChannel(idx, offset, pageSize);
	}
	
	@Override
	public UserVO selectMyInfo(String id) {
		return profileDAO.selectMyInfo(id);
	}

}
