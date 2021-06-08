<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
  <%@ include file ="../includes/header.jsp" %>   

<link rel="stylesheet" href="/resources/css/board.css">
<style>
.regBtn{
position:relative;
left:450px;}


</style>


<div id="content">


 <div class="row">
 	<div class="col-lg-12">
 		<h1 class="page-header">글쓰기</h1>
 		</div>
 		<!-- /.col-lg-12 -->
 </div>
 <!-- /.row -->
 
 <div class="row">
 	<div class = "col-lg-12">
 		<div class="panel panel-default">
 			
 			<div class="panel-heading"></div>
 			<!-- /.panel-heading -->
 			<div class="panel-body">
 				<form role="form" action="/board/register" method="post">
 					<div class="form-group">
 					
 					
 					<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
                                    <tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title'></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="20" class="form-control" rows="3" name='content'></textarea></td>
                                    </tr>
                                    <tr>
                                        <th><label>Writer</label></th>
                                        <td> <input class="form-control" name='writer' value="${loginResult.id}" readonly></td>
                                    </tr>
                                    <tr>
                                        <th colspan="2">
                                        <div class="regBtn">
                                        <button type="submit" class="btn btn-default">글쓰기</button>
 										<button type="reset" class="btn btn-default">취소</button>
 										</div>
 										</th>
                                    </tr>

                                    
                           </thead>
                           

                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}" /></td>
                                		<td><a class="move" href='<c:out value="${board.bno}" />'><c:out value="${board.title}" />
                                		<b>[ <c:out value="${board.replyCnt}" />]</b></a></td>
                                		<td><c:out value="${board.writer}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
                                	</tr>
                                </c:forEach>
                               
                            </table>                                   
                            
                     </div>       
 				</form>
 			</div>
 			<!-- end panel-body -->
 		</div>
 		<!-- end panel -->
 	</div>
 	<!-- col-lg-12 -->
 
 </div>
 <!-- /.row -->
 
 
 
<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>

	
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
	
	 </div>
	</div>
	





<script>	

$(document).ready(function(e){
	
	// submit btn 기본동작 막는 작업
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		
		console.log("submit clicked");
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			
			console.dir(jobj);
			//p.564
			// 브라우저에서 게시물 등록을 하면 이미 업로드된 항목들을 내부적으로 <input type='hidden'>태그들로 만들어서 <form>태그가 submit될 때 같이 전송되도록 한다
			str += "<input type='hidden' name='attachList["+i+"].fileName'value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid'value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath'value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType'value='"+jobj.data("type")+"'>";
		});
		formObj.append(str).submit();

		
	});
	
	// <input type='file'>의 내용이 변경되면 파일업로드가 되게하는 작업
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
	
$("input[type='file']").change(function(e){
	
	// 파일업로드에 사용하는 객체 - FormData를 이용해서 필요한 파라미터를 담아서 전송한다
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;

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
		processData : false,
		contentType : false,
		data: formData,
		type : 'POST',
		datatype:'json',		// Ajax를 호출했을 때 결과타입은 json
			success : function(result){ // 결과를 consloe.log()로 찍도록 설정한다
				console.log(result);
				showUploadResult(result); // 업로드 결과 처리 함수
			}
	}); // end $.ajax
});
	
//p.558
function showUploadResult(uploadResultArr){ // 업로드 결과를 화면에 처리
	if(!uploadResultArr || uploadResultArr.length == 0) { return; }
	
	var uploadUL = $(".uploadResult ul");
	
	var str="";
	
	$(uploadResultArr).each(function(i,obj){
		
		//p.559
		// image type(이미지파일인경우 / 일반파일인경우)
		if(obj.image){
			var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
			
			str += "<li data-path='"+obj.uploadPath+"'";
			str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'"
			str +" ><div>";
			str += "<span> " + obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str + "</li>";
			
		} else{
			var fileCallPath = encodeURIComponent( obj.uploadPath+ "/" + obj.uuid + "_" + obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' "
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png'></a>";
			str += "</div>";
			str + "</li>";
		}
		
	});
	
	uploadUL.append(str);
}

//p.560 첨부파일의 변경 처리
$(".uploadResult").on("click", "button", function(e){
	
	console.log("delete file");
	
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	
	var targetLi = $(this).closest("li");
	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType:'text',
		type: 'POST',
		success:function(result){
			alert(result);
			targetLi.remove();
		}
	});
});
});
</script>
  
  
  
 <%@include file="../includes/footer.jsp" %>
