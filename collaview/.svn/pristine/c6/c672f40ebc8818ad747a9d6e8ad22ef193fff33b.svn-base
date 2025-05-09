<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:forEach var="video" items="${videoList}">
    <div class="video-item" data-date="${video.register_date}" data-view="${video.view}">
        <div class="video-thumbnail"></div>
        <div class="video-info">
            <div class="video-title">${video.title}</div>
            <ul class="video-meta">
                <li>${fn:substring(video.register_date.toString(), 0, 10)}</li>
                <li>${video.view}</li>
            </ul>
        </div>
    </div>
</c:forEach>
