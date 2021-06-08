/**
 * 
 */
$(document).ready(function(){
	jQuery.ajaxSetup({cache:false});
	
	
	//메뉴 드롭다운 슬라이드 효과
	$("li.filterOpt").on("click", function(e){
		$("li.filterOpt").find("ul.sublist").each(function(idx, ele){//다른 버튼을 누르면 이미 열린애들은 닫아주기
			if(ele.clientHeight != 0) $(ele).hide(); 
		});//end ul.sublist반복
		
		$(e.target).find("ul.sublist").slideToggle();
	});//end .filterOpt onClick
	
	//sub메뉴가 열렸을 때 누르면 부모인 li.filterOpt에 이벤트 전파 방지
	$("ul.sublist").on("click", function(e){
		e.stopPropagation();
	});//end ul.sublist onClick
	
	$(document).mouseup(function(e){// 버튼 눌렀다가 다른데 누르면 드롭다온 사라짐. 
		if($(e.target).parents().filter("ul#filterList").length == 0){
			$("li.filterOpt").find("ul.sublist").each(function(idx, ele){//다른 버튼을 누르면 이미 열린애들은 닫아주기
				if(ele.clientHeight != 0) $(ele).hide(); 
			});//end ul.sublist반복
		};
	});//end mouseup 
	
	// 가격대 버튼 드롭다운 range 바
	$("input[type=range]").on("change", function(e){
		var result = $(e.target).val();
		if($(e.target).val().length > 4){
			var million = $(e.target).val().charAt(0);
			var hundred = $(e.target).val().substring(1);
			result = million+"억"+hundred;
		}
		$(".searchRange").text(result+"만원~무제한");
	});//end input[type=range] onChagne
	
	$("button#searchBtn").on("click", function(e){
		if($("input[name=search]").val().trim().length == 0){
			e.preventDefault();
			alert("검색어를 입력하여주세요");
		}
	});//end searchBtn onClick
	
	var yrent; // 가격대 조절 바 값을 저장
	$("input[type=range]").on("change", function(e){// 값 저장은 바를 조절 했을 때만
		setTimeout(function(e){
			yrent = $("input[type=range]").val();
			$("input.filter, select.filter").trigger("change");
		});
	});// end input[type=range] onChange 

	 $("input.filter, select.filter").on("change", function(){
		var filters = [];
		$("input.filter").each(function(idx, ele){
			if(ele.checked) filters.push($(ele).val());
		});//end each
		
		if($("select.filter").val() != "선택해주세요") {
			filters.push($(this).val());
		}
		
		if(yrent != undefined){
			filters.push("yrent" + yrent);
		}
		
		console.log(filters);
		
		////// ajax 시작
	 	$.ajax({
			type:'get',
			url:'HouseListServlet',
			data:{
				filters : filters.toString()
			},
			dataType: "html",
			success:function(data, status, xhr){
				$("div#mainWrap").html($(data).nextAll("div#mainWrap"));
			},
			error:function(xhr, status, error){console.log(error)},
			error:function(xhr, status, error){console.log(status)}
		});//end ajax 
	}); // end input[name=rtype] onChange 
	
	$("li#filterInitializer").on("click", function(e){
		location.href="HouseListServlet";
//		$("input.filter").each(function(idx, ele){
//			if(ele.checked) {
//				$(ele).prop("checked", false);
//			};
//		});//방타입, 월세/전세, 관리비 버튼 초기화
//		
//		$("select.filter").find("option").each(function(idx, ele){
//			if($(ele).val() == "선택해주세요"){
//				$(ele).prop("selected", true);
//			}
//		});// 가격대 버튼 월세값 초기화 
//			
//		var yrent;
//		$("input[type=range]").val(10000);
//		$("span.searchRange").text("");
//		
//		$("input.filter, select.filter").trigger("change");
		 
	});
	
});//end ready