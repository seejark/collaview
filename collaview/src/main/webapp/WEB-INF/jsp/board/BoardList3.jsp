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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background-color: white;
            padding-top: 50px;
            padding-bottom: 50px;
        }

        /* 헤더 스타일 */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 50px;
            background: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 16px;
            z-index: 1000;
            border-bottom: 1px solid #eee;
        }

        .header .btn_left,
        .header .btn_right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header figure {
            margin: 0;
            cursor: pointer;
        }

        .header .logo {
            height: 24px;
        }

        .header .logo img {
            height: 100%;
        }

        /* 푸터 스타일 */
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 50px;
            background: white;
            display: flex;
            justify-content: space-around;
            align-items: center;
            border-top: 1px solid #eee;
            z-index: 1000;
        }

        .footer_menu {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: #666;
            font-size: 12px;
        }

        .footer_menu p {
            margin: 2px 0 0 0;
        }

        .footer_menu span {
            font-size: 20px;
        }

        /* 컨테이너 스타일 */
        .container {
            max-width: 640px;
            margin: 0 auto;
            padding: 0 16px;
            box-sizing: border-box;
            width: 100%;
            background-color: white;
        }

        .top-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 16px;
            margin-bottom: 0;
        }

        select {
            padding: 8px 5px;
            font-size: 12px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: white;
            width: auto;
            height: 30px;
            padding: 0 8px;
            box-sizing: border-box;
        }

        .new-post {
            font-size: 20px;
            cursor: pointer;
            background-color: #333;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            text-decoration: none;
        }

        .item-list {
            padding: 0;
            margin-top: 16px;
            margin-bottom: 60px;
        }

        .item {
            background-color: white;
            padding: 16px 0 0 0;
            display: flex;
            border: none;
            border-bottom: 1px solid #eee;
            flex-wrap: nowrap;
            gap: 16px;
            overflow: hidden;
        }

        .item-content {
            flex: 1;
            min-width: 0;
        }

        .item-category {
            font-size: 12px;
            color: #666;
            margin-bottom: 5px;
        }

        .item-title {
            font-weight: bold;
            margin-bottom: 5px;
            font-size: 16px;
            word-break: break-all;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .item-description {
            font-size: 14px;
            color: #999;
            margin-bottom: 5px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            word-break: break-all;
        }

        .item-meta {
            display: flex;
            flex-wrap: wrap;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
            margin-bottom: 5px;
            gap: 8px;
        }

        .meta-item {
            display: flex;
            align-items: center;
        }

        .item-meta .material-icons {
            font-size: 14px;
            margin-right: 2px;
        }

        .item-image-container {
            width: 70px;
            height: 70px;
            flex-shrink: 0;
            overflow: hidden;
            background-color: #eee;
            border-radius: 5px;
            margin: 3px 0 8px 0;
        }

        .item-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .loading {
            padding: 20px;
            text-align: center;
            color: #666;
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 16px;
            }
            .item {
                padding: 16px 0 0 0;
                gap: 12px;
            }
            .item-title {
                font-size: 14px;
            }
            .item-description {
                font-size: 12px;
            }
            .meta-item {
                font-size: 11px;
            }
        }
    </style>
</head>
<body>
    <header class="header" id="header">
        <div class="btn_left">
            <figure class="alarm"><span class="material-symbols-rounded">notifications</span></figure>
        </div>
        <a href="#" class="logo"><img src="/images/logo_s.png" alt="콜라뷰"></a>
        <div class="btn_right">
            <figure class="search"><span class="material-symbols-rounded">search</span></figure>
            <figure class="more"><span class="material-symbols-rounded">more_vert</span></figure>
        </div>
    </header>

    <div class="container">
        <div class="top-controls">
            <select id="categorySelect">
                <option value="전체">전체</option>
                <option value="공지사항">공지사항</option>
                <option value="자유게시판">자유게시판</option>
                <option value="구인구직">구인구직</option>
                <option value="밴드모집">밴드모집</option>
            </select>
            <a href="<c:url value='/board/write.do'/>" class="new-post">
                <span class="material-icons">edit</span>
            </a>
        </div>
        <div class="item-list" id="itemList"></div>
        <div class="loading" id="loading">로딩중...</div>
    </div>

    <footer class="footer" id="footer">
        <a href="#" class="footer_menu ranking">
            <span class="material-symbols-outlined">crown</span>
            <p>랭킹</p>
        </a>
        <a href="#" class="footer_menu board">
            <span class="material-symbols-outlined">assignment</span>
            <p>게시판</p>
        </a>
        <a href="#" class="footer_menu main">
            <span class="material-symbols-outlined">home</span>
            <p>메인</p>
        </a>
        <a href="#" class="footer_menu myChannel">
            <span class="material-symbols-outlined">person</span>
            <p>내 채널</p>
        </a>
        <a href="#" class="footer_menu bookmarks">
            <span class="material-symbols-outlined">bookmark_heart</span>
            <p>즐겨찾기</p>
        </a>
    </footer>

    <script>
        let currentPage = 0;
        const itemsPerPage = 10;
        let isLoading = false;
        let hasMoreItems = true;
        const itemList = document.getElementById('itemList');
        const loadingElement = document.getElementById('loading');
        const categorySelect = document.getElementById('categorySelect');
        
        function createItemHTML(item) {
            return `
                <div class="item" data-id="${item.idx}">
                    <div class="item-content">
                        <div class="item-category">
                            <span style="background-color: #666; color: white; padding: 2px 6px; border-radius: 3px;">
                                ${item.category}
                            </span>
                        </div>
                        <div class="item-title">${item.title}</div>
                        <div class="item-description">${item.contents}</div>
                        <div class="item-meta">
                            <div class="meta-item user">${item.user}</div>
                            <div class="meta-item">
                                <span class="material-icons">schedule</span> 
                                /* ${new Date(item.registerDate).toLocaleDateString()} */
                            </div>
                            <div class="meta-item">
                                <span class="material-icons light-icon">visibility</span> 
                                ${item.viewCount}
                            </div>
                            <div class="meta-item">
                                <span class="material-icons light-icon">chat</span> 
                                ${item.commentCount}
                            </div>
                        </div>
                    </div>
                    <div class="item-image-container">
                        <img src="${item.fileName ? '<c:url value="/upload/"/>' + item.fileName : 'https://via.placeholder.com/70'}" 
                             alt="${item.originName || ''}" 
                             class="item-image"
                             onerror="this.src='https://via.placeholder.com/70'">
                    </div>
                </div>
            `;
        }
        
        function loadItems() {
            if (isLoading || !hasMoreItems) return;
            
            isLoading = true;
            loadingElement.style.display = 'block';
            
            const category = categorySelect.value;
            
            $.ajax({
                url: "<c:url value='/board/getList.do'/>",
                type: "GET",
                data: {
                    pageIndex: currentPage + 1,
                    pageUnit: itemsPerPage,
                    category: category
                },
                success: function(data) {
                    if (data.resultList && data.resultList.length > 0) {
                        const fragment = document.createDocumentFragment();
                        data.resultList.forEach(item => {
                            const tempDiv = document.createElement('div');
                            tempDiv.innerHTML = createItemHTML(item);
                            fragment.appendChild(tempDiv.firstElementChild);
                        });
                        itemList.appendChild(fragment);
                        currentPage++;
                        
                        hasMoreItems = (currentPage * itemsPerPage) < data.resultCnt;
                    } else {
                        hasMoreItems = false;
                    }
                    
                    isLoading = false;
                    loadingElement.style.display = hasMoreItems ? 'none' : 'block';
                    if (!hasMoreItems) {
                        loadingElement.textContent = '모든 게시글을 불러왔습니다.';
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    isLoading = false;
                    loadingElement.textContent = '게시글을 불러오는데 실패했습니다.';
                }
            });
        }
        
        // 초기 로딩
        loadItems();

        // 카테고리 변경 이벤트
        categorySelect.addEventListener('change', function() {
            currentPage = 0;
            hasMoreItems = true;
            itemList.innerHTML = '';
            loadItems();
        });

        // Intersection Observer 설정
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting && !isLoading) {
                    loadItems();
                }
            });
        }, {
            root: null,
            rootMargin: '100px',
            threshold: 0.1
        });

        observer.observe(loadingElement);

        // 스크롤 이벤트
        let scrollTimeout;
        window.addEventListener('scroll', () => {
            if (scrollTimeout) clearTimeout(scrollTimeout);
            
            scrollTimeout = setTimeout(() => {
                const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
                if (scrollTop + clientHeight >= scrollHeight - 100 && !isLoading && hasMoreItems) {
                    loadItems();
                }
            }, 100);
        });

        // 게시글 클릭 이벤트
        itemList.addEventListener('click', function(e) {
            const item = e.target.closest('.item');
            if (item) {
                const id = item.dataset.id;
                location.href = "<c:url value='/board/detail.do'/>?idx=" + id;
            }
        });
    </script>
</body>
</html>