<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
   	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="/css/channel_setting.css">
  </head>
  <body>
   	<jsp:include page="/header.jsp"/>
   	
    <main class="container" id="container">
    	<div class="wrap">
	    	<div class="title">채널명</div>
	   		<input type="text" name="name" class="text" value="${channelVO.name}"/>
   		</div>
   		<div class="wrap">
    	<div class="title">고유 번호</div>
	    	<div class="spanTag">
	    		<input type="text" name="key" id="key" class="text inputBox" ${!empty channelVO ? 'readonly' : ''} oninput="duplicationKey()" value="${channelVO.key}"/>
	            <ul class="spanList">
	                <li>고유번호는 등록 이후 변경이 불가합니다.</li>
	            </ul>
	    	</div>
    	</div>
    	<div class="wrap">
    	<div class="title">채널 설명</div>
	    	<textarea name="contents" class="chanel-comment" maxlength="80">${channelVO.contents}</textarea>
	    </div>
	    <div class="wrap" id="uploadIcon">
	  		<div class="title">채널 썸네일</div>
		    <div class="thumbnail-group">
		    	<div class="div-wrapper">
		    		<div class="file-name">
		    			<c:if test="${empty channelVO.thumbnail_origin}">파일명.jpg</c:if>
		    			<c:if test="${!empty channelVO.thumbnail_origin}">${channelVO.thumbnail_origin}</c:if>
	    			</div>
		    	</div>
		    	<div class="clip-icon">
		   			<span class="material-symbols-outlined" id="uploadIcon">attach_file</span>
		   		</div>
		   		<input type="file" id="fileInput" name="file" accept="image/*" style="display: none;" value="${channelVO.thumbnail_origin}">
			</div>
    		<div class="rectangle"></div>
		</div>
    	
    	<div class="wrap">
	    	<p class="title">채널 검색 및 추천 허용</p>
	    	
	    	<div class="overlap-group">
			    <label class="overlap" for="bandCheck">
				    <div class="title noMargin">밴드모집</div>
				    <input type="checkbox" id="bandCheck" name="recruit_band" class="frame-wrapper noMargin" ${empty channelVO ? "checked" : channelVO.recruit_band == "y" ? "checked" : ""}/>
			    </label>
			    <label class="overlap" for="employment">
				    <div class="title noMargin">채용</div>
				    <input type="checkbox" id="employment" name="recruit_company" class="frame-wrapper noMargin" ${empty channelVO ? "checked" : channelVO.recruit_company == "y" ? "checked" : ""}/>
			    </label>
		    </div>
	    </div>
	    
	    <div class="addMemberGroup">
	        <label class="overlap-2" for="bandChannel">
		        <input type="checkbox" class="hidden" id="bandChannel" name="band_chk" ${!empty userList and channelVO.band_chk eq "y" ? "checked disabled" : (channelVO.band_chk eq "y" ? "checked" : "")}/>

		        <span class="custom-checkbox"></span>
		        <div class="title-2">밴드 채널</div>
			</label>
	      	<div class="hideAddMember">
				<div class="title-4">밴드 멤버 추가</div>
				<!-- 기존 멤버 출력 -->
		        <c:if test="${!empty userList}">
		            <c:forEach var="user" items="${userList}">
		                <div class="addMember" data-member-id="${user.user}">
		                    <div class="group">
		                        <input type="text" name="bandMemberId" class="bandMemberInput addMemberText noMargin existingMember" value="${user.user}" readonly />
		                        <input type="button" class="addMemberBtn search" value="검색" disabled>
		                        <span class="addMemberBtn remove material-symbols-rounded">remove</span>
		                    </div>
		                    <div class="group-2">
		                        <label class="title-5">중간관리자 여부</label>
		                        <input type="checkbox" name="midManagerCheck" class="frame-wrapper" <c:if test="${user.admin == 'y'}">checked</c:if> />
		                    </div>
		                </div>
		            </c:forEach>
		        </c:if>
		        
		        <div class="addMember">
		            <div class="group">
		                <input type="text" name="bandMemberId" class="bandMemberInput addMemberText noMargin" placeholder="아이디">
		                <input type="button" class="addMemberBtn search" value="검색">
		                <span class="addMemberBtn add material-symbols-rounded">add</span>
		            </div>
		            <div class="group-2">
		                <label class="title-5">중간관리자 여부</label>
		                <input type="checkbox" name="midManagerCheck" class="frame-wrapper"/>
		            </div>
		        </div>
	      </div>
      </div>

      <div class="button-group">
	      <div class="primary" ${empty channelVO ? 'onclick="upload()"' : 'onclick="update()"' }><div class="title-3">업로드</div></div>
	      <div class="title-wrapper" onclick="history.back()"><div class="title-3">취소</div></div>
      </div>
    </main>
    
    <jsp:include page="/footer.jsp"/>
    
    <script>
    	let keyDuplication = 0;
		let midManagerCounter = 2;
		let validatedMemberIds = [];
		let removedMemberIds = [];
		
		/* 채널 생성 */
    	function upload(){
    		let band_chk = $("input[name='band_chk']").is(":checked");
    		const addMembers = document.querySelectorAll('.addMember');
    	    
    		if($("input[name='name']").val() == ""){
    			alert("채널명을 입력해주세요");
    			$("input[name='name']").focus()
    			return false;
    		}
    		else if($("input[name='key']").val() == ""){
    			alert("고유변호를 입력해주세요");
    			$("input[name='key']").focus()
    			return false;
    		}
    		else if($("textarea[name='contents']").val() == ""){
    			alert("채널설명을 입력해주세요");
    			$("textarea[name='contents']").focus()
    			return false;
    		}
    		
    		if(keyDuplication == 0){
    			alert("중복된 고유번호입니다.");
    			$("#key").focus()
    			return false;
    		}
    		
    	    if (band_chk) {
    	        const inputIds = $('.bandMemberInput')
    	            .map((i, el) => $(el).val().trim())
    	            .get()
    	            .filter(v => v !== "");
    	        if (inputIds.length > 0) {
	    	        const allSearched = inputIds.every(id => validatedMemberIds.includes(id));
	
	    	        if (inputIds.length === 0 || !allSearched) {
	    	            alert("추가된 멤버의 아이디를 모두 검색한 후 추가해주세요.");
	    	            return false;
	    	        }
    	        }
    	    }
    	    
    	    let memberIds = [];
    	    let managerChecks = [];
    	    
    	    validatedMemberIds.forEach(validId => {
    	        for (let member of addMembers) {
    	            const inputId = $(member).find('.bandMemberInput').val().trim();
    	            const isManager = $(member).find('input[name="midManagerCheck"]').is(':checked');

    	            if (inputId === validId) {
    	                memberIds.push(validId);
    	                managerChecks.push(isManager);
    	                break;
    	            }
    	        }
    	    });
    		
    		var formData = new FormData();
    		
    		formData.append("name", $("input[name='name']").val());
    	    formData.append("key", $("input[name='key']").val());
    	    formData.append("contents", $("textarea[name='contents']").val());
    	    formData.append("band_chk", $("input[name='band_chk']").is(":checked"));
    	    formData.append("recruit_band", $("input[name='recruit_band']").is(":checked"));
    	    formData.append("recruit_company", $("input[name='recruit_company']").is(":checked"));
    	    formData.append("memberId", memberIds.join("/"));
    	    formData.append("managerCheck", managerChecks.join("/"));
        	
    	    var fileInput = document.getElementById('fileInput');
    	    if(fileInput.files.length > 0){
    	        formData.append("file", fileInput.files[0]);
    	    }
    	    
    	    let idx;
    	    
        	$.ajax({
        		url : "/ajax_createChannel.do",
        		type : "post",
        		data : formData,
        		dataType: "json",
        		contentType: false,
        		processData: false,
        		success: function(result) {
        		    if (result.status === "success") {
        		    	alert("채널 생성이 완료되었습니다.");
        		    	location.href = "channel_self.do?idx=" + result.idx;
        		    }
        		    else if (result.status === "notLogin") {
        		    	alert("로그인 후 이용 가능한 서비스입니다.");
        		    }
        		    else {
        		    	alert("서버 오류가 발생했습니다. 채널을 다시 생성해주세요.");
        		    }
				},
				error: function() {
					alert("서버에 오류가 발생하였습니다. 채널을 다시 생성해주세요.");
				}
        	});
    	}
		
		/* 채널 수정 */
    	function update(){
    		let band_chk = $("input[name='band_chk']").is(":checked");
    		const addMembers = document.querySelectorAll('.addMember');
    	    
    		if($("input[name='name']").val() == ""){
    			alert("채널명을 입력해주세요");
    			$("input[name='name']").focus()
    			return false;
    		}
    		else if($("input[name='key']").val() == ""){
    			alert("고유변호를 입력해주세요");
    			$("input[name='key']").focus()
    			return false;
    		}
    		else if($("textarea[name='contents']").val() == ""){
    			alert("채널설명을 입력해주세요");
    			$("textarea[name='contents']").focus()
    			return false;
    		}
    		
    		
    	    if (band_chk) {
    	        let invalidNewMember = false;
    	        $('.addMember').each(function() {
    	            if (!$(this).data('member-id')) {
    	                let newId = $(this).find('.bandMemberInput').val().trim();
    	                if (newId !== "" && !validatedMemberIds.includes(newId)) {
    	                    invalidNewMember = true;
    	                }
    	            }
    	        });
    	        if (invalidNewMember) {
    	            alert("추가된 멤버의 아이디를 모두 검색한 후 추가해주세요.");
    	            return false;
    	        }
    	    }
    	    
    		let memberIds = [];
    	    let managerChecks = [];
    	    
    	    $('.addMember').each(function() {
    	        const id = $(this).find('.bandMemberInput').val().trim();
    	        if (id) {
    	            memberIds.push(id);
    	            managerChecks.push($(this).find('input[name="midManagerCheck"]').is(':checked'));
    	        }
    	    });
    	    
    	    var formData = new FormData();
    	    formData.append("idx", ${channelVO.idx});
    	    formData.append("name", $("input[name='name']").val());
    	    formData.append("key", $("input[name='key']").val());
    	    formData.append("contents", $("textarea[name='contents']").val());
    	    formData.append("band_chk", $("input[name='band_chk']").is(":checked"));
    	    formData.append("recruit_band", $("input[name='recruit_band']").is(":checked"));
    	    formData.append("recruit_company", $("input[name='recruit_company']").is(":checked"));
    	    
    	    formData.append("memberId", memberIds.join("/"));
    	    formData.append("managerCheck", managerChecks.join("/"));
    	    
    	    if (removedMemberIds.length > 0) {
    	        formData.append("removedMemberIds", removedMemberIds.join("/"));
    	    }
    	    
    	    var fileInput = document.getElementById('fileInput');
    	    if(fileInput.files.length > 0){
    	        formData.append("file", fileInput.files[0]);
    	    }
    	    
    	    $.ajax({
    	        url : "/ajax_updateChannel.do",
    	        type : "post",
    	        data : formData,
    	        contentType: false,
    	        processData: false,
    	        success: function(result) {
    	            if(result.status == "success"){
    	                alert("채널 수정이 완료되었습니다.");
    	                location.href = "channel_self.do?idx=" + result.idx;
    	            } else {
    	                alert("서버에 오류가 발생하였습니다. 채널을 다시 수정해주세요.");
    	            }
    	        },
    	        error: function() {
    	            alert("서버에 오류가 발생하였습니다. 채널을 다시 수정해주세요.");
    	        }
    	    });
    	}
    	
    	/* 고유번호 중복체크 */
    	function duplicationKey() {
    		let key = $("input[name='key']").val();
    		
    		$.ajax({
    			url : "/duplicationKey.do",
    			type : "post",
    			data : {
    				key : key
    			},
    			success: function(result) {
    				if(result == 'y'){
    					$("#key").css("color", "red");
    					keyDuplication = 0;
    				}
    				else{
    					$("#key").css("color", "green");
    					keyDuplication = 1;
    				}
				},
				error: function() {
    				alert("서버에 오류가 발생하였습니다. 다시 시도해주세요.");
				}
    		});
		}
    	
    	$(document).ready(function(){
    	    $('.addMember').each(function(){
    	        let memberId = $(this).data('member-id');
    	        if(memberId && !validatedMemberIds.includes(memberId)){
    	            validatedMemberIds.push(memberId);
    	        }
    	    });
    	});
    	
    	/* 아이디 검색 */
		$(document).on("click", ".addMemberBtn.search", function(){
			const addMember = $(this).closest('.addMember');
			var input = $(this).closest('.addMember').find('.bandMemberInput');
			var id = input.val();
			
			if(id === "") {
				alert("아이디를 입력해주세요.");
				return;
			}
			
			if(addMember.data('member-id')){
				alert("이미 추가된 멤버입니다.");
				input.val("");
				return;
			}
			
		    if (validatedMemberIds.includes(id)) {
		        alert("이미 추가된 멤버입니다.");
		        input.val("");
		        return;
		    }
		
			$.ajax({
				url : "/ajax_bandMemberIdSearch.do",
				type : "post",
				data : {
					id : id
				},
				success: function(result) {
					if(result != ""){
						if(confirm(result + "님을 멤버로 등록하시겠습니까?")){
							validatedMemberIds.push(id);
				            input.prop("disabled", true);
				            addMember.find('.addMemberBtn.search').prop("disabled", true);
						}
					}
					else {
						alert("해당 아이디를 찾을 수 없습니다.");
						input.val("");
					}
				},
				error: function() {
					alert("서버에 오류가 발생하였습니다. 다시 시도해주세요.");
				}
			});
		});
		
		/* 밴드 멤버 추가 */
		$(document).on("click", ".addMemberBtn.add", function() {
			const currentBlock = $(this).closest('.addMember');
			$(this).text('remove').removeClass('add').addClass('remove');
			
			const newBlock = currentBlock.clone();
			
			newBlock.find('.bandMemberInput').val('').prop('disabled', false);
			newBlock.find('.addMemberBtn.search').prop('disabled', false);
			newBlock.find('input[name="midManagerCheck"]').prop('checked', false);
			newBlock.find('.addMemberBtn.remove').text('add').removeClass('remove').addClass('add');
			
			$('.hideAddMember').append(newBlock);
		});
		
		/* 밴드 멤버 제거 */
		$(document).on("click", ".addMemberBtn.remove", function() {
		    const addMember = $(this).closest('.addMember');
		    
		    const memberId = addMember.data('member-id');
		    if (memberId) {
		        removedMemberIds.push(memberId);
		        
		        const index = validatedMemberIds.indexOf(memberId);
		        if (index !== -1) {
		            validatedMemberIds.splice(index, 1);
		        }
		    }
		    
		    const allBlocks = $('.hideAddMember').find('.addMember');
		    
		    if (allBlocks.length > 1) {
		        addMember.remove();
		    } else {
		        $(this).text('add').removeClass('remove').addClass('add');
		        addMember.find('.bandMemberInput').val('').prop("disabled", false);
		        addMember.find('.addMemberBtn.search').prop("disabled", false);
		        addMember.find('input[name="midManagerCheck"]').prop('checked', false);
		    }
		});

		
		/* 밴드 채널 선택 시 멤버 추가 창 보이기 */
		const bandChannelCheckbox = document.getElementById('bandChannel');
		const overlap2 = document.querySelector('.overlap-2');
		const group = document.querySelector('.addMemberGroup');
		const hideAddMember = document.querySelector('.hideAddMember');
		
		hideAddMember.style.display = 'none';
		
		bandChannelCheckbox.addEventListener('change', function() {
			if (this.checked) {
				overlap2.style.backgroundColor = '#555555';
				overlap2.style.color = '#fff';
				group.style.border = '1px solid #ddd';
				hideAddMember.style.display = 'block';
			} else {
				overlap2.style.backgroundColor = '';
				overlap2.style.color = '';
				hideAddMember.style.display = 'none';
				group.style.border = 'none';
			}
		});
		
		/* 사진 미리보기 */
		const uploadIcon = document.getElementById('uploadIcon');
		const fileInput = document.getElementById('fileInput');
		const fileNameElement = document.querySelector('.file-name');
		const rectangle = document.querySelector('.rectangle');
		
		uploadIcon.addEventListener('click', function(){
    		fileInput.click();
		});
		
		fileInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
		    	fileNameElement.textContent = file.name;
		    
		    	const reader = new FileReader();
			    reader.onload = function(e) {
			    	rectangle.style.backgroundImage = "url('" + e.target.result + "')";
			    }
		    reader.readAsDataURL(file);
		  }
		});
		
		/* 밴드채널 선택 시 체크로 바꿈 */
		document.addEventListener('DOMContentLoaded', function() {
			const checkbox = document.getElementById('bandChannel');
			const label = document.querySelector('.custom-checkbox');
			
			checkbox.addEventListener('change', function() {
				if (this.checked) {
					label.classList.add('on');
				} else {
					label.classList.remove('on');
				}
			});
			
			if (bandChannelCheckbox.checked) {
				bandChannelCheckbox.dispatchEvent(new Event('change'));
			}
		});
		
		$(document).ready(function(){
			$('#key').on('input', function() {
				this.value = this.value.replace(/\s/g, '');
				duplicationKey();
			});
		});
	</script>
  </body>
</html>