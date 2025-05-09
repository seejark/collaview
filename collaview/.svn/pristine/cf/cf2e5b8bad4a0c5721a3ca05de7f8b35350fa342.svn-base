<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="/css/boardInsert.css">
</head>
<body>
	<jsp:include page="/header.jsp"/>

    <div class="container">
	    <form id="boardForm" enctype="multipart/form-data">
	        <div class="boardForm">
	            <div class="input">
	                <p class="inputTit">카테고리</p>
	                <div class="select categorySelect">
	                    <div class="inputBox selectBox">
	                        <input type="hidden" class="selectValue hidden" name="category" value="" required>
	                        <p class="selectText"></p>
	                        <span class="material-symbols-outlined">arrow_drop_down</span>
	                    </div>
	                    <div class="selectListWrap">
	                        <ul class="selectList">
	                            <li data-value="free">자유</li>
	                            <li data-value="info">정보</li>
	                            <li data-value="suggest">제안</li>
	                            <li data-value="noname">익명</li>
	                            <li data-value="hire">채용</li>
	                            <li data-value="scout">밴드모집</li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	            
	            
	            <div class="input recruitOn">
	                <p class="inputTit">게시글 업로드 채널 선택</p>
	                <div class="select">
	                    <div class="inputBox selectBox">
	                        <input type="hidden" class="selectValue hidden" name="channel" value="" required>
	                        <p class="selectText"></p>
	                        <span class="material-symbols-outlined">arrow_drop_down</span>
	                    </div>
	                    <div class="selectListWrap">
	                        <ul class="selectList">
	                        	<c:if test="${empty channelList}">
                            		<li data-value="">채널 없음</li>
                            	</c:if>
	                            <!-- 밴드 채널 리스트 for문 추가 - S -->
	                            <c:forEach var="channel" items="${channelList}">
	                            	<li data-value="${channel.idx}">${channel.name}</li>
	                            </c:forEach>
	                            <!-- 밴드 채널 리스트 for문 추가 - E -->
	                        </ul>
	                    </div>
	                </div>
	            </div>
	
	            <div class="input recruitOn">
	                <p class="inputTit">모집 기간</p>
	                <div class="dateWrap">
	                    <input type="date" class="inputBox" name="start_date" value="" required>
	                    <span>~</span>
	                    <input type="date" class="inputBox" name="end_date" value="">
	                </div>
	            </div>
	            
	
	
	            <div class="input title">
	                <p class="inputTit">제목</p>
	                <input type="text" class="inputBox" name="title" required>
	            </div>
	
	            <div class="input content">
	                <p class="inputTit">내용</p>
	                <div class="spanTag">
	                    <textarea class="inputBox spanItem txtBox" name="contents" required></textarea>
	                    <ul class="spanList">
	                        <li>본 게시판의 성격과 맞지 않는 글은 삭제 될 수 있습니다.</li>
	                        <li>비방, 욕설, 허위사실 유포 시 이용이 제한될 수 있습니다.</li>
	                    </ul>
	                </div>
	            </div>
	
	            <div class="input file">
	                <p class="inputTit">사진(파일)</p>
	                <div class="spanTag">
	                    <div class="spanItem fileList">
	                        <div class="fileBox">
	                            <input type="file" class="hidden" id="file1" name="file" accept="image/*">
	                            <label for="file1" class="inputBox"></label>
	                            <label for="file1" class="btn h40 bc_555"><span class="material-symbols-rounded">attach_file</span></label>
	                            <button type="button" class="btn h40 bc_point addFile"></button>
	                        </div>
	                    </div>
	                    <ul class="spanList">
	                        <li>jpg, png, zip, PDF 파일만 첨부 가능합니다.</li>
	                        <li>최대 10개까지 업로드 가능합니다.</li>
	                    </ul>
	                </div>
	            </div>
	
	            <div class="btn_wrap">
	                <button type="button" id="btnUpload" class="btn h45 long bc_point upload">업로드</button>
	                <button type="button" class="btn h45 long bc_555 cancel" onclick="history.back();">취소</button>
	            </div>
	        </div>
        </form>
    </div>

	<jsp:include page="/footer.jsp"/>

    <script>
        $(function(){
	       	$('#btnUpload').on('click', function(){
				
				var company_chk = '${userData.company_chk}';
				var category    = $('input[name="category"]').val();
				var title       = $('input[name="title"]').val().trim();
				var contents    = $('textarea[name="contents"]').val().trim();
				var channel     = $('input[name="channel"]').val();
				
				if (!category) {
					alert('카테고리를 선택해주세요.');
					return;
				}
				if (!title) {
					alert('제목을 입력해주세요.');
					return;
				}
				if (!contents) {
					alert('내용을 입력해주세요.');
					return;
				}
				if ((category === 'hire' || category === 'scout')) {
					var start = $('input[name="start_date"]').val();
					var end   = $('input[name="end_date"]').val();
					if (!start || !end) {
						alert('모집 기간을 모두 입력해주세요.');
						return;
					}
				}
				if ((!channel || !channel.trim()) && company_chk !== 'y') {
					alert('채널을 선택해주세요.');
					return;
				}
			    
				var formEl = $('#boardForm')[0];
				var data = new FormData(formEl);
				$.ajax({
					url: '/board_insert.do',
					type: 'POST',
					data: data,
					processData: false,
					contentType: false,
					success: function(res){
						if(res == "success"){
							alert('등록 완료되었습니다.');
							window.location.href = '/board_list.do';
						}
						else if(res == "notLigin"){
							alert('로그인 후 이용 가능한 서비스 입니다.');
						}
						else{
							alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요.");
						}
					},
					error: function(xhr){
						alert("서버에 오류가 발생하였습니다 잠시 후 다시 시도해주세요.");
					}
				});
			});
        	
            // 채용/밴드모집 선택 시 채널 선택과 모집 기간 출력
        	$(".categorySelect .selectList >li").click(function(){
                var val = $(this).attr("data-value");
                if(val == "hire" || val == "scout")
                    $(".recruitOn").addClass("on");
                else
                    $(".recruitOn").removeClass("on");
            })

            // 파일 선택 시 파일명 표시
            $(".fileList").on("change", "input[type='file']", function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith('image/')) {
                    $(this).parents(".fileBox").find('.inputBox').text(file.name);
                } else {
                    $(this).parents(".fileBox").find('.inputBox').text("");
                }
            });

            // 파일 입력 필드 추가
            $(".fileList").on("click", ".addFile", function(){
                const cnt = $(".fileBox").length + 1;

                if (cnt > 10) {
                    alert('최대 10개까지 업로드 가능합니다.');
                    return;
                }

                var fileBox =
                    '<div class="fileBox">'+
                        '<input type="file" class="hidden" id="file'+cnt+'" name="file" accept="image/*">'+
                        '<label for="file'+cnt+'" class="inputBox"></label>'+
                        '<label for="file'+cnt+'" class="btn h40 bc_555"><span class="material-symbols-rounded">attach_file</span></label>';

                if(cnt == 10) // 10번째 입력 필드는 remove 버튼으로
                    fileBox += '<button type="button" class="btn h40 bc_point removeFile"></button>';
                else // 10번째 입력 필드는 remove 버튼으로
                    fileBox += '<button type="button" class="btn h40 bc_point addFile"></button>';

                fileBox += '</div>';
                $(fileBox).appendTo($(".fileList"));

                $(this).removeClass("addFile").addClass("removeFile");
            })

            // 파일 입력 필드 삭제
            $(".fileList").on("click", ".removeFile", function(){
                $(this).parents(".fileBox").remove();
                $(".fileBox").each(function(index, element){
                    var cnt = index + 1;
                    var id = "file"+ cnt;
                    $(element).find("input[name='file']").attr("id", id);
                    $(element).find("label.inputBox").attr("for", id);
                    $(element).find("label.btn").attr("for", id);

                    if(cnt == $(".fileBox").length && $(element).find(".btn.removeFile").length > 0)
                        $(element).find(".btn.removeFile").removeClass("removeFile").addClass("addFile");
                })
            })
        })
    </script>
</body>
</html>