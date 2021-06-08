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
                     <h1 class="page-header">공지사항 수정</h1>                    
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
                        
                        	<form role="form" action="/notice/NoticeModify" method="post">
						<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
 						  			<tr>
                                        <th><label> No</label></th>
                                        <td><input class="form-control" name='nno' value='<c:out value="${notice.nno }"/>' readonly="readonly"></td>
                                    </tr>
                        	
   									<tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title' value='<c:out value="${notice.title }"/>'></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="30" class="form-control" rows="3" name='content'><c:out value="${notice.content }"/></textarea></td>
                                    </tr>
                                    <tr>
                                        <th><label>Writer</label></th>
                                        <td> <input class="form-control" name='writer' value='<c:out value="${loginResult.id }"/>' readonly="readonly"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>RegDate</label></th>
                                        <td><input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${notice.regdate}" />' readonly="readonly"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>updateDate</label></th>
                                        <td><input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${notice.updateDate}" />' readonly="readonly"></td>
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
            
 
                                    
<script type="text/javascript">


$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on("click",function(e){
	
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
		    if(confirm("삭제 하시겠습니까?")){
				  formObj.attr("action","/notice/NoticeRemove");
		        }
		    else {return false;}
		}else if(operation === 'list'){
			// 클릭한 버튼이 List인 경우 action 속성과 method속성을 변경한다
			//move to list
			
//목록페이지는 오직 pageNum과 amount만을 사용하므로 <form>태그의 다른 내용은 삭제하고 필요한 내용만을 다시 추가하는 형태로 셋팅	
// + keyword,type
// 사용자가 List 버튼을 클릭하면, <form>태그에서 필요한 부분만 잠시 복사(clone)해서 보관해두고
// <form>태그내의 모든 내용은 지워버림(empty)
// 이후에 다시 필요한 태그들만 추가하여 /notice/list를 호출
			formObj.attr("action","/notice/NoticeList").attr("method","get");
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
		
		//첨부파일 게시물 수정
		else if(operation === 'modify'){
			
			console.log("submit clicked");
			
			var str="";
			
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
			});
			formObj.append(str).submit();
			
			
		}
		// notice/list로의 이동은 아무런 파라미터가 없기 때문에 form태그의 모든 내용은 삭제한 상태에서 submit()진행
		formObj.submit();
		
	});
});


</script>

 <%@include file="../includes/footer.jsp" %>
             

