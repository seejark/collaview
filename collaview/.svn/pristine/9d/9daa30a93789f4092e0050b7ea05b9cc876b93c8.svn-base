package egovframework.service.impl;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.service.ChannelVO;
import egovframework.service.LoginVO;
import egovframework.service.UserVO;

@Mapper("profileMapper")
public interface ProfileMapper {
	HashMap selectUser(Integer idx) throws Exception;
	
	List<HashMap> selectUserHistory(Integer idx) throws Exception;
	
	List<HashMap> selectUserKeyword(Integer idx) throws Exception;
	
	List<HashMap> selectUserArtist(Integer idx) throws Exception;
	
	List<HashMap> selectUserCompany(Integer idx) throws Exception;
	
    void deleteUser(LoginVO input) throws Exception;

    String selectUserDelDate(LoginVO input) throws Exception;

	List<ChannelVO> selectMyChannel(@Param("idx") Integer idx, @Param("offset") int offset, @Param("pageSize") int pageSize);

	UserVO selectMyInfo(@Param("id") String id);
}
