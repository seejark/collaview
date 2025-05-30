package egovframework.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.service.FileVO;
import egovframework.service.KeywordVO;
import egovframework.service.MainBbsVO;
import egovframework.service.MainInputVO;
import egovframework.service.MainVideoVO;
import egovframework.service.ReportsVO;
import egovframework.service.UserVO;
import egovframework.service.VideoService;
import egovframework.service.VideoVO;

@Service("videoService")
public class VideoServiceImpl implements VideoService {

	@Resource(name="videoMapper")
	private VideoMapper videoMapper;
	
	@Override
	public List<KeywordVO> selectKeywordList() {
		return videoMapper.selectKeywordList();
	}
	
	@Override
	public int insertVideo(VideoVO videoVO, MultipartFile video, MultipartFile thumbnail, String uploadDir)
			throws IllegalStateException, IOException {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		String savedName;
        if (!thumbnail.isEmpty()) {
            String originalName = thumbnail.getOriginalFilename();
            long unixTimestamp = System.currentTimeMillis() / 1000L;
            savedName = unixTimestamp + "_" + videoVO.getUser() + "_" + originalName;

            File saveFile = new File(uploadDir, savedName);
            thumbnail.transferTo(saveFile); // 파일 전송
            
	        videoVO.setThumbnail_origin(originalName);
	        videoVO.setThumbnail_file(savedName);
        }
        
	    return videoMapper.insertVideo(videoVO);
	}
	@Override
	public int selectVideoIdx() {
		return videoMapper.selectVideoIdx();
	}
	
	@Override
	public int insertFile(String id, Integer num, MultipartFile video, String table, String uploadDir)
			throws IllegalStateException, IOException {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		String file_name;
        if (!video.isEmpty()) {
        	String origin_name = video.getOriginalFilename();
            long unixTimestamp = System.currentTimeMillis() / 1000L;
            file_name = unixTimestamp + "_" + id + "_" + origin_name;

            File saveFile = new File(uploadDir, file_name);
            video.transferTo(saveFile); // 파일 전송
        	return videoMapper.insertFile(id, table, num, file_name, origin_name);
        }else {
        	return 0;
        }
	}
	
	@Override
	public int insertKeyword(List<String> keywords) {
		int videoIdx = videoMapper.selectVideoIdx();
		
		for(String keyword : keywords) {
			int keywordIdx = videoMapper.selectKeywordIdx(keyword);
			videoMapper.insertKeyword(videoIdx, keywordIdx);
		}
		return 1;
	}
	
	@Override
	public List<KeywordVO> selectMyKeywordList(int idx) {
		return videoMapper.selectMyKeywordList(idx);
	}
	
	@Override
	public VideoVO selectVideoInfo(int idx) {
		return videoMapper.selectVideoInfo(idx);
	}
	
	@Override
	public List<FileVO> selectVideoFile(int idx) {
		return videoMapper.selectVideoFile(idx);
	}
	
	@Override
	public List<FileVO> selectFileList(int idx, String table) {
		return videoMapper.selectFileList(idx, table);
	}
	
	@Override
	public List<MainVideoVO> selectMainVideoNoneUser(MainInputVO input) {
		return videoMapper.selectMainVideoNoneUser(input);
	}
	
	@Override
	public UserVO selectEmsembleDuplication(String id, int num, String table) {
		return videoMapper.selectEmsembleDuplication(id, num, table);
	}
	
	@Override
	public String insertRating(String id, int idx, int skill, int manner, int charisma, int perform) {
		int res = videoMapper.insertRating(id, idx, skill, manner, charisma, perform);
		if(res != 0) {
			return "success";
		}
		else {
			return "false";
		}
	}
	
	@Override
	public UserVO selectRatingCheck(int idx, String id) {
		return videoMapper.selectRatingCheck(idx, id);
	}
	
	@Override
	public void insertView(int idx, String id, String ip) {
		videoMapper.insertView(idx, id, ip);
	}
	
	@Override
	public VideoVO selectVideoView(int idx, String ip) {
		return videoMapper.selectVideoView(idx, ip);
	}
	
	@Override
	public ReportsVO selectReportsCheck(String id, int idx) {
		return videoMapper.selectReportsCheck(id, idx);
	}
	
}
