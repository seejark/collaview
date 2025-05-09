<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="/css/login.css">
</head>
<body>
    <main class="container" id="container">
        <figure class="logo"><img src="/images/logo.png" alt="콜라뷰"></figure>
        <div class="input id">
            <p class="inputTit">아이디</p>
            <input type="text" class="inputBox" name="id">
        </div>
        <div class="input pw">
            <p class="inputTit">비밀번호</p>
            <div class="inputBox toggleVisible">
                <input type="password" name="pw">
                <button type="button" class="visible"><span class="material-symbols-rounded">visibility_off</span></button>
                <button type="button" class="nonvisible hidden"><span class="material-symbols-rounded">visibility</span></button>
            </div>
        </div>
        <div class="autoLogin">
            <input type="checkbox" class="check" id="autoLogin" checked>
            <label for="autoLogin" class="checkBox"><span class="material-symbols-rounded">check</span></label>
            <label for="autoLogin" class="checkLabel">자동 로그인</label>
        </div>
        <button type="button" class="btn h50 long bc_555 login">로그인</button>
        <a href="/signup.do" class="btn h50 long bc_555 signup">회원가입</a>
    </main>
    
	<jsp:include page="/footer.jsp"/>

    <script>
        $(function(){
            $(".visible").click(function(){
                $("input[name='pw']").attr("type", "text");
                $(".visible").addClass("hidden");
                $(".nonvisible").removeClass("hidden");
            })
            
            $(".nonvisible").click(function(){
                $("input[name='pw']").attr("type", "password");
                $(".visible").removeClass("hidden");
                $(".nonvisible").addClass("hidden");
            })
            
        	$('input[name="id"], input[name="pw"]').on('keypress', function(e){
				if(e.keyCode == '13'){
					formSend();
				}
        	});

            $(".btn.login").click(function(){
        		formSend();
            })
            
            function formSend(){
            	var params = {
           			id: $("input[name='id']").val(),
           			pw: $("input[name='pw']").val(),
           			auto_chk: $("#autoLogin").is(":checked")
            	}
            	
	        	$.ajax({
	        	    url: "/ajax_login.do",
	        		type : 'POST',
	                dataType: "text",
	                data: params,
	        	    success: function(result){
	                	console.log(result);
	                	
	        	        if(result == "success"){
	        	        	window.location.href = "/index.do";
	        	        }else if(result == "pwError"){
	        	        	alert("로그인에 실패하였습니다. 비밀번호를 다시 확인해주세요.");
	        	        }else if(result == "fail"){
	        	        	alert("로그인에 실패하였습니다. 아이디와 비밀번호를 다시 확인해주세요.");
	        	        }else{
	        	        	alert("로그인 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
	        	        }
	        	    },
	        	    error: function(xhr, status, error){
        	        	alert("로그인 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
	        	        console.error("AJAX Error:", error);
	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
	        	    }
	        	});
            }
            
        })
    </script>

</body>
</html>