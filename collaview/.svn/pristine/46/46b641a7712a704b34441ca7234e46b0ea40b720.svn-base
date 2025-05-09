<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="/css/reports.css">
</head>
<body>
	<div class="modal-title">신고</div>
	<form id="reportForm" class="reportForm" action="ajax_reportSubmit.do" method="post">
		<div class="report-options">
			<label><input type="radio" name="contents" value="copyright">저작권 침해로 인한 게시 중단 요청(원작자)</label>
			<label><input type="radio" name="contents" value="sexual">성적인 콘텐츠</label>
			<label><input type="radio" name="contents" value="copyright_violation"> 저작권 위반</label>
			<label><input type="radio" name="contents" value="hate">소수자 또는 약자 비하 콘텐츠</label>
		</div>
		<div class="report-other">
			<label><input type="radio" name="contents" value="other" class="other">기타</label> <input type="text" name="otherReason" placeholder="예시" />
		</div>
		<div class="report-email">
	        <input type="checkbox" name="email_chk" id="email" class="emailNotify"/>
	        <label class="title-5" for="email">이메일 알림 설정</label>
		</div>
		<div class="modal-buttons">
			<button type="button" class="btn save" id="btnReportSubmit">접수</button>
			<button type="button" class="btn cancel" onclick="closeReportModal()">취소</button>
		</div>
		<input type="hidden" name="table" id="table" value="${table}">
		<input type="hidden" name="num" id="num" value="${num}">
	</form>

	<script>
		$(function() {
		  $('#btnReportSubmit').on('click', function(e) {
		    e.preventDefault();

		    var $sel = $('input[name="contents"]:checked');
		    if (!$sel.length) {
		      alert('신고 사유를 선택해주세요.');
		      return;
		    }

		    var contentsValue;
		    if ($sel.val() === 'other') {
		      contentsValue = $('input[name="otherReason"]').val().trim();
		      if (!contentsValue) {
		        alert('기타 사유를 입력해주세요.');
		        return;
		      }
		    } else {
		      contentsValue = $sel.closest('label').text().trim();
		    }

		    var data = {
		      contents    : contentsValue,
		      otherReason : $('input[name="otherReason"]').val().trim(),
		      email_chk   : $('input[name="email_chk"]').is(':checked') ? 'on' : '',
		      table       : $('#table').val(),
		      num         : $('#num').val()
		    };

		    $.ajax({
		      url  : $('#reportForm').attr('action'),
		      type : 'post',
		      data : data,
		      success: function(res) {
		        if (res === "notLogin") {
		          alert("로그인 후 사용 가능한 기능입니다.");
		          location.href = "/login.do";
		        } else if (res === "success") {
		          alert('신고가 접수되었습니다.');
		          closeReportModal();
		          location.reload();
		        } else {
		          alert('서버에 오류가 발생하였습니다. 잠시 후 다시 시도해주세요');
		        }
		      },
		      error: function(xhr, status, error) {
		        alert('서버에 오류가 발생하였습니다. 잠시 후 다시 시도해주세요');
		      }
		    });
		  });

		  $('.btn.cancel').on('click', closeReportModal);
		})
	</script>

</body>
</html>