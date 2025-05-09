<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/head.jsp" />
	<link rel="stylesheet" href="/css/channel_list.css">
</head>
<body>
	<jsp:include page="/header.jsp" />
	<main class="container" id="container">
		<button class="createBtn wrap" onclick="location.href='/channel_setting.do'">채널 생성</button>
		<div class="chart-list">
			<c:forEach var="channel" items="${channelList}" varStatus="st">
				<div class="chart-item wrap" onclick="location.href='/channel_self.do?idx=${channel.channel}'">
					<div class="chart-item_left">
						<img src="/file/thumbnail/${channel.thumbnail_file}" alt="${channel.thumbnail_origin}" class="avatar">
					</div>

					<div class="chart-item_right">
						<div class="chart-item_channel">
							<span class="channel-name">${channel.ch_name}</span>
							<div class="avatar-small"></div>
						</div>

						<div class="chart-item-key">@${channel.key}</div>

						<div class="chart-item__favorites">
							<span class="material-symbols-outlined">bookmarks</span>
							<span class="bookmark">${channel.bookmark_cnt}</span>
						</div>
						<div class="bottom-wrap">
							<div class="chart-item__members">채널 멤버:${channel.user}
								<c:if test="${!empty channel.member}">,</c:if>
								${channel.member}
							</div>
							<div class="chart-item__last-upload">마지막 영상 등록일: ${channel.last_upload}</div>
						</div>
					</div>
					<c:if test="${!channel.isMember}">
						<span class="leave material-symbols-outlined" onclick="stopPropagation(event); channel_del(${channel.channel})">delete</span>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</main>
	<jsp:include page="/footer.jsp" />
	<script>
		var currentType = "channel";
		var currentPage = 1;
		var isLoading = false;
		var hasMoreItems = true;
		
		$(".channel-select").addClass('selected');
		
		function loadMoreItems() {
			if(isLoading || !hasMoreItems) return;
			isLoading = true;
			currentPage++;
			
			var url = "/channel_loadChannelList.do";
			
			
			$.ajax({
				url: url,
				method: "post",
				data: { page: currentPage },
				success: function(html) {
				if($.trim(html) === ""){
					hasMoreItems = false;
				} else {
					console.log(html);
					$(".chart-list").append(html);
				}
					isLoading = false;
				},
				error: function(xhr, status, error) {
					console.error("Error loading items:", error);
					isLoading = false;
				}
			});
		}
		
		$(window).scroll(function() {
			if($(window).scrollTop() + $(window).height() >= $(document).height() - 100){
				loadMoreItems();
			}
		});
		
		function channel_del(idx) {
			if(confirm("채널을 탈퇴하시겠습니까?")){
				$.ajax({
					url : "/channel_userDel.do",
					type : "post",
					data : {
						idx : idx
					},
					success: function(res) {
						console.log(res);
						if(res != 0){
							location.reload();
						}
						else{
							alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요");
						}
					},
					error: function() {
						alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요");
					}
				});
			}
		}
		
	  	function stopPropagation(event) {
			event.stopPropagation();
		}
	</script>
</body>
</html>