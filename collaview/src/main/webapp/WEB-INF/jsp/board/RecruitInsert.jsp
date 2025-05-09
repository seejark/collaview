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
    <title>게시글 작성</title>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/validator.js'/>"></script>
    <script type="text/javascript">
        function fn_validateForm() {
            if (!validateForm(document.boardForm)) {
                return false;
            }
            return true;
        }
    </script>
    <style>
        body {
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
            padding-top: 50px;
            padding-bottom: 70px;
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

        .container {
            padding: 32px 16px 20px 16px;
            max-width: 640px;
            margin: 0 auto;
            box-sizing: border-box;
        }

        .container > .form-group:first-child {
            margin-top: 16px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #333;
        }

        select, input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
        }

        /* date input 스타일 */
        input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
        }

        /* 달력 아이콘 스타일링 */
        input[type="date"]::-webkit-calendar-picker-indicator {
            cursor: pointer;
            padding: 2px;
        }

        /* date input의 placeholder 색상 */
        input[type="date"]::-webkit-datetime-edit-text,
        input[type="date"]::-webkit-datetime-edit-month-field,
        input[type="date"]::-webkit-datetime-edit-day-field,
        input[type="date"]::-webkit-datetime-edit-year-field {
            color: #333;
        }

        .date-range {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .date-range input {
            flex: 1;
        }

        textarea {
            min-height: 200px;
            resize: vertical;
        }

        .file-upload-info {
            font-size: 12px;
            color: #666;
            margin-top: 4px;
        }

        .button-group {
            display: flex;
            gap: 8px;
            margin-top: 24px;
            margin-bottom: 20px;
        }

        .button-group button {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            min-height: 44px;
        }

        .upload-btn {
            background-color: #673AB7;
            color: white;
        }

        .cancel-btn {
            background-color: #333;
            color: white;
        }

        .file-input-group {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-bottom: 16px; /* 추가된 부분 */
        }

        .file-input-group input[type="text"] {
            width: 235px;
            height: 40px;
            box-sizing: border-box;
        }

        .file-actions {
            display: flex;
            gap: 8px;
            margin-top: 0;
        }

        .file-actions button {
            width: 40px;
            height: 40px;
            padding: 8px;
            border: none;
            border-radius: 4px;
            background: #333;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <header class="header" id="header">
        <div class="btn_left">
            <figure class="alarm"><span class="material-symbols-rounded">notifications</span></figure>
        </div>
        <a href="<c:url value='/main.do'/>" class="logo"><img src="<c:url value='/images/logo_s.png'/>" alt="콜라뷰"></a>
        <div class="btn_right">
            <figure class="search"><span class="material-symbols-rounded">search</span></figure>
            <figure class="more"><span class="material-symbols-rounded">more_vert</span></figure>
        </div>
    </header>

    <div class="container">
        <form:form name="boardForm" id="boardForm" method="post" action="/board/write.do" onsubmit="return fn_validateForm();">
            <input type="hidden" name="writer" value="${sessionScope.userId}">
            
            <div class="form-group">
                <label>카테고리</label>
                <select name="category" required>
                    <option value="">선택하세요</option>
                    <option value="채용">채용</option>
                    <option value="밴드모집">밴드모집</option>
                </select>
            </div>

            <div class="form-group">
                <label>기간</label>
                <div class="date-range">
                    <input type="date" id="startDate" name="startDate" required>
                    <span>~</span>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
            </div>

            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" placeholder="제목을 입력하세요" required>
            </div>

            <div class="form-group">
                <label>내용</label>
                <textarea name="content" placeholder="내용을 입력하세요" required></textarea>
                <div class="file-upload-info">* 본 게시판의 성격과 맞지 않는 글은 삭제 될 수 있습니다.</div>
                <div class="file-upload-info">* 비방, 욕설, 허위사실 유포 시 이용이 제한될 수 있습니다.</div>
            </div>

            <div class="form-group">
                <label>사진(파일)</label>
                <div class="file-input-group">
                    <input type="text" id="fileName" placeholder="파일을 선택하세요" readonly>
                    <div class="file-actions">
                        <button type="button" onclick="document.getElementById('file').click();"><span class="material-symbols-outlined">attach_file</span></button>
                        <button type="button" onclick="addFileInput();"><span class="material-symbols-outlined">add</span></button>
                    </div>
                </div>
                <input type="file" id="file" name="file" style="display: none;" accept=".jpg,.jpeg,.png,.zip,.pdf">
                <div class="file-upload-info">* JPG,PNG,ZIP,PDF 파일만 첨부 가능합니다.</div>
                <div class="file-upload-info">* 최대 10개까지 업로드 가능합니다.</div>
            </div>

            <div class="button-group">
                <button type="submit" class="upload-btn">업로드</button>
                <button type="button" class="cancel-btn" onclick="history.back();">취소</button>
            </div>
        </form:form>
    </div>

    <footer class="footer" id="footer">
        <a href="<c:url value='/ranking.do'/>" class="footer_menu ranking">
            <span class="material-symbols-outlined">crown</span>
            <p>랭킹</p>
        </a>
        <a href="<c:url value='/board/list.do'/>" class="footer_menu board">
            <span class="material-symbols-outlined">assignment</span>
            <p>게시판</p>
        </a>
        <a href="<c:url value='/main.do'/>" class="footer_menu main">
            <span class="material-symbols-outlined">home</span>
            <p>메인</p>
        </a>
        <a href="<c:url value='/mychannel.do'/>" class="footer_menu myChannel">
            <span class="material-symbols-outlined">person</span>
            <p>내 채널</p>
        </a>
        <a href="<c:url value='/bookmarks.do'/>" class="footer_menu bookmarks">
            <span class="material-symbols-outlined">bookmark_heart</span>
            <p>즐겨찾기</p>
        </a>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const todayString = today.toISOString().split('T')[0];
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            
            startDateInput.min = todayString;
            endDateInput.min = todayString;
            
            startDateInput.value = todayString;
            endDateInput.value = todayString;
            
            startDateInput.addEventListener('change', function() {
                if(startDateInput.value < todayString) {
                    startDateInput.value = todayString;
                }
                if(startDateInput.value > endDateInput.value) {
                    endDateInput.value = startDateInput.value;
                }
                endDateInput.min = startDateInput.value;
            });
            
            endDateInput.addEventListener('change', function() {
                if(endDateInput.value < todayString) {
                    endDateInput.value = todayString;
                }
                if(endDateInput.value < startDateInput.value) {
                    startDateInput.value = endDateInput.value;
                }
            });

            // 파일 선택 시 파일명 표시
            document.getElementById('file').addEventListener('change', function() {
                const fileName = this.files[0]?.name || '';
                document.getElementById('fileName').value = fileName;
            });
        });

        // 파일 입력 필드 추가
        function addFileInput() {
            // 현재 추가된 파일 입력 그룹의 수를 계산
            const existingFileInputs = document.querySelectorAll('.file-input-group').length;

            // 최대 10개까지만 추가 가능
            if (existingFileInputs >= 10) {
                alert('최대 10개까지 업로드 가능합니다.');
                return;
            }

            const fileInputGroup = document.createElement('div');
            fileInputGroup.className = 'file-input-group';
            fileInputGroup.innerHTML = `
                <input type="text" placeholder="파일을 선택하세요" readonly>
                <div class="file-actions">
                    <button type="button" class="file-upload-btn"><span class="material-symbols-outlined">attach_file</span></button>
                    <button type="button" onclick="this.closest('.file-input-group').remove();"><span class="material-symbols-outlined">remove</span></button>
                </div>
                <input type="file" style="display: none;" accept=".jpg,.jpeg,.png,.zip,.pdf">
            `;
            
            // 파일 입력 그룹을 추가
            document.querySelector('.button-group').before(fileInputGroup);
            
            // 파일 선택 버튼 클릭 시 파일 입력 클릭
            const uploadButton = fileInputGroup.querySelector('.file-upload-btn');
            const fileInput = fileInputGroup.querySelector('input[type="file"]');
            
            uploadButton.onclick = function() {
                fileInput.click();
            };
            
            // 파일 선택 시 파일명 표시
            fileInput.onchange = function() {
                const fileNameInput = fileInputGroup.querySelector('input[type="text"]');
                fileNameInput.value = this.files[0]?.name || '';
            };
        }
    </script>
</body>
</html>