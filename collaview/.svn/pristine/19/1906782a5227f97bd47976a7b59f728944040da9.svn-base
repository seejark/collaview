<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="/css/channel_user.css">
</head>
<body>
	<jsp:include page="/header.jsp" />

	<div class="channel-thumbnail"
		<c:if test="${channelVO.thumbnail_file ne null && channelVO.thumbnail_file ne ''}">
			style="background-image: url('/file/thumbnail/${channelVO.thumbnail_file}');"</c:if>>
		<div class="channel-header">
			<div>
				<div class="avatar"><img src="/file/profile/${channelVO.profile_file}" alt="${channelVO.profile_origin}"></div>
				<div class="nickName">${userVO.nick}</div>
			</div>
			<div class="channel-info">
				<div class="channel-title">
					<div class="header-title-wrapper">
						<span class="channel-name">${channelVO.name}</span>
						<div class="verified-icon channelLevel rank${channelVO.rank}"></div>
					</div>
					<button onclick="toggleBookmark()" class="bookmark">즐겨찾기</button>
				</div>
				<div class="channel-subtitle">
					<div>즐겨찾기 수:${bookmarkCnt}</div>
					<div>마지막 영상 등록일:${last_upload_date}</div>
				</div>
			</div>
		</div>
	</div>

	<main id="container" class="container">

		<div class="channel-description wrap">${channelVO.contents}</div>

		<div class="wrap">
			<h2 class="video">영상</h2>

			<div class="filters">
				<div class="sortSelect">
					<div class="chip" id="sort-date">최신순</div>
					<div class="chip" id="sort-view">조회수</div>
				</div>
				<div class="chip" id="sort-order">오름차순</div>
			</div>

			<div class="video-list">
				<c:forEach var="video" items="${videoList}">
					<div class="video-item" data-date="${video.register_date}" data-view="${video.view}" onclick="location.href='/video_page.do?idx=${video.video}'">
						<div class="video-thumbnail">
							<c:if test="${video.thumbnail_file ne null && video.thumbnail_file ne ''}">
								<img src="/file/video/${video.thumbnail_file}" alt="${video.thumbnail_origin}">
							</c:if>
							<c:if test="${video.thumbnail_file eq null || video.thumbnail_file eq ''}">
								<video src="/file/video/${video.file_name}"></video>
							</c:if>
						
						</div>
						<div class="video-info">
							<div class="video-title">${video.title}</div>
							<ul class="video-meta">
								<li>${fn:substring(video.register_date, 0, 10)}</li>
								<li>${video.view}</li>
							</ul>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
	<jsp:include page="/footer.jsp" />
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		  const sortDateChip = document.getElementById('sort-date');
		  const sortViewChip = document.getElementById('sort-view');
		  const orderChip = document.getElementById('sort-order');
		  
		  let sortKey = 'date';
		  let sortOrder = 'desc';
		  
		  function sortVideos() {
		    const videoListElem = document.querySelector('.video-list');
		    const videoItems = Array.from(videoListElem.querySelectorAll('.video-item'));
		    
		    videoItems.sort((a, b) => {
		      let aVal, bVal;
		      if (sortKey === 'date') {
		        aVal = new Date(a.dataset.date);
		        bVal = new Date(b.dataset.date);
		      } else if (sortKey === 'view') {
		        aVal = Number(a.dataset.view);
		        bVal = Number(b.dataset.view);
		      }
		      if (aVal < bVal) return sortOrder === 'asc' ? -1 : 1;
		      if (aVal > bVal) return sortOrder === 'asc' ? 1 : -1;
		      return 0;
		    });
		    
		    videoItems.forEach(item => videoListElem.appendChild(item));
		  }
		  
		  sortDateChip.addEventListener('click', function() {
		    sortKey = 'date';
		    sortDateChip.classList.add('active');
		    sortViewChip.classList.remove('active');
		    sortVideos();
		  });
		  
		  sortViewChip.addEventListener('click', function() {
		    sortKey = 'view';
		    sortViewChip.classList.add('active');
		    sortDateChip.classList.remove('active');
		    sortVideos();
		  });
		  
		  orderChip.addEventListener('click', function() {
		    sortOrder = (sortOrder === 'asc') ? 'desc' : 'asc';
		    orderChip.textContent = (sortOrder === 'asc') ? '내림차순' : '오름차순';
		    sortVideos();
		  });
		  
		  sortVideos();
		  
		  let videoPage = 1;
		  let isLoading = false;
		  let noMoreData = false;
		  
		  function loadMoreVideos() {
		    if (isLoading || noMoreData) return;
		    isLoading = true;
		    
		    const url = "/loadMoreVideos.do";
		    
		    $.ajax({
		      url: url,
		      method: 'post',
		      data : {
		    	  idx : ${channelVO.idx},
		    	  videoPage : videoPage+1
		      },
		      success: function(data) {
		        if ($.trim(data) === '') {
		          noMoreData = true;
		        } else {
		          const videoListElem = document.querySelector('.video-list');
		          const tempDiv = document.createElement('div');
		          tempDiv.innerHTML = data;
		          const newItems = tempDiv.querySelectorAll('.video-item');
		          newItems.forEach(item => videoListElem.appendChild(item));
		          videoPage++;
		          sortVideos();
		        }
		      },
		      error: function(xhr, status, error) {
		        console.error('Error loading more videos:', error);
		      },
		      complete: function() {
		        isLoading = false;
		      }
		    });
		  }
		  
		  window.addEventListener('scroll', function() {
		    if ((window.innerHeight + window.scrollY) >= (document.body.offsetHeight - 500)) {
		      loadMoreVideos();
		    }
		  });
		});
		
		document.addEventListener('DOMContentLoaded', function() {
			$.ajax({
				url : "/checkBookmark.do",
				type : "post",
				data : {
					idx : ${channelVO.idx}
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
					return; // 사용자가 취소를 선택하면 함수 종료
				}
			}
			$.ajax({
				url : isBookmarked  ? "/removeBookmark.do" : "/addBookmark.do",
				type : "post",
				data : {
					idx : ${channelVO.idx}
				},
				success: function(response) {
					bookmarkBtn.classList.toggle('bookmarked');
				},
				error: function() {
					alert("서버에 오류가 발생하였습니다. 잠시 후 다시 시도해주세요");
				}
			});
		}

	</script>

</body>
</html>