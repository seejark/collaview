<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    request.setAttribute("userDate", sessionObj.getAttribute("userData"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="/css/profileView.css">
</head>
<body>
	<jsp:include page="/header.jsp"/>
    
    <main class="container" id="container">
        <div class="user">
            <figure class="userImg">
            	<c:if test="${data.profile_file ne null}">
            	<img src="/file/profile/${data.profile_file}" alt="${data.profile_origin}">
            	</c:if>
            </figure>
            <div class="userTxt">
                <strong class="nick">${data.nick}</strong>
                <p class="attitude">Attitude: <fmt:formatNumber value="${empty data.score ? 0 : data.score}" pattern="#0.00"/></p>
            </div>
        </div>

       	<c:if test="${data.email ne null}">
	       	<c:if test="${(data.artist_chk eq 'y' and data.email_ok eq 'y') or data.company_chl eq 'y'}">
	        <div class="email">
	            <p class="tit">이메일</p>
	            <p class="txt">${data.email}</p>
	        </div>
	       	</c:if>
       	</c:if>
       	<c:if test="${data.addr ne null}">
        <div class="addr">
            <p class="tit">주소</p>
            <p class="txt">${data.addr}</p>
        </div>
       	</c:if>
       	<c:if test="${data.history ne null}">
        <div class="history">
            <p class="tit">이력</p>
            <ul class="historyList">
            	<c:forEach items="${data.history}" var="history">
                	<li <c:if test="${data.profile_file != null}">class="file" data-file="${data.profile_file}"</c:if>>
	                	<span>${history.contents}</span>
	                	<em>${history.start_date} ~ ${history.end_date}</em>
	                </li>
                </c:forEach>
            </ul>
        </div>
        </c:if>
        <div class="keyword">
            <p class="tit">관심 분야</p>
            <ul class="keywordList">
            	<c:forEach items="${data.keyword}" var="keyword">
            		<li>${keyword.name}</li>
            	</c:forEach>
            </ul>
        </div>
        <div class="channel">
            <p class="tit">소속 채널</p>
            <div class="channelList">
	            <c:forEach var="channel" items="${channelList}">
	                <a href="/channel_detail.do?idx=${channel.channel}">
	                    <figure class="channelImg"><img src="/file/thumbnail/${channel.thumbnail_file}"></figure>
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
            </div>
        </div>

		<c:if test="${userData.idx eq param.idx}">
        <div class="btnWrap">
            <a href="profile_update.do" class="btn h45 long bc_point edit">수정</a>
            <button type="button" class="btn h45 long bc_555 del">탈퇴</button>
        </div>
		</c:if>
    </main>
    
	<jsp:include page="/footer.jsp"/>



    <div class="modal cancelAccountModal">
        <div class="modalWrap">
            <div class="txtWrap">
                <p class="mb10">회원 탈퇴 시, 30일동안 가입이 제한되며 회원만이 이용 가능한 서비스를 이용하시지 못하게 됩니다.</p>
                <p class="mb10">정말 탈퇴하시겠습니까?</p>
                <p>탈퇴를 원하신다면, 비밀번호를 입력해주세요.</p>
            </div>
            <div class="pw inputBox toggleVisible">
                <input type="password" name="pw">
                <button type="button" class="visible"><span class="material-symbols-rounded">visibility_off</span></button>
                <button type="button" class="nonvisible hidden"><span class="material-symbols-rounded">visibility</span></button>
            </div>
            <div class="btnBox">
                <button type="button" class="btn h45 long bc_point cancelAccount">탈퇴</button>
                <button type="button" class="btn h45 long bc_555 return">취소</button>
            </div>
        </div>
    </div>
    
    
    <script>
	    $(function(){
	    	var data = '${data}';
	        $(document).on('click', '.file', function () {
	            const fileName = $(this).data('file');
	            const fileUrl = '/file/history/' + fileName;
	
	            const a = document.createElement('a');
	            a.href = fileUrl;
	            a.download = fileName;
	            document.body.appendChild(a);
	            a.click();
	            document.body.removeChild(a);
	        });

	        $(".btn.del").click(function(){
		        $(".cancelAccountModal").show();
	        })

	        $(".btn.cancelAccount").click(function(){
            	var params = {
           			id: $("input[name='id']").val(),
             		pw: $("input[name='pw']").val(),
             		auto_chk: false
               	}
               	
   	        	$.ajax({
   	        	    url: "/ajax_login.do",
   	        		type : 'POST',
   	                dataType: "text",
   	                data: params,
   	        	    success: function(result){
   	                	console.log(result);
   	                	
   	        	        if(result == "success"){
   	        	        	$.ajax({
   	        	        	    url: "/ajax_cancelAccount.do",
   	        	        		type : 'POST',
   	        	                dataType: "text",
   	        	                data: {
   	        	                	id: '${userData.id}',
   	                        		pw: $("input[name='pw']").val()
   	        	                },
   	        	        	    success: function(result){
   	        	                	console.log(result);

   	        	        	        if(result == "success"){
   	        	        	        	window.location.href = "/logout.do";
   	        	        	        }else{
   	        	        	        	alert("회원 탈퇴에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
   	        	        	        }
   	        	        	    },
   	        	        	    error: function(xhr, status, error){
   	        	    	        	alert("회원 탈퇴 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
   	        	        	        console.error("AJAX Error:", error);
   	        	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
   	        	        	    }
   	        	        	});
   	        	        	
   	        	        }else if(result == "pwError"){
   	        	        	alert("비밀번호 인증에 실패하였습니다. 비밀번호를 다시 확인해주세요.");
   	        	        }else if(result == "fail"){
   	        	        	alert("비밀번호 인증에 실패하였습니다. 아이디와 비밀번호를 다시 확인해주세요.");
   	        	        }else{
   	        	        	alert("비밀벉호 인증 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
   	        	        }
   	        	    },
   	        	    error: function(xhr, status, error){
           	        	alert("비밀벉호 인증 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
   	        	        console.error("AJAX Error:", error);
   	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
   	        	    }
   	        	});
	        })

	    })
	    
		var currentPage = 1;
		var isLoading = false;
		var hasMoreItems = true;
		
		function loadMoreItems() {
			if(isLoading || !hasMoreItems) return;
			isLoading = true;
			currentPage++;
			
			var url = "/profile_loadChannelList.do";
			
			
			$.ajax({
				url: url,
				method: "post",
				data: { 
					page: currentPage,
					idx : ${param.idx}
				},
				success: function(html) {
				if($.trim(html) === ""){
					hasMoreItems = false;
				} else {
					$(".channelList").append(html);
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
    </script>

</body>
</html>