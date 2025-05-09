<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="/css/video_page.css">
</head>
<body>
	<jsp:include page="/header.jsp" />
	<main id="container" class="container">
		<div class="video-item large wrap">
			<c:if test="${videoVO.category != '앙상블 챌린지'}">
				<video src="/file/video/${fileList[0].file_name}" preolad controls <c:if test="${videoVO.thumbnail_file != null && videoVO.thumbnail_file != ''}">poster="/file/video/${videoVO.thumbnail_file}"</c:if>></video>
			</c:if>
			<c:if test="${videoVO.category == '앙상블 챌린지'}">
				<div class="videoController">
					<c:forEach var="file" items="${fileList}">
						<video src="/file/video/${file.file_name}" preolad controls></video>
					</c:forEach>
					<c:if test="${videoVO.thumbnail_file != null && videoVO.thumbnail_file != ''}">
					<span class="thumbnail" style="background: url('/file/video/${videoVO.thumbnail_file}') no-repeat center/cover;"></span>
					</c:if>
				</div>
			</c:if>
			
			<c:if test="${videoVO.category == '앙상블 챌린지' && ensOver != 'over'}">
				<span class="material-symbols-rounded" onclick="location.href='video_emsembleAdd.do?idx=${idx}'">add</span>
			</c:if>
		</div>
		<div class="rating-container wrap">
			<div class="rating-wrap">
				<div class="rating">
					<span class="rating-label">스킬</span>
					<span class="rating-value"><fmt:formatNumber value="${videoVO.skill}" type="number" minFractionDigits="2"  maxFractionDigits="2"/></span>
				</div>
				<div class="rating">
					<span class="rating-label">카리스마</span>
					<span class="rating-value"><fmt:formatNumber value="${videoVO.charisma}" type="number" maxFractionDigits="2" minFractionDigits="2" /></span>
				</div>
				<div class="rating">
					<span class="rating-label">매너</span>
					<span class="rating-value"><fmt:formatNumber value="${videoVO.manner}" type="number" maxFractionDigits="2" minFractionDigits="2" /></span>
				</div>
				<div class="rating">
					<span class="rating-label">퍼포먼스</span>
					<span class="rating-value"><fmt:formatNumber value="${videoVO.perform}" type="number" maxFractionDigits="2" minFractionDigits="2" /></span>
				</div>
			</div>
			<div class="rating-btn">마음</div>
		</div>
		<div class="title">${videoVO.title}</div>
		<div class="video-info wrap">
			<div class="video-info-header">
				<div class="video-info-detail">
					<div class="info-wrap">
						<span class="info-content">
							<span class="material-symbols-rounded">schedule</span>
							<span>${fn: substring(videoVO.register_date, 0, 10)}</span>
						</span>
						<span class="info-content"><span class="material-symbols-rounded">visibility</span>
							<span>${videoVO.view}</span>
						</span>
					</div>
				</div>
				<c:if test="${reports != 'y' && userData != null}">
					<div class="claim-btn">
						<span class="material-symbols-rounded">e911_emergency</span><span>신고</span>
					</div>
				</c:if>
			</div>
			<div class="video-content">${videoVO.contents}</div>
			<div class="keyword-container">
				<c:forEach var="keyword" items="${keywordList}">
					<div class="keyword">${keyword.name}</div>
				</c:forEach>
			</div>
			<c:if test="${channelVO.band_chk == 'y'}">
				<div class="band-member-title">밴드멤버</div>
				<div class="member-container">
					<div class="member">
						<!-- 사진 : ${userVO.profile_file} -->
						<div class="member-avatar"><img src="/file/profile/${channelVO.profile_file}" alt="${channelVO.profile_origin}"></div>
						<div class="member-nick">${channelVO.user}</div>
					</div>
					<c:forEach var="user" items="${userList}">
						<div class="member">
							<img src="/file/profile/${user.profile_file}" alt="${user.profile_origin}" class="member-avatar">
							<div class="member-nick">${user.nick}</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${videoVO.category == '앙상블 챌린지'}">
				<div class="band-member-title">챌린지 참여자</div>
				<div class="member-container">
					<c:forEach var="member" items="${umsembleMemberList}">
						<div class="member">
							<div class="member-avatar"><img src="/file/profile/${member.profile_file}" alt="${member.profile_origin}"></div>
							<div class="member-nick">${member.user}</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
		<div class="user-info-container wrap">
			<div class="user-info-header">
				<div class="user-info" onclick="location.href='/channel_detail.do?idx=${channelVO.idx}'">
					<img src="/file/thumbnail/${channelVO.thumbnail_file}" alt="${channelVO.thumbnail_origin}" class="user-avatar">
					<div>
						<div class="user-nick">${channelVO.name}</div>
						<div class="bookmark-conatiner">
							<span class="material-symbols-rounded">bookmarks</span> <span>${channelVO.bookmark_cnt}</span>
						</div>
					</div>
					<c:if test="${userData != null}">
						<div class="bookmark-btn bookmark" onclick="toggleBookmark()">
							<span class="material-symbols-outlined">bookmark_heart</span>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<div class="contents"></div>
	</main>

	<!-- 평가 모달 -->
	<div id="ratingModal" class="ratingModal hidden">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<div class="modal-title">마음</div>
			<form id="ratingForm">
				<div class="rating_wrap">
					<div class="rating-group">
						<div>스킬</div>
						<div class="stars" data-category="skill"></div>
					</div>
					<div class="rating-group">
						<div>매너</div>
						<div class="stars" data-category="manner"></div>
					</div>
					<div class="rating-group">
						<div>카리스마</div>
						<div class="stars" data-category="charisma"></div>
					</div>
					<div class="rating-group">
						<div>퍼포먼스</div>
						<div class="stars" data-category="perform"></div>
					</div>
				</div>
				<div class="modal-buttons">
					<button type="submit" class="btn save">저장</button>
					<button type="button" class="btn cancel" onclick="closeModal()">취소</button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 신고 모달 -->
	<div id="modalWrap" class="ratingModal hidden">
		<div class="modal-overlay" onclick="closeReportModal()"></div>
		<div class="modal-report-content" id="reportContent"></div>
	</div>

	<jsp:include page="/footer.jsp" />

	<input type="hidden" class="hidden more" value="0">

	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script>
		var dataList = ${result}; // 받아온 데이터
	
	    var video = (dataList["videoList"] != '' && dataList["videoList"] != undefined && dataList["videoList"].length > 0) ? true : false; // video 전체 출력됐는지 확인 변수
	    const swiper = {}; // 동적 변수를 사용하기 위한 리스트
	    function init(){
	        contentMore(0); // 처음이라서 굳이 val가져오지 않고 0을 넣음.
	        autoFitHeight(); // 반응형을 위해 정사각형의 경우에는 height를 맞추도록 하는 함수.
	    }
	    var $addMoreBox; // 더보기에 이용할 전역 변수
	
	    // 콘텐츠 생성 함수. 초기화와 더보기에 이용.
	    function contentMore(cnt){
	        // 다음 번호로 지정하는 것이지만 아래에 배치하면 계속해서 멈추지 않고 스크롤할 때 딜레이 때문에 변경이 제대로 되지 않아 위에 배치
	        $("input.more").val(Number(cnt) + 1);
	        
	        $addMoreBox = $('<div class="contentsBox"></div>');

            // 영상 8개 배치
            if(video) videoLi();
            
	        $addMoreBox.appendTo($(".contents"));
	    }

        // 영상 8개 배치
        function videoLi(){
        	var videoList = dataList["videoList"];
            console.log(videoList.length)
            if(videoList.length != 0){
	            var $videoList = $('<div class="videoList"></div>');
	            for(var i in videoList){
	                var item = videoList[i];
	                var $videoLi =
	                '<div class="videoBox">'+
                    	/* '<a href="/video_page.do?idx=54">'+ */
	                    '<a href="/video_page.do?idx='+item['idx']+'">'+
	                		'<input type="hidden" class="hidden" name="videoIdx" value="'+item['idx']+'">'+
	                        '<figure class="videoBox_img autoFitHeight" style="height: 171px;">';

					if(item['file_type'] == 'thumb'){
	                    $videoLi += '<img src="/file/video/'+item['file']+'" alt="'+item['title']+'">'					
					}else if(item['file_type'] == 'video'){
	                    $videoLi += '<video src="/file/video/'+item['file']+'"></video>'
					}
                  	$videoLi +=
                  			'</figure>'+
	                        '<p class="videoBox_tit">'+item['title']+'</p>'+
	                    '</a>'+
	                    '<div class="videoBox_ch">'+
                        	'<a href="/channel_detail.do?idx='+item['channel']+'" class="videoBox_ch_img autoFitHeight" style="height: 32px;"><img src="/file/profile/1745540174_asdfw_image_fx_ (1).jpg" alt="'+item['ch_name']+'"></a>'+
	                        //'<a href="#'+item['channel']+'" class="videoBox_ch_img autoFitHeight" style="height: 32px;"><img src="/file/img/"'+item['ch_img']+' alt="'+item['ch_name']+'"></a>'+
	                        '<div class="videoBox_ch_txt">'+
	                            '<div class="videoBox_ch_tit">'+
		                            '<a href="/channel_detail.do?idx='+item['channel']+'" class="videoBox_ch_name">'+item['ch_name']+'</a>'+
	                                //'<a href="#'+item['channel']+'" class="videoBox_ch_name">'+item['ch_name']+'</a>'+
	                                '<span class="videoBox_ch_level autoFitHeight channelLevel rank'+item['rank']+'" style="height: 14px;">'+item['level']+'</span>'+
	                            '</div>'+
	                            '<em class="videoBox_ch_bookmark"><span class="material-symbols-rounded">bookmarks</span>'+item['bookmark']+'</em>'+
	                        '</div>'+
	                    '</div>'+
	                '</div>';
	                $videoList.append($videoLi)
	            }
	            
	            if(videoList.length < 1) video = false;
	            console.log($videoList)
	            $videoList.appendTo($addMoreBox);
            }else{video = false;}
        }
	
	    function autoFitHeight(){
	        $(".autoFitHeight").each(function (index, item) {
	            var width = $(item).innerWidth();
	            $(item).height(width)
	        });
	    }
	
	    $(function(){
	        init();
	
	        $(window).resize(function(){
	            autoFitHeight();
	
	            bottomMore();
	        })
	
	        $(window).scroll(function(){
	        	bottomMore();
	        })
	        
	        /* 앙상블 챌린지 영상 제어 - s */
		    const $videos = $('.videoController video');
	        
	        if($videos.length >= 2){
	        	$videos.each(function(){
	        		$(this).css("width", "50%");
	        	})
	        }
	        
	        $(".thumbnail").click(function(){
	            $videos.each(function() {
                    this.play();
	            });
	            $(this).addClass("hidden");
	        })
		
		    $videos.each(function() {
		        const $video = $(this);
		
		        $video.on('play', function() {
		            $videos.each(function() {
	                    this.play();
		            });
		        });
		
		        $video.on('pause', function() {
		            $videos.each(function() {
		                if (this !== $video[0]) {
		                    this.pause();
		                }
		            });
		        });
		
		        $video.on('seeked', function() {
		            const currentTime = this.currentTime;
		
		            $videos.each(function() {
		                if (this !== $video[0]) {
		                    this.currentTime = currentTime;
		                }
		            });
		        });
		    })
	        /* 앙상블 챌린지 영상 제어 - E */
	    })
	
	    // 페이지 하단인지 확인하고 더보기 실행 함수
	    function bottomMore() {
	        var scrollTop = $(window).scrollTop();
	        var innerHeight = $(window).innerHeight();
	        var scrollHeight = $('body').prop('scrollHeight');
	        if (scrollTop + innerHeight >= scrollHeight && (video)) {
	            var videoIdxList = [];
	            $("input[name='videoIdx']").each(function() {
	                videoIdxList.push($(this).val());
	            });
	
	        	var params = {
	       		    "videoIdxList": videoIdxList.join(",")
	        	}
	        	
	        	$.ajax({
	        	    url: "/ajax_video_more.do",
	        		type : 'POST',
	                dataType: "json",
	                data: params,
	        	    success: function(result){
	        	        console.log(dataList);
	        	        dataList = result;
	        	        console.log(result);
	        	        contentMore($("input.more").val());
	        	    },
	        	    error: function(xhr, status, error){
	        	        console.error("AJAX Error:", error);
	        	        console.error("Server Response:", xhr.responseText); // 서버 응답 확인
	        	    }
	        	});
	        }
	    }
	    
	    document.addEventListener('DOMContentLoaded', function() {
			$.ajax({
				url : "/checkBookmark.do",
				type : "post",
				data : {
					idx : ${videoVO.channel}
				},
				success: function(response) {
					const bookmarkBtn = document.querySelector('.bookmark');
					if(response == "true") {
						bookmarkBtn.classList.add('bookmarked');
					}
					else {
						bookmarkBtn.classList.remove('bookmarked');
					}
				},
				error: function() {
					console.error('즐겨찾기 상태를 확인하는 데 실패했습니다.');
				}
			});
		});
	    
	    function toggleBookmark() {
			const bookmarkBtn = document.querySelector('.bookmark');
			const isBookmarked = bookmarkBtn.classList.contains('bookmarked');
			if (isBookmarked) {
				const confirmRemove = confirm('즐겨찾기를 취소하시겠습니까?');
				if (!confirmRemove) {
					return;
				}
			}
			$.ajax({
				url : isBookmarked  ? "/removeBookmark.do" : "/addBookmark.do",
				type : "post",
				data : {
					idx : ${videoVO.channel}
				},
				success: function(response) {
					bookmarkBtn.classList.toggle('bookmarked');
				},
				error: function() {
					alert("서버에 오류가 발생하였습니다. 잠시 후 다시 시도해주세요");
				}
			});
		}
	    
	 // 별점 생성
	    document.querySelectorAll('.stars').forEach(group => {
	      for (let i = 1; i <= 5; i++) {
	        const star = document.createElement('span');
	        star.classList.add('material-symbols-rounded', 'star-icon');
	        star.textContent = 'star';
	        star.dataset.value = i;
	        group.appendChild(star);
	      }
	    });

	    // 별점 클릭 이벤트
	    document.querySelectorAll('.stars').forEach(group => {
	      group.addEventListener('click', function(e) {
	        if (e.target.classList.contains('star-icon')) {
	          const val = parseInt(e.target.dataset.value);
	          [...group.children].forEach(star => {
	            star.classList.toggle('active', parseInt(star.dataset.value) <= val);
	          });
	          group.dataset.selected = val;
	        }
	      });
	    });


	    // 모달 열기
	    document.querySelector('.rating-btn').addEventListener('click', () => {
	      document.getElementById('ratingModal').classList.remove('hidden');
	    });

	    // 모달 닫기
	    function closeModal() {
	      document.getElementById('ratingModal').classList.add('hidden');
	    }
	    document.querySelector('.modal-overlay').addEventListener('click', closeModal);

	    // 저장 처리
	    document.getElementById('ratingForm').addEventListener('submit', function(e) {
	      e.preventDefault();

	      const data = {
	        skill: document.querySelector('[data-category="skill"]').dataset.selected || 0,
	        manner: document.querySelector('[data-category="manner"]').dataset.selected || 0,
	        charisma: document.querySelector('[data-category="charisma"]').dataset.selected || 0,
	        perform: document.querySelector('[data-category="perform"]').dataset.selected || 0,
	        idx: ${videoVO.idx}
	      };
	      
	      $.ajax({
	        url: '/ajax_modalRating.do',
	        type: 'post',
	        data: data,
	        success: function(response) {
	        	if(response == "success"){
					closeModal();
	        	}
	        	else if(response == "notLogin"){
	        		alert("로그인 후 가능한 기능입니다");
	        	}
	        	else if(response == "alreadyRating"){
	        		alert("이미 완료하신 영상입니다.");
	        	}
	        	else{
					alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
	        	}
        		location.reload();
	        },
	        error: function() {
				alert('오류가 발생했습니다. 잠시 후다시 시도해주세요.');
	        }
	      });
	    });

	    
	 // 신고 버튼 클릭 핸들러
	    $(function(){
	      $('.claim-btn').on('click', function(){
	        var idx = '${videoVO.idx}';

	        $.ajax({
	          url: '/ajax_reports.do',
	          type: 'post',
	          data: {
	        	  idx: idx,
	        	  table : "ch_video"
        	  },
	          success: function(html){
	            $('#reportContent').html(html);
	            $('#modalWrap').removeClass('hidden');
	          },
	          error: function(){
	            alert('신고 내역을 불러오는 데 실패했습니다.');
	          }
	        });
	      });
	    });

	    // 모달 닫기 함수
	    function closeReportModal(){
	      $('#modalWrap').addClass('hidden');
	    }

	</script>
</body>
</html>