<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="/css/video_upload.css">
</head>
<body>
	<jsp:include page="/header.jsp" />
	<main id="container" class="container">
		<div class="wrap">
			<div class="title">카테고리</div>
			<select class="text" name="category">
				<option>자작곡</option>
				<option>뽐내기</option>
				<option>앙상블 챌린지</option>
			</select>
		</div>
		<div class="wrap">
			<div class="title">제목</div>
			<input type="text" name="title" class="text" />
		</div>
		<div class="wrap">
			<div class="title">내용</div>
			<div class="spanTag">
				<textarea name="contents" class="comment" maxlength="80"></textarea>
				<ul class="spanList">
					<li>본 게시판의 성격과 맞지 않는 영상은 예고 없이 삭제될 수 있습니다.</li>
				</ul>
			</div>
		</div>
		<div class="wrap" id="uploadIcon">
			<div class="title">영상</div>
			<div class="thumbnail-group" id="videoUploadIcon">
				<div class="div-wrapper">
					<div class="video-name">example.mp4</div>
				</div>
				<div class="clip-icon">
					<span class="material-symbols-outlined">attach_file</span>
				</div>
				<input type="file" id="videoInput" name="videoFile" accept="video/*"
					style="display: none;">
			</div>
		</div>

		<div class="wrap" id="uploadIcon">
			<div class="title">썸네일</div>
			<div class="thumbnail-group" id="thumbnailUploadIcon">
				<div class="div-wrapper">
					<div class="thumbnail-name">example.jpg</div>
				</div>
				<div class="clip-icon">
					<span class="material-symbols-outlined">attach_file</span>
				</div>
				<input type="file" id="thumbnailInput" name="thumbnail"
					accept="image/*" style="display: none;">
			</div>
		</div>
		
		<div class="wrap" id="peopleWrap" style="display:none">
			<div class="title">인원</div>
			<select class="text" name="people_cnt">
				<option value="7">7명</option>
				<option value="6">6명</option>
				<option value="5">5명</option>
				<option value="4">4명</option>
				<option value="3">3명</option>
				<option value="2">2명</option>
				<option value="1">1명</option>
			</select>
		</div>

		<div class="wrap">
			<div class="keyword-header">
				<div class="title">키워드</div>
				<div class="keyword-edit">
					<span>편집</span> <span class="material-symbols-rounded">keyboard_arrow_right</span>
				</div>
			</div>
			<div class="keyword-wrap"></div>
		</div>

		<div class="button-group">
			<div class="primary" onclick="upload()">
				<div class="title-3">업로드</div>
			</div>
			<div class="title-wrapper" onclick="history.back()">
				<div class="title-3">취소</div>
			</div>
		</div>
	</main>

	<div id="keywordModal" class="modal">
		<div class="modalWrap">
			<span class="close">&times;</span>
			<h2>편집 모달</h2>
			<p>여기에 편집 관련 설정 내용을 입력하세요.</p>
		</div>
	</div>
	<jsp:include page="/footer.jsp" />

	<script>
		function upload() {
			var formDataVar = new FormData();


			var title = $('input[name="title"]').val().trim();
			var contents = $('textarea[name="contents"]').val().trim();

			if (title === '') {
				alert('제목을 입력해주세요');
				$('input[name="title"]').focus();
				return false;
			}
			if (contents === '') {
				alert('내용을 입력해주세요');
				$('textarea[name="contents"]').focus();
				return false;
			}

			var videoInput = $('#videoInput')[0];
			if (!videoInput.files.length) {
				alert('동영상을 업로드해주세요');
				return false;
			}

			var formDataVar = new FormData();
			
			
			formDataVar.append('category', $('select[name="category"]').val());
			formDataVar.append('title', title);
			formDataVar.append('channel', ${idx});
			formDataVar.append('contents', contents);
			formDataVar.append('videoFile', videoInput.files[0]);
			
			var $peopleSelect = $('select[name="people_cnt"]');
			if(!$peopleSelect.prop('disabled')){
				formDataVar.append('people_cnt', $peopleSelect.val());
			}
			
			var thumbFile = $('#thumbnailInput')[0].files[0];
			if (thumbFile != null) formDataVar.append('thumbnail', thumbFile);

			$('.keyword-wrap .keyword').each(function() {
				formDataVar.append('keywords', $(this).text().trim());
			});

			$.ajax({
				url : '/video_upload.do',
				type : 'post',
				data : formDataVar,
				contentType : false,
				processData : false,
				success : function(res) {
					if(res.status != "success"){
						alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요. ");
					}
					else{
						alert('영상 업로드가 완료되었습니다');
						location.href='video_page.do?idx=' + res.idx;
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

		const thumbanilUploadIcon = document
				.getElementById('thumbnailUploadIcon');
		const thumbnailInput = document.getElementById('thumbnailInput');
		const thumbnail_name = document.querySelector('.thumbnail-name');

		thumbanilUploadIcon.addEventListener('click', function() {
			thumbnailInput.click();
		});

		thumbnailInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				thumbnail_name.textContent = file.name;

				const reader = new FileReader();
				reader.readAsDataURL(file);
			}
		});

		$(function() {
			$('.keyword-edit').on('click', function(e) {
				e.preventDefault();
				openModal('/video_keywordEdit.do');
			});

			$(window).on('click', function(e) {
				if (e.target.id === 'keywordModal') {
					closeModal();
				}
			});
		});

		function openModal(url) {
			$('.modalWrap').load(url, function(response, status) {
				if (status === 'error') {
					$('.modalWrap').html('<p>내용을 불러오는데 실패했습니다.</p>');
				}
				$('#keywordModal').show();
				$('#keywordModal .close').on('click', closeModal);
			});
		}

		function closeModal() {
			var selected = [];
			$('#keywordModal .selectKeyword-wrap .selected-keyword').each(
					function() {
						selected.push($(this).data('name') || $(this).text());
					});

			var $main = $('.keyword-wrap').empty();
			for (var i = 0; i < selected.length; i++) {
				$main.append('<div class="keyword">' + selected[i] + '</div>');
			}

			$('#keywordModal').hide();
		}
		
		$(function(){
			var $category = $('select[name="category"]');
			var $people = $('#peopleWrap');
			var $peopleSelect  = $('select[name="people_cnt"]');
			
			function togglePeople(){
				if($category.val() === '앙상블 챌린지'){
					$people.show();
					$peopleSelect.prop('disabled', false);
				}
				else {
					$people.hide();
					$peopleSelect.prop('disabled', true);
				}
			}
		
			togglePeople();
			$category.on('change', togglePeople);
		});
	</script>
</body>
</html>