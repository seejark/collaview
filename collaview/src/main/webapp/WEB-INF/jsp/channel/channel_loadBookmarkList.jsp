<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:forEach var="channel" items="${channelList}">
		<div class="bookmark-group wrap">
			<div class="channel-info"
				onclick="location.href='/channel_detail.do?idx=${channel.channel}'">
				<div class=avatar></div>
				<div>
					<strong class="channel-name">${channel.ch_name}</strong>
					<p class="favorites">
						<span class="material-symbols-outlined">bookmarks</span> <span
							class="bookmark">${channel.bookmark_cnt}</span>
					</p>
				</div>
			</div>
			<div class="swiper-container swiperHidden">
				<div class="swiper-wrapper video-list">
					<c:forEach var="video" items="${channel.videoList}">
						<div class="video-wrap swiper-slide">
							<div class="video-title">${video.title}</div>
							<div class="avatar-video"></div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>