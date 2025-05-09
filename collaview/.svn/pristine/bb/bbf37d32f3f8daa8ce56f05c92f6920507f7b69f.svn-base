<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" href="/css/video_keywordEdit.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
</head>
<body>
	<div class="modal-container">
		<div class="keywordEdit-title">키워드 편집</div>
		<div class="selectKeyword-wrap"></div>
		<div class="search-wrap">
			<input type="text" name="searchKeyword" class="searchKeyword">
			<span class="material-symbols-rounded">search</span>
		</div>
		<div class="keywordWrap">
			<c:forEach var="keyword" items="${keywordList}" varStatus="st">
				<div class="keyword">${keyword.name}</div>
			</c:forEach>
		</div>
	</div>
	<script>
	  $(function(){
		    $('.keywordWrap').on('click', '.keyword', function(){
		      var $kw  = $(this);
		      var name = $.trim($kw.text());

		      if ($kw.hasClass('active')) {
		        $kw.removeClass('active').show();
		        $('.selectKeyword-wrap')
		          .find('.selected-keyword[data-name="'+name+'"]')
		          .remove();
		      }
		      else {
		        $kw.addClass('active').hide();

		        var $pill = $(
		          '<div class="selected-keyword" data-name="'+name+'">'+
		            name+
		          '</div>'
		        );
		        $('.selectKeyword-wrap').append($pill);
		      }
		    });

		    $('.selectKeyword-wrap').on('click', '.selected-keyword', function(e){
		      e.stopPropagation(); 
		      var $pill = $(this).hasClass('selected-keyword')
		                  ? $(this)
		                  : $(this).closest('.selected-keyword');
		      var name  = $pill.data('name');

		      $pill.remove();

		      $('.keywordWrap .keyword').filter(function(){
		        return $.trim($(this).text()) === name;
		      }).removeClass('active').show();
		    });
		  });

	</script>
</body>
</html>
