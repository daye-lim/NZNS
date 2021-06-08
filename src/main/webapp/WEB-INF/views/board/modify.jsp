<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<link rel="stylesheet" href="/resources/css/board.css">
 <%@ include file ="../includes/header.jsp" %>

<div id="content">
            <div class="row">
                <div class="col-lg-12">
                     <h1 class="page-header">게시글 수정</h1>                    
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    
                        <div class="panel-heading"></div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                        	<form role="form" action="/board/modify" method="post">
						<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
 						  			<tr>
                                        <th><label> Bno</label></th>
                                        <td><input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"></td>
                                    </tr>
                        	
   									<tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title' value='<c:out value="${board.title }"/>'></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="20" class="form-control" rows="3" name='content'><c:out value="${board.content }"/></textarea></td>
                                    </tr>
                                    <tr>
                                        <th><label>Writer</label></th>
                                        <td> <input class="form-control" name='writer' value='<c:out value="${loginResult.id }"/>' readonly="readonly"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>RegDate</label></th>
                                        <td><input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate}" />' readonly="readonly"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>updateDate</label></th>
                                        <td><input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate}" />' readonly="readonly"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th colspan="2">
                                        <div class="regBtn">
				                            <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
				                        	<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
				                        	<button type="submit" data-oper='list' class="btn btn-info">List</button>
 										</div>
 										</th>
                                    </tr>
                              </thead>
                            </table>
                        	
                       	
                        	
                        	<!-- pageNum,amount,type,keyword 값을 form태그 내에서 같이 전송할 수 있게 함 -->
                        		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        	
                        	
							</form>
                        	        
                        </div>
                        
                  
                        <!-- /.panel-body -->
                        
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            
     <!-- 첨부파일이 보여질 영역 -->
            <div class='bigPictureWrapper'>
             <div class='bigPicture'><!-- 첨부파일 원본 이미지를 보여주는 부분 -->
             </div>
            </div>
            
            
</div>            

            <div class="row">
		 <div class="col-lg-12">
		  <div class="panel panel-default">
		  
		    <div class="panel-heading">Files</div>		
		    <!-- /.panel-heading -->  
		    <div class="panel-body">
		     <div class="form-group uploadDiv">
		     	<input type="file" name='uploadFile' multiple="multiple">
		     </div>
		    
		    <div class='uploadResult'> <!-- 크게 첨부파일 목록을 보여주는 부분 -->
		      <ul>
		      </ul>
		    </div>
		    
	                        </div>
                        <!-- /. end panel-body -->
                        
                    </div>
                    <!-- /.panel-default -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
                                    
<script type="text/javascript">


$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on("click",function(e){
	
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
		    if(confirm("삭제 하시겠습니까?")){
				  formObj.attr("action","/board/remove");
		        }
		    else {return false;}
		}else if(operation === 'list'){
			// 클릭한 버튼이 List인 경우 action 속성과 method속성을 변경한다
			//move to list
			
//목록페이지는 오직 pageNum과 amount만을 사용하므로 <form>태그의 다른 내용은 삭제하고 필요한 내용만을 다시 추가하는 형태로 셋팅	
// + keyword,type
// 사용자가 List 버튼을 클릭하면, <form>태그에서 필요한 부분만 잠시 복사(clone)해서 보관해두고
// <form>태그내의 모든 내용은 지워버림(empty)
// 이후에 다시 필요한 태그들만 추가하여 /board/list를 호출
			formObj.attr("action","/board/list").attr("method","get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		
		// 첨부파일 게시물 수정작업
		else if(operation === 'modify'){
			
			console.log("submit clicked");
			
			var str="";
			
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				// 브라우저에서 게시물 등록을 하면 이미 업로드된 항목들을 내부적으로 <input type='hidden'>태그들로 만들어서 <form>태그가 submit될 때 같이 전송되도록 한다
				str += "<input type='hidden' name='attachList["+i+"].fileName'value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid'value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath'value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType'value='"+jobj.data("type")+"'>";
			});
			formObj.append(str).submit();
			
			
		}
		// board/list로의 이동은 아무런 파라미터가 없기 때문에 form태그의 모든 내용은 삭제한 상태에서 submit()진행
		formObj.submit();
		
	});
});

//게시물 수정화면에서 첨부파일 데이터 보여주기
$(document).ready(function(){
	(function(){
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			
			console.log(arr);
			
			//첨부파일 보여주기
			var str = "";
			
			$(arr).each(function(i, attach){
				
				//image type
				if(attach.fileType){
					var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> "+ attach.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				} else {
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> "+ attach.fileName+"</span><br/>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str + "</li>"
				}
			});
			
			$(".uploadResult ul").html(str);
			
		}); //end getjson
		
	})(); //end function
	
	
	$(".uploadResult").on("click","button", function(e){
		
		console.log("delete file");
		
		if(confirm("Remove this file? ")){
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
			
		}
	});

	
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
			success : function(result){
				console.log(result);
				showUploadResult(result);
			}
	}); // end $.ajax
});
	

function showUploadResult(uploadResultArr){ // 업로드 결과를 화면에 처리
	if(!uploadResultArr || uploadResultArr.length == 0) { return; }
	
	var uploadUL = $(".uploadResult ul");
	
	var str="";
	
	$(uploadResultArr).each(function(i,obj){
		
		
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
	
});
</script>

 <%@include file="../includes/footer.jsp" %>
             

