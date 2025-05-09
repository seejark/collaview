<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="/css/video_emsembleAdd.css">
</head>
<body>
	<jsp:include page="/header.jsp" />
	<main id="container" class="container">
		<div class="wrap">
			<!-- 기능 없음 -->
			<div class="title">현재 챌린지 현황</div>
			<div class="swiper-container">
				<div class="video-list swiper-wrapper">
					<!-- <div class="video-item large swiper-slide"></div> -->
					<!-- <div class="video-item small swiper-slide"></div> -->
					<c:forEach var="file" items="${fileList}">
						<div class="video-item swiper-slide">
							<video src="/file/video/${file.file_name}"></video>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<div class="wrap" id="uploadIcon">
			<div class="title">영상</div>
			<div class="file-group">
				<div class="name-wrapper">
					<div class="video-name">example.mp4</div>
				</div>
				<div class="clip-icon">
					<span class="material-symbols-outlined" id="videoUploadIcon">attach_file</span>
				</div>
				<input type="file" id="videoInput" name="video" accept="video/*"
					style="display: none;">
			</div>
		</div>

		<div class="wrap">
			<div class="title">제목</div>
			<div class="emsembleTitle">${videoVO.title}</div>
		</div>
		<div class="wrap">
			<div class="title">내용</div>
			<div class="spanTag">
				<div class="emsembleContent">${videoVO.contents}</div>
			</div>
		</div>

		<div class="wrap">
			<div class="title">키워드</div>
			<div class="keyword-wrap">
				<c:forEach var="keyword" items="${keywordList}">
					<div class="keyword">${keyword.name}</div>
				</c:forEach>
			</div>
		</div>

		<div class="button-group">
			<div class="upload-btn" onclick="upload()">
				<div class="button-title">업로드</div>
			</div>
			<div class="cancel-btn" onclick="history.back()">
				<div class="button-title">취소</div>
			</div>
		</div>
	</main>
	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
	<script>
		function upload() {
			var formDataVar = new FormData();
	
			var videoInput = $('#videoInput')[0];
			if (!videoInput.files.length) {
				alert('동영상을 업로드해주세요');
				return false;
			}
	
			var formDataVar = new FormData();
			
			
			formDataVar.append('num', ${videoVO.idx});
			formDataVar.append('table', "ch_video");
			formDataVar.append('video', videoInput.files[0]);
	
			$.ajax({
				url : '/video_emsembleAdd.do',
				type : 'post',
				data : formDataVar,
				contentType : false,
				processData : false,
				success : function(res) {
					if(res != "success"){
						alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요. ");
					}
					else{
						alert('영상 업로드가 완료되었습니다');
					}
				},
				error : function(xhr, status, error) {
					alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요. ");
				}
			});
		}
		
		const videoUploadIcon = document.getElementById('videoUploadIcon');
		const videoInput = document.getElementById('videoInput');
		const video_name = document.querySelector('.video-name');
	
		videoUploadIcon.addEventListener('click', function() {
			videoInput.click();
		});
	
		videoInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				video_name.textContent = file.name;
	
				const reader = new FileReader();
				reader.readAsDataURL(file);
			}
		});
		
		document.addEventListener('DOMContentLoaded', function(){
			const mySwiper = new Swiper('.swiper-container', {
				slidesPerView: 'auto',
				spaceBetween: 8,
				freeMode: false,
			});
		});
	</script>
</body>
</html>