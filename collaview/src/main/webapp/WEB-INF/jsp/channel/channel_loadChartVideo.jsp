<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<div class="chart-item wrap" onclick="location.href='/video_page.do?idx=${chart.video}'">
			<div class="chart-item_left">
				<div class="rank">${offset + st.count}</div>
				<img src="/file/video/${chart.thumbnail_file}" alt="${chart.thumbnail_origin}" class="avatar-video"/>
			</div>

			<div class="chart-item_right video">
				<span class="video-name">${chart.title}</span>

				<div class="chart-item-contents">${chart.contents}</div>

				<div class="chart-item-bottom">
					<div class="chart-item_date">
						<span class="material-symbols-outlined">schedule</span>
						<span>${fn: substring(chart.register_date, 0, 10)}</span>
					</div>
					<div class="chart-item_view">
						<span class="material-symbols-outlined">visibility</span>
						<span>${chart.view}</span>
					</div>
					<div class="chart-item_favorites">
						<span class="material-symbols-outlined">bookmarks</span>
						<span>${chart.bookmark}</span>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>