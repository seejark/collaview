<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ko">
<head>
</head>
<body>
	<c:forEach var="channel" items="${channelList}">
		<a href="/channel_detail.do?idx=${channel.channel}">
		    <figure class="channelImg"><img src="/file/board/${channel.thumbnail_file}"></figure>
		    <div class="channelTxt">
		        <div class="channelTitBox">
		            <p class="channelName">${channel.ch_name}</p>
		            <span class="channelLevel"></span>
		        </div>
		        <ul class="channelTxtBox">
		            <li>직책: ${channel.admin}</li>
		            <li>소속일: ${fn: substring(channel.register_date, 0, 10)}</li>
		            <li>리더: ${channel.leader}</li>
		        </ul>
		    </div>
		</a>
	</c:forEach>
</body>
</html>