<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="/css/channel_application.css">
</head>
<body>
	<jsp:include page="/header.jsp" />

	<main class="container" id="container">
		<div class="recruitCategory">${applicationVO.category}</div>
		<div class="wrap aplication-group">
			<div class="application">
				<div class="application-header">
					<div class="aplication-title">${applicationVO.title}</div>
					<span class="material-symbols-rounded">keyboard_arrow_down</span>
				</div>
				<div class="application-info">
					<div class="avatar"></div>
					<div class="nickname">${manager}</div>
					<div class="date">
						<span class="material-symbols-outlined">schedule</span>
						<div>${fn:substring(applicationVO.start_date, 0, 10)} ~ ${fn:substring(applicationVO.end_date, 0, 10)}</div>
					</div>
				</div>
			</div>
			<div class="hide-contents">
				<div class="channel-contents">${applicationVO.contents}</div>
				<div class="image"></div>
			</div>
		</div>
		<div class="information">
			<div class="recruit-title">신청정보</div>
			<div class="channel-title">
				<div class="channel">채널명</div>
				<div class="channel-name">${channelVO.name}</div>
				<div class="verified-icon channelLevel rank${channelVO.rank}"></div>
			</div>
			<div class="member-group">
				<div class="member-title">멤버</div>
				<div class="member">
					<c:forEach var="user" items="${userList}">
						<div class="member-item">
							<div class="avatar"></div>
							<div class="member-nickname">${user.nick}</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="date-info">
				<div class="date-wrap">
					<div class="date-title">신청일</div>
					<div class="date-content">${fn:substring(applicationVO.register_date, 0, 10)}</div>
				</div>
				<c:if test="${!empty applicationVO.check_date}">
					<div class="date-wrap">
						<div class="date-title">평가일</div>
						<div class="date-content">${fn:substring(applicationVO.check_date, 0, 10)}</div>
					</div>
				</c:if>
				<div class="date-wrap noMargin">
					<div class="date-title">합격여부</div>
					<div class="date-content">${applicationVO.status}</div>
				</div>
			</div>
		</div>
		<ul class="spanList">
			<li>신청일로부터 90일이 지나거나 평가일로부터 30일이 지나면 수집된 개인정보 데이터가 삭제처리됩니다.</li>
		</ul>
		<div class="button-group">
			<button type="button" onclick="processing('합격')" class="passed">합격</button>
			<button type="button" onclick="processing('불합격')" class="failed">불합격</button>
		</div>
	</main>

	<jsp:include page="/footer.jsp" />
	
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const header = document.querySelector('.application-header');
			const arrow = document.querySelector('.application-header .material-symbols-rounded');
			const hideContents = document.querySelector('.hide-contents');
			
			header.addEventListener('click', function() {
				hideContents.classList.toggle('active');
				
				if (hideContents.classList.contains('active')) {
		            arrow.textContent = 'keyboard_arrow_up';
		        } else {
		            arrow.textContent = 'keyboard_arrow_down';
		        }
			});
		});
		
		function processing(processing) {
			if(confirm(processing + "처리 하시겠습니까?")){
				$.ajax({
					url : "/processing.do",
					type : "post",
					data : {
						idx : ${idx},
						processing : processing
					},
					success: function(res) {
						if(res != 1){
							alert(processing + "처리 되었습니다.");
							location.reload();
						}
						else{
							alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요.");
						}
					},
					error: function() {
						alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요.");
					}
				});
			}
		}
		
		function failed() {
			
		}
	</script>
</body>
</html>