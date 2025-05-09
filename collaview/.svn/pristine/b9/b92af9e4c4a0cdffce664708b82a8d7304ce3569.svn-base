<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
   	<jsp:include page="/head.jsp"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css">
    <link rel="stylesheet" href="/css/boardList.css">
    <script src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
</head>
<body>
   	<jsp:include page="/header.jsp"/>

    
    <main class="container" id="container">
        <div class="toolbar" id="customToolbar">
            <div class="select searchSelect">
                <div class="inputBox selectBox">
                    <input type="hidden" class="selectValue hidden" value="" required>
                    <p class="selectText"></p>
                    <span class="material-symbols-outlined">arrow_drop_down</span>
                </div>
                <div class="selectListWrap">
                    <ul class="selectList">
                        <li data-value="">전체</li>
                        <li data-value="notice">공지사항</li>
                        <li data-value="free">자유</li>
                        <li data-value="info">정보</li>
                        <li data-value="suggest">제안</li>
                        <li data-value="noname">익명</li>
                        <li data-value="hire">채용</li>
                        <li data-value="scout">밴드모집</li>
                    </ul>
                </div>
            </div>
            <label for="customSearch" class="search">
                <input type="text" id="customSearch" placeholder="검색어 입력" />
            </label>
            <a href="/board_insert.do" class="btn h40 bc_555 write"><span class="material-symbols-outlined">edit</span></a>
        </div>

        <table id="datatables" class="table table-bordered">
            <thead>
                <tr class="hidden">
                    <th class="sort" id="sort"></th>
                    <th id="category"></th>
                    <th id="title"></th>
                    <th id="contents"></th>
                    <th id="user"></th>
                    <th id="sub"></th>
                    <!-- <th id="date">date</th>
                    <th id="view">view</th>
                    <th id="chat">chat</th> -->
                    <th id="img"></th>
                    <th id="table hidden"></th>
                    <th id="idx hidden"></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </main>

    <jsp:include page="/footer.jsp"/>

    <script>
	    $(function(){
	        let channelLink = 'channel_detail'; // 채널 상세페이지 주소
	        let userLink = 'profileView'; // 유저 상세페이지 주소
	        let page = 0;
	        let loading = false;
	        const pageSize = 10; // 한 번에 불러올 게시글 수
	        const total = ${boardTotCnt}; // 총 게시글 수
	
	        // json 게시글 데이터
	        /* let data = [
	            {table: "recruit", // 게시글이 저장된 DB 테이블명
            	idx: 1, // 게시글 idx
	            category: "채용", // 카테고리
	            uploader_type: "channel", // 업로더가 채널인지 유저인지 어드민인지 확인
	            uploader: "채널명채널명채널명채널명채널명채널명채널명채널명채널명채널명", // 업로더 닉네임이나 채널명 또는 관리자
	            uploader_img: "1743747922_asdfq_AI.jpg", // 업로더 썸네일 또는 프로필 사진
	            uploader_idx: 1, // 업로더 idx
	            title: "게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목 게시글 제목", // 게시글 제목
	            contents: "게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용 게시글 내용", // 게시글 내용
	            date: "2025-03-03 01:01:01", // 업로드 일자 및 시간
	            view: 0, // 조회수
	            chat: 0, // 댓글수
	            img_file: "1743747922_asdfq_AI.jpg", // 파일 이름
	            img_origin: "AI.jpg" // 파일 원본 이름
	            },
	        ]; */
	        
	        let data = [];

            var $table = $("#datatables");
            const dt = $table.DataTable({
                data: data,
                paging: false,
                info: false,
                // search: false, // 아예 기능 자체가 막혀서 hide()를 사용하기로 함
                language: {
                    emptyTable: "데이터가 없습니다.",
                    zeroRecords: "검색 결과가 없습니다.",
                    infoEmpty: "표시할 항목이 없습니다."
                },
                columns: [
                    {data: "date"},
                    {data: "category"},
                    {data: "title"},
                    {data: "contents"},
                    {
                        data: null,
                        render: function (data, type, row) {
                            var userType = row['uploader_type'];
                            var idx = row['uploader_idx'];
                            var imgFolder = (userType == 'admin' ? '' : (userType == 'channel' ? 'thumbnail' : 'profile'));
                            var link = (userType == 'admin' ? '#' : (userType == 'channel' ? '/'+channelLink+'.do?idx='+idx : '/'+userLink+'.do?idx='+idx));
                            if(userType == 'admin'){
                                var tag = '<p class="name">' + row['uploader'] + '</p>'
                                return tag;
                            }else{
                                var $tag = $('<a href="'+link+'"></a>')
                                var $img = $('<p class="img"></p>');
                                $img.css("background-image", 'url("/file/' + imgFolder + '/' + row['uploader_img'] + '")');
                                $tag.append($img)
                                $tag.append('<p class="name">' + row['uploader'] + '</p>')
                                var tag = $("<div></div>").append($tag).html(); // html은 javascript의 innerHtml이기 때문에 한 번 div로 감싼 이후 가져옴.
                                return tag; // jQuery 데이터는 받아들이지 못함.
                            }
                        }
                    },
                    {
                        data: "date",
                        render: function (data, type, row) {
                            // 유저 아이디, 썸네일이나 프로필 사진, 게시일, 조회수, 댓글수
                            var tag = '<p class="date"><span class="icon material-symbols-outlined">schedule</span>' + data.split(" ")[0] + '</p>'
                                +'<p class="view"><span class="icon material-symbols-outlined">visibility</span>' + row['view'] + '</p>'
                                +'<p class="chat"><span class="icon material-symbols-outlined">tooltip</span>' + row['chat'] + '</p>';
                            return tag;
                        }
                    },
                    // {data: "date"},
                    // {data: "view"},
                    // {data: "chat"},
                    {
                        data: 'img_file',
                        render: function (data, type, row) { // 이미지 렌더링
                            if(data != null){
                                return '<p style="background-image: url(/file/bbs/'+data+')"></p>';
                            } else {
                                return '<p class="noImg"></p>';
                            }
                        }
                    },
                    {data: "table"},
                    {data: "idx"},
                ],
                order: [[0, 'desc']],
            });
	
	        init();

            // 카테고리 필터링
            $(".searchSelect").on('click', '.selectList > li', function () {
                const value = $(this).attr('data-value');
                // DataTables 필터 적용
                if (typeof dt !== 'undefined') {
                    dt.column(1).search(value).draw(); // 1번 컬럼 = category
                }
            });

            // 검색창 필터링
            $('#customSearch').on('input', function () {
                dt.search(this.value).draw();
                $(".dt-empty").parents("tr").addClass("border0");
            });

            // 무한 스크롤 감지
            $(window).on('scroll', function () {
                const scrollTop = $(window).scrollTop();
                const docHeight = $(document).height();
                const winHeight = $(window).height();

                if (scrollTop + winHeight + 100 >= docHeight) {
                    init();
                }
            });
            
            // 게시글 상세 페이지로 이동
            $(".dataTable").on("click", "tr", function(){
            	var table = $(this).find(".table").text()
            	var idx = $(this).find(".idx").text()
            	
            	window.location.href = "/board_detail.do?table="+table+"&idx="+idx;
            })

            // 데이터 로드
            function loadMoreData() {
                if (loading || page * pageSize >= total) {
                	// $("#container").append("<p class=''>모든 게시글을 출력하였습니다.</p>")
                	return;
                }
                
                loading = true;
                
                let params = {
                	offset: page * pageSize,
                	boardPageSize: pageSize
               	};

                // 실제 상황에서는 여기서 Ajax 호출
                // var newData = generateData(1, 10);
                
                // 실제 Ajax
                var newData = [];
                $.ajax({
	        	    url: "/ajax_moreBoard.do",
	        		type : 'POST',
	                dataType: "text",
	                data: params,
	        	    success: function(result){
	                	console.log("result: ", result);
	                	result = JSON.parse(result);
	                	console.log("result: ", result);

	        	        if(result['result'] == "success"){
		                	newData = result['data'];
		                    
		                    dt.rows.add(newData).draw(false); // 스크롤 유지
		                    page++;
		                    loading = false;

		                    // 자동 class 명 지정 코드
		                    // th의 id로 td에 class를 지정해줌
		                    $table.find("thead tr th").each(function(index, element){
		                        var name = $(element).attr("id");
		                        var imgIndex = parseInt($(element).attr("data-dt-column")) + 1; // 0부터 시작해서 nth-child에 맞춰서 1 추가
		                        $table.find("tbody tr td:nth-child("+imgIndex+")").each(function(index, element){
		                            $(element).addClass(name);
		                        })
		                    })

		                    $(".noImg").each(function(index, element){
		                        $(element).parents("tr").find("td").each(function(i, td){
		                            if(!$(td).hasClass("category"))
		                                $(td).addClass("width100P")
		                        })
		                    })
	        	        }else if(result['result'] == "fail"){
	        	        	alert("게시글 불러오기에 실패하였습니다. 새로고침 후 다시 시도해주세요.");
	        	        }else{
	        	        	alert("게시글 불러오기 과정에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
	        	        }
	        	    },
	        	    error: function(xhr, status, error){
        	        	alert("게시글 불러오기 과정에서 서버에서 오류가 발생하였습니다. 새로고침 후 다시 시도해주세요.");
	        	        console.error("AJAX Error:", error);
	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
	        	    }
	        	});
            }

            // 더미 데이터 생성 함수
            function generateData(page, size) {
                const data = [];
                const start = page * size;
                for (let i = start; i < start + size && i < total; i++) {
                    data.push({
                        category: i % 2 === 0 ? "채용" : "자유",
                        uploader_type: i % 3 === 0 ? "channel" : (i % 3 === 1 ? "user" : "admin"),
                        uploader: (i % 3 === 2 ? "관리자" : `사용자 ${i}`),
                        uploader_img: "1745540174_asdfw_image_fx_ (1).jpg",
                        uploader_idx: i,
                        title: `게시글 제목 ${i + 1}`,
                        contents: "게시글 내용게시글 내용게시글 내용게시글 내용게시글 내용게시글 내용게시글 내용게시글 내용 ...",
                        date: "2025-03-03 01:01:01",
                        view: i * 5,
                        chat: i * 2,
                        img_file: i % 3 === 0 ? "1743747922_asdfq_AI.jpg" : null,
                        img_origin: "AI.jpg"
                    });
                }
                return data;
            }

            function init(){
                $(".dt-search").hide(); // search 숨김

                // 초기 데이터 로드
                loadMoreData();

                $(".dt-empty").parents("tr").addClass("border0");
            }
	    })
    </script>
</body>
</html>