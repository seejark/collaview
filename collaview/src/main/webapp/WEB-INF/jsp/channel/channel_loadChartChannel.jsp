<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
	<c:set var="pageSize" value="10" />
	<c:set var="offset" value="${(currentPage - 1) * pageSize}" />
	<c:forEach var="chart" items="${chartList}" varStatus="st">
		<div class="chart-item wrap" onclick="location.href='/channel_detail.do?idx=${chart.channel}'">
			<div class="chart-item_left">
				<div class="rank">${offset + st.count}</div>
				<img src="/file/thumbnail/${chart.thumbnail_file}" alt="${chart.thumbnail_origin}" class="avatar"/>
			</div>

			<div class="chart-item_right">
				<div class="chart-item_channel">
					<span class="channel-name">${chart.ch_name}</span>
					<div class="avatar-small"></div>
				</div>

				<div class="chart-item-key">@${chart.key}</div>

				<div class="chart-item__favorites">
					<span class="material-symbols-outlined">bookmarks</span>
					<span class="bookmark">${chart.bookmark_cnt}</span>
				</div>
				<div class="chart-item-bottom">
					<div class="chart-item__members">채널 멤버:${chart.user}
						<c:if test="${!empty chart.member}">,</c:if>
						${chart.member}
					</div>
					<div class="chart-item__last-upload">마지막 영상 등록일:
						${chart.last_upload}</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>