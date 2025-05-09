<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:forEach var="channel" items="${channelList}" varStatus="st">
		<div class="chart-item wrap" onclick="location.href='/channel_self.do?idx=${channel.channel}'">
			<div class="chart-item_left">
				<img src="/file/thumbnail/${channel.thumbnail_file}" alt="${channel.thumbnail_file}" class=avatar>
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
</body>
</html>