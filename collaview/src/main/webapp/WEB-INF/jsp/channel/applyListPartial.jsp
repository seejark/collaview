<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<c:forEach var="apply" items="${recruit_applyList}">
		<tr>
			<td>${apply.category}</td>
			<td>${apply.title}</td>
			<td>${apply.user}</td>
			<td>${apply.level}</td>
		</tr>
	</c:forEach>
</body>
</html>