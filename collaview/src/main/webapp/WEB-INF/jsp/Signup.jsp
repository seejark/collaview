<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="/css/signup.css">
</head>
<body>
	<jsp:include page="/header.jsp"/>

    <main class="container" id="container">
        <div class="content">
            <div class="input id required">
                <p class="inputTit">아이디</p>
                <div class="inputWrap spanTag">
                	<div>
	                    <input type="text" class="inputBox" name="id" maxlength="15" minlength="5" required>
	                    <input type="hidden" class="hidden" id="idCheck" name="idCheck" value="false">
	                    <button type="button" class="btn h40 bc_555 idCheck" id="idCheckBtn">중복체크</button>
                	</div>
                    <ul class="spanList">
                        <li>아이디는 이후 변경이 불가합니다.</li>
                        <li>최소 5글자 이상, 최대 15글자 내로 입력해주세요.</li>
                        <li>아이디는 소문자 영어와 숫자, !@#$%^&*_-만 사용이 가능합니다.</li>
                    </ul>
                </div>
            </div>
            <div class="input pw required">
                <p class="inputTit">비밀번호</p>
                <div class="inputWrap spanTag">
                    <div class="inputBox toggleVisible">
                        <input type="password" name="pw" minlength="5" required>
                        <button type="button" class="visible"><span class="material-symbols-rounded">visibility_off</span></button>
                        <button type="button" class="nonvisible hidden"><span class="material-symbols-rounded">visibility</span></button>
                    </div>
                    <ul class="spanList">
                        <li>최소 5글자 이상으로 입력해주세요.</li>
                        <li>비밀번호는 소문자 영어와 숫자, !@#$%^&*_-만 사용이 가능합니다.</li>
                    </ul>
                </div>
            </div>
            <div class="input pwCheck required">
                <p class="inputTit">비밀번호 확인</p>
                <div class="inputWrap spanTag">
                    <div class="inputBox toggleVisible">
                        <input type="password" name="pwCheck" required>
                        <button type="button" class="visible"><span class="material-symbols-rounded">visibility_off</span></button>
                        <button type="button" class="nonvisible hidden"><span class="material-symbols-rounded">visibility</span></button>
                    </div>
                    <ul class="spanList">
                        <li class="pwNotEqual hidden tc_red">비밀번호가 동일하지 않습니다.</li>
                    </ul>
                </div>
            </div>
            <div class="input name required">
                <p class="inputTit">이름</p>
                <input type="text" class="inputBox" name="name" maxlength="20" required>
            </div>
            <div class="input nick required">
                <p class="inputTit">닉네임</p>
                <div class="spanTag">
	                <input type="text" class="inputBox" name="nick" maxlength="20" required>
	                <ul class="spanList">
	                    <li>닉네임은 한글과 대문자/소문자 영어, 숫자, !@#$%^&*_-만 사용이 가능합니다.</li>
	                </ul>
                </div>
            </div>
            <div class="input email required">
                <p class="inputTit">이메일</p>
                <div class="inputWrap">
                    <div class="inputFlexBox">
                        <input type="text" class="inputBox" name="email1" required>
                        <span>@</span>
                        <div class="select email2" data-select="email">
                            <div class="inputBox selectBox">
                                <input type="hidden" class="selectValue hidden" name="email2" value="" required>
                                <p class="selectText"></p>
                                <span class="material-symbols-outlined">arrow_drop_down</span>
                            </div>
                            <div class="selectListWrap">
                                <ul class="selectList">
                                    <li data-value="naver.com">naver.com</li>
                                    <li data-value="gmail.com">gmail.com</li>
                                    <li data-value="kakao.com">kakao.com</li>
                                    <li data-value="daum.net">daum.net</li>
                                    <li data-value="etc">기타</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <input type="text" class="inputBox hidden" name="emailEtc">
                </div>
            </div>
            <div class="input phone required">
                <p class="inputTit">전화번호</p>
                <div class="inputWrap">
                    <input type="text" class="inputBox" name="phone1" maxlength="3" minlength="3" required>
                    <span></span>
                    <input type="text" class="inputBox" name="phone2" maxlength="4" minlength="4" required>
                    <span></span>
                    <input type="text" class="inputBox" name="phone3" maxlength="4" minlength="4" required>
                </div>
            </div>
            <div class="input birth">
                <p class="inputTit">생년월일</p>
                <div class="inputWrap">
                    <div class="year">
                        <div class="select textCenter birthYear">
                            <div class="inputBox selectBox">
                                <input type="hidden" class="selectValue hidden" name="birthYear" value="" required>
                                <p class="selectText"></p>
                                <span class="material-symbols-outlined">arrow_drop_down</span>
                            </div>
                            <div class="selectListWrap">
                                <ul class="selectList">
                                </ul>
                            </div>
                        </div>
                        <span>년</span>
                    </div>
                    <div class="month">
                        <div class="select textCenter birthMonth">
                            <div class="inputBox selectBox">
                                <input type="hidden" class="selectValue hidden" name="birthMonth" value="" required>
                                <p class="selectText"></p>
                                <span class="material-symbols-outlined">arrow_drop_down</span>
                            </div>
                            <div class="selectListWrap">
                                <ul class="selectList">
                                    <li data-value="1">1</li>
                                    <li data-value="2">2</li>
                                    <li data-value="3">3</li>
                                    <li data-value="4">4</li>
                                    <li data-value="5">5</li>
                                    <li data-value="6">6</li>
                                    <li data-value="7">7</li>
                                    <li data-value="8">8</li>
                                    <li data-value="9">9</li>
                                    <li data-value="10">10</li>
                                    <li data-value="11">11</li>
                                    <li data-value="12">12</li>
                                </ul>
                            </div>
                        </div>
                        <span>월</span>
                    </div>
                    <div class="day">
                        <input type="text" class="inputBox" name="birthDay" maxlength="2">
                        <span>일</span>
                    </div>
                </div>
            </div>
            <div class="input profile">
                <p class="inputTit">프로필 사진</p>
                <div class="profile_file">
                    <input type="file" class="hidden" id="profile" name="profile" accept="image/*">
                    <label for="profile" class="inputBox"></label>
                    <label for="profile" class="btn h40 bc_555"><span class="material-symbols-rounded">attach_file</span></label>
                </div>
                <figure class="profile_preview autoSetWH"><img class="profile_previewImg autoSetWHImg" src="" alt="미리보기 이미지"></figure>
            </div>
            <div class="chk required">
                <p class="inputTit">약관 동의</p>
                <div class="privacy checkWrap">
                    <label for="privacy_chk" class="checkLabel">
                        <p>개인정보수집 동의</p>
                        <input type="checkbox" class="check" id="privacy_chk" name="privacy_chk">
                        <figure class="checkBox">
                            <span class="material-symbols-rounded">check</span>
                        </figure>
                    </label>
                    <div class="checkContent">
                        <p class="checkText">선거에 관한 경비는 법률이 정하는 경우를 제외하고는 정당 또는 후보자에게 부담시킬 수 없다. 국토와 자원은 국가의 보호를 받으며, 국가는 그 균형있는 개발과 이용을 위하여 필요한 계획을 수립한다. 지방의회의 조직·권한·의원선거와 지방자치단체의 장의 선임방법 기타 지방자치단체의 조직과 운영에 관한 사항은 법률로 정한다. 국방상 또는 국민경제상 긴절한 필요로 인하여 법률이 정하는 경우를 제외하고는, 사영기업을 국유 또는 공유로 이전하거나 그 경영을 통제 또는 관리할 수 없다. 선거운동은 각급 선거관리위원회의 관리하에 법률이 정하는 범위안에서 하되, 균등한 기회가 보장되어야 한다.</p>
                    </div>
                </div>
                <div class="terms checkWrap">
                    <label for="terms_chk" class="checkLabel">
                        <p>이용약관 동의</p>
                        <input type="checkbox" class="check" id="terms_chk" name="terms_chk">
                        <figure class="checkBox">
                            <span class="material-symbols-rounded">check</span>
                        </figure>
                    </label>
                    <div class="checkContent">
                        <p class="checkText">선거에 관한 경비는 법률이 정하는 경우를 제외하고는 정당 또는 후보자에게 부담시킬 수 없다. 국토와 자원은 국가의 보호를 받으며, 국가는 그 균형있는 개발과 이용을 위하여 필요한 계획을 수립한다. 지방의회의 조직·권한·의원선거와 지방자치단체의 장의 선임방법 기타 지방자치단체의 조직과 운영에 관한 사항은 법률로 정한다. 국방상 또는 국민경제상 긴절한 필요로 인하여 법률이 정하는 경우를 제외하고는, 사영기업을 국유 또는 공유로 이전하거나 그 경영을 통제 또는 관리할 수 없다. 선거운동은 각급 선거관리위원회의 관리하에 법률이 정하는 범위안에서 하되, 균등한 기회가 보장되어야 한다.</p>
                    </div>
                </div>
            </div>
        </div>
	    <div class="btnBox">
			<button type="button" class="btn signup h45 long bc_point">가입</button>
	    	<button type="button" class="btn cancle h45 long bc_555">취소</button>
    	</div>
    </main>

	<jsp:include page="/footer.jsp"/>

    <script>
        $(function(){
            init(); // 초기화

            $(window).resize(function(){
                init();
            })

            $("#idCheckBtn").click(function(){
            	// 아이디 중복확인
	        	var params = {id: $("input[name='id']").val()}

            	if(params['id'] != ""){
    	        	$.ajax({
    	        	    url: "/ajax_idCheck.do",
    	        		type : 'POST',
    	                dataType: "text",
    	                data: params,
    	        	    success: function(result){
    	        	        if(result == "success"){
    	        	        	if(confirm("해당 아이디는 사용이 가능합니다. 사용하시겠습니까?")){
    	        	        		$("input[name='idCheck']").val(true);
    	        	        	}else{
    	        	        		$("input[name='idCheck']").val(false);
    	        	        	}
    	        	        }else{
            	        		$("input[name='idCheck']").val(false);

    	        	        	if(result == "cannot"){
    		        	        	alert("이미 존재하는 아이디입니다.");
    		        	        }else{
    		        	        	alert(" 데이터 통신에 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
    		        	        }
    	        	        }
    	        	    },
    	        	    error: function(xhr, status, error){
    	    	        	alert("서버 통신에 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
    	        	        console.error("AJAX Error:", error);
    	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
    	        	    }
    	            })
            	}
            })

            $("input[name='id']").on('input', function(){
            	// 값 변경 시 중복확인 취소
        		$("input[name='idCheck']").val(false);
            })

            /* 비밀번호와 비밀번호 확인 값 체크 - S */
            $("input[name='pw']").on("input", function(){
                pwCheck();
            })
            $("input[name='pwCheck']").on("input", function(){
                pwCheck();
            })
            /* 비밀번호와 비밀번호 확인 값 체크 - E */

            $(".checkLabel .check").click(function(){
                // 약관동의 체크박스 값 변경 되면 해당 약관 hide/show
                if($(this).prop("checked")){
                    $(this).parents(".checkWrap").find(".checkContent").stop().slideUp(300);
                }else{
                    $(this).parents(".checkWrap").find(".checkContent").stop().slideDown(300);
                }
            })


            /* 파일 미리보기 - S */
            $('#profile').on('change', function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        $('.profile_previewImg').attr('src', e.target.result).show();
                    }
                    reader.readAsDataURL(file);
                    
                    $('.profile .inputBox').text(file.name); // 파일명 텍스트 넣어주기
                    
                } else {
                    $('.profile_previewImg').attr('src', '').hide();
                    
                    $('.profile .inputBox').text("");
                }
            });
            /* 파일 미리보기 - E */


            /* 폼 전송 - S */
            $(".btn.signup").click(function(){
            	var required = false;
                $("input:required").each(function(index, element) {
                    var value = $(element).val();
                    var minlength = $(element).attr("minlength");
                	if(value == "" || value == undefined || value == null){
                    	// 필수 입력칸 확인
                    	valueAlert(element, "입력되지 않은 값이 있습니다. 필수 입력칸을 모두 채워주세요.");
                    	return false; // for문 종료
                    }else if(minlength != "" || minlength != undefined || minlength != null){
                    	// 최소 글자수 확인
                    	if(value.length < minlength){
	                    	required = true;
	                    	valueAlert(element, "최소 " + minlength + "글자 입력 바랍니다.");
	                    	return false; // for문 종료
                    	}
                    }
                });

                if(required) return; // 현재 함수 종료

                if($("#privacy_chk").prop("checked") == false || $("#privacy_chk").prop("checked") == "false"){
                	valueAlert("#privacy_chk", "개인정보수집에 동의해주세요.");
                    return; // 현재 함수 종료
                }
                if($("#terms_chk").prop("checked") == false || $("#terms_chk").prop("checked") == "false"){
                	valueAlert("#terms_chk", "이용약관에 동의해주세요.");
                    return; // 현재 함수 종료
                }
                
                if($("#idCheck").val() == false || $("#idCheck").val() == "false"){
                	valueAlert("input[name='id']", "아이디 중복 체크를 진행해주세요.");
                    return; // 현재 함수 종료
                }
                
                if(!$(".pwNotEqual").hasClass("hidden")){
                	valueAlert("input[name='pwCheck']", "비밀번호가 동일하지 않습니다. 비밀번호 확인을 다시 입력해주세요.");
                    return; // 현재 함수 종료
                }

                var email = $("input[name='email1']").val();
                if($("input[name='email2']").val() != "etc") email += "@" + $("input[name='email2']").val()
                else email += "@" + $("input[name='emailEtc']").val()

                var phone = $("input[name='phone1']").val() + "-" + $("input[name='phone2']").val() + "-" + $("input[name='phone3']").val();

                var birth;
                var birthDay = $("input[name='birthDay']").val();
                if(birthDay != null && birthDay != undefined)
                    birth = $("input[name='birthYear']").val() + "-" + $("input[name='birthMonth']").val() + "-" + birthDay;

                var privacy_chk, terms_chk;
                if($("input[name='privacy_chk']").attr("checked") == 'true') privacy_chk = 'y'
                else privacy_chk = 'n';
                if($("input[name='terms_chk']").attr("checked") == 'true') terms_chk = 'y'
                else terms_chk = 'n';
                
			    var formData = new FormData();
			    formData.append("id", $("input[name='id']").val());
			    formData.append("pw", $("input[name='pw']").val());
                formData.append("name", $("input[name='name']").val());
                formData.append("nick", $("input[name='nick']").val());
                formData.append("phone", phone);
                formData.append("birth", birth);
                formData.append("email", email);
			    formData.append("profile", $("input[name='profile']")[0].files[0]);
                formData.append("privacy_chk", privacy_chk);
                formData.append("terms_chk", terms_chk);

                /* for (var pair of formData.entries()) {
                    console.log(pair[0]+ ': ' + pair[1]);
                } */

            	$.ajax({
            	    url: "/ajax_signup.do",
            		type : 'POST',
                    dataType: "text",
                    data: formData,
                    processData: false,
                    contentType: false,
            	    success: function(result){
            	    	console.log(result);
            	        if(result == "success"){
            	        	window.location.href = "/login.do";
            	        }else if(result == "error"){
            	        	alert("회웍가입에 실패하였습니다. 새로고침 후 다시 시도해주세요.");
            	        }
            	    },
            	    error: function(xhr, status, error){
        	        	alert("회원가입 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
            	        console.error("AJAX Error:", error);
            	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
            	    }
            	});
            })
            /* 폼 전송 - E */

            $(".btn.cancle").click(function(){
            	if(confirm("지금 취소하신다면 입력하신 데이터는 사라집니다. 정말 취소하시겠습니까?")){
            		window.history.back();
            	}
            })
        })

        function init(){ // 초기에 필요한 코드들
            /* 현재 연도로부터 100년까지 생년월일 select에 추가 - S */
            const currentYear = new Date().getFullYear();
            for (let year = currentYear; year >= currentYear - 100; year--) {
                var $li = $("<li></li>");
                $li.text(year).attr("data-value", year);
                $(".birthYear").find(".selectList").append($li);
            }
            selectInit($(".birthYear")); // select 초기화
            /* 현재 연도로부터 100년까지 생년월일 select에 추가 - E */
        }
        
        function pwCheck(){
            // 비밀번호 이중 확인 함수
            var pw = $("input[name='pw']").val();
            var pwCheck = $("input[name='pwCheck']").val();

            if(pwCheck != pw){
                // 비밀번호가 동일하지 않을 시에 span show
                $(".pwNotEqual").removeClass("hidden");
            }else{
                $(".pwNotEqual").addClass("hidden");
            }
        }
        
        function valueAlert(tag, text){ // 값 alert 하고 해당 입력칸으로 이동
            $('html, body').animate({
                // 해당 요소로 스크롤 애니메이션 실행
                scrollTop: $(tag).offset().top
            }, 500);
            $(tag).focus(); // 포커스 이동
            alert(text); // 경고창 표시
        }
        

        
        /* 값 유효성 검사
		// validation("nick", "닉네임은 한글과 대문자/소문자 영어, 숫자, !@#$%^&*만 사용이 가능합니다.");
		function validation(name, text){
            var value = $("input[name='"+name+"']").val();
            var pattern = /^[가-힣A-Za-z0-9!@#$%^&*_-]+$/;
            
            if(!pattern.test(nickVal)) {
                alert(text);
                $("input[name='nick']").focus();
                e.preventDefault(); // 폼 제출 중지
            }
        }
        */
    </script>
</body>
</html>