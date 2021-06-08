<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.uploadResult{
	width:100%;
	background-color:gray;
}

.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}

.uploadResult ul li {
	list-style:none;
	padding:10px;
	align-content:center;
	text-align:center;
}

.uploadResult ul li img{
	width:100px;
}

.uploadResult ul li span{
	color:white;
	}

.bigPictureWrapper{
	position:absolute;
	display:none;
	justify-content:center;
	align-items:center;
	top:0%;
	width:100%;
	height:100%;
	background-color:gray;
	z-index: 100;
	background:rgba(255,255,255,0.5);
	}

.bigPicture{
	position:relative;
	display:flex;
	justify-content:center;
	align-items:center;
}

.bigPicture img{
	width:600px;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>

<h1>Upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<!-- 실제 원본 이미지를 보여주는 영역 -->
<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>


<!-- 첨부파일 이름을 목록으로 처리할 수 있도록 한다 -->
  <div class="uploadResult">
    <ul>
    
    </ul>  
  </div>

<button id="uploadBtn">Upload</button>





<!-- jquery라이브러리 경로 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<script type="text/javascript">



//섬네일 파일 클릭했을 때 화면에 원본 이미지를 보여준다
//화면 가운데 div를 배치하고 <img>태그 추가->animate를 이용해서 효과처리
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture")
	.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
	.animate({width:'100%',height:'100%'},1000);
}




$(document).ready(function(){

	var uploadResult = $(".uploadResult ul");
	
	
	// 목록을 보여주는 부분을 처리하는 함수
	function showUploadedFile(uploadResultArr){
		// JSON 데이터를 받아서 해당 파일의 이름을 추가
		
		var str="";
		
		$(uploadResultArr).each(function(i, obj){
			if(!obj.image){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			// attach.png파일을 클릭하면 다운로드에 필요한 경로와 UUID가 붙은 파일 이름을 이용해서 다운로드가
			// 가능하도록 <a>태그를 이용한다
			str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+"<img src='/resources/img/attach.png'>"
				+ obj.fileName + "</a>"+"<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>" + "<div></li>"
				//<span>태그를 이용해서 x 표시 추가


				
		}else{
			// encodeURIComponent()함수를 이용해서 URI 호출에 적합한 문자열로 인코딩 처리한다
			// 섬네일이미지이름 = '업로드된경로+/s+UUID+파일이름'
			// 원본이미지이름 = '업로드된경로+/+UUID+파일이름'
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
			originPath = originPath.replace(new RegExp(/\\/g),"/");
			// 이미지첨부파일이름을 하나의 문자열로 생성한뒤 showImage()에 파라미터로 전달
				
			str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
			"<img src='/display?fileName="+fileCallPath+"'></a>"+
			"<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
			"<li>";
		}
		});
		
		uploadResult.append(str);
	}
	
	
	// x표시에 대한 이벤트 처리 (<span>태그를 이용해서 x 표시 추가한거)
	$(".uploadResult").on("click","span",function(e){
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName: targetFile, type:type},
			datatype:'text',
			type: 'POST',
				success : function(result){
					alert(result)
				}
		}); //end of $.ajax
	});
	
	
	
	
	
	// exe, sh, zip 등의 확장자인 경우 업로드를 제한 (JS의 정규표현식을 이용해서 검사)
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB
	
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	// <input type='file'>의 초기화
	var cloneObj = $(".uploadDiv").clone(); // <input type='file'>객체가 포함된 div를 복사
	// 첨부파일 업로드한 뒤 복사된 객체를 <div>내에 다시 추가해서 첨부파일 부분을 초기화시킨다	
	
	$("#uploadBtn").on("click", function(e){
		
		// 파일업로드에 사용하는 객체 - FormData를 이용해서 필요한 파라미터를 담아서 전송한다
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
		
		
		//add filedate to formdata
		for(var i=0; i<files.length; i++){
			
		// 첨부파일 업로드 시 for루프에서 checkExtension()을 호출해서 확장자/파일크기 체크
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,		// flase로 지정해야지 formData자체가 전송된다
			contentType : false,		// flase로 지정해야지 formData자체가 전송된다
			data : formData,
				type : 'POST',
				datatype:'json',		// Ajax를 호출했을 때 결과타입은 json
				success : function(result){ // 결과를 consloe.log()로 찍도록 설정한다
					
					console.log(result);
				
					// Ajax결과에서 받은 JSON데이터를 shwoUploadedFile()을 호출하도록한다
					showUploadedFile(result);
				
					// 첨부파일 업로드한 뒤 복사된 객체를 <div>내에 다시 추가해서 첨부파일 부분을 초기화시킨다
					$(".uploadDiv").html(cloneObj.html());
			}
		}); // end $.ajax
		
		
	});
});

</script> 
</body>
</html>