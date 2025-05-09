<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<%
    HttpSession sessionObj = request.getSession(false);
    boolean isLoggedIn = (sessionObj != null && sessionObj.getAttribute("userData") != null);
%>


	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Collaview</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/support.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    
    <script>
    	$(function(){
    		/* 자동 로그인 프로세스 - S */
            let isLoggedIn = <%= (session.getAttribute("userData") != null) ? "true" : "false" %>;
            
            if (!isLoggedIn) {
		        let autoLoginToken = '<%
					Cookie[] cookies = request.getCookies();
		            if (cookies != null) {
		                for (Cookie cookie : cookies) {
		                    if ("autoLoginToken".equals(cookie.getName())) {
		                        out.print(URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8.name()));
		                        break;
		                    }
		                }
		            }
		        %>'; // document.cookie로 받아오면 오류 발생함.
	
		        if (autoLoginToken) {
			        $.ajax({
			            url: "/ajax_autoLogin.do",
			            type: "GET",
			            success: function(response) {
			                if (response === "success") {
		        	        	location.reload();
			                } else {
		        	        	alert("자동 로그인 과정에서 오류가 발생하였습니다. 페이지를 새로고침해주세요.");
			                }
			            },
			            error: function(xhr, status, error) {
	        	        	alert("자동 로그인 과정에서 오류가 발생하였습니다. 페이지를 새로고침해주세요.");
			                console.error("자동 로그인 체크 중 오류 발생:", error);
			            }
			        });
		        }
            }
    		/* 자동 로그인 프로세스 - E */
	    });
    </script>