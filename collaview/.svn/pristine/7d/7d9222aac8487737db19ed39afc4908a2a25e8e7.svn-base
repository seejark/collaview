$(function(){
    $(".more").click(function(){ // 더보기 리스트 show/hide
        $(this).toggleClass("on");
    })

    /* 비밀번호 입력칸 글자 show/hide toggle - S */
    $(".visible").click(function(){
        $(this).parents(".toggleVisible").find("input").attr("type", "text");
        $(this).addClass("hidden");
        $(this).parents(".toggleVisible").find(".nonvisible").removeClass("hidden");
    })
    $(".nonvisible").click(function(){
        $(this).parents(".toggleVisible").find("input").attr("type", "password");
        $(this).parents(".toggleVisible").find(".visible").removeClass("hidden");
        $(this).addClass("hidden");
    })
    /* 비밀번호 입력칸 글자 show/hide toggle - E */

    var selectLen = ($(".select").length) + 2; // 다른 것과 겹칠까봐 2 추가
    $(".select").each(function(){
        selectInit($(this)); // 커스텀 select 초기화

        // select 개수에 맞춰서 위의 select가 더 상위에 위치하여 아래에 깔리지 않도록 하는 코드
        $(this).css("z-index", selectLen)
        selectLen--;
    })

    // width = height 처리(width에 맞춰서)
    $(".autoSetWH").height($(".autoSetWH").outerWidth(true))
    $(window).resize(function(){ // 화면 사이즈 조정 시
	    $(".autoSetWH").height($(".autoSetWH").outerWidth(true));
	})

	/* select 값 선택 - S */
    $(".select").click(function(){
        // select 클릭 시 리스트 show/hide
        $(this).toggleClass("on");
    })

    // $(".selectList >li").click(function(){
    $("body").on("click", ".selectList >li", function(){ // 이후 추가되는 리스트들 때문에 이 방식으로 변경
        // select 리스트 클릭 시 리스트 hide, 그리고 값 변경
        var value = $(this).attr("data-value");
        var text = $(this).text();
        var $select = $(this).parents(".select");
        $select.find(".selectValue").val(value);
        $select.find(".selectText").text(text);

		var name = $select.attr("data-select") + "Etc";
		var $etc = $("input[name='"+name+"']");
        if(value == "etc"){
			$etc.removeClass("hidden");
		}else{
			$etc.addClass("hidden");
		}
    })
	/* select 값 선택 - E */
})

function selectInit($tag){
    /* select 비어있으면 첫번째 값을 디폴트로 설정 - S */
    var prevVal = $tag.find(".selectValue").val();
    var $selectList = $tag.find(".selectList");
    var $selectLi = $selectList.find(">li");
    if(prevVal == null || prevVal == "" || prevVal == undefined){
        var val = $selectLi.eq(0).attr("data-value");
        var text = $selectLi.eq(0).text();
        $tag.find(".selectValue").val(val);
        $tag.find(".selectText").text(text);
    }
    /* select 비어있으면 첫번째 값을 디폴트로 설정 - E */

    /* select 리스트 데이터가 5개 이상이라면 스크롤하도록 height 고정 - S */
    var selectLiLen = $selectLi.length;
    var height = parseFloat($selectLi.eq(0).css("lineHeight"))
    + parseFloat($selectLi.eq(0).css("padding-top"))
    + parseFloat($selectLi.eq(0).css("padding-bottom"));
    if(selectLiLen > 5){
        $selectList.css("height", (height * 5 + "px"));
    }
    /* select 리스트 데이터가 5개 이상이라면 스크롤하도록 height 고정 - E */
}