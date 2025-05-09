package egovframework.service;

import java.util.HashMap;
import java.util.List;

public interface ProfileService {
	HashMap selectUserProfile(Integer idx) throws Exception;
	
    void deleteUser(LoginVO input) throws Exception;

    String selectUserDelDate(LoginVO input) throws Exception;

	List<ChannelVO> selectMyChannel(Integer idx, int page, int pageSize);

	UserVO selectMyInfo(String id);
}
