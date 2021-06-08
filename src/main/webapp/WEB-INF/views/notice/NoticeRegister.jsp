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
 		<h1 class="page-header">공지사항 작성</h1>
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
 				<form role="form" action="/notice/NoticeRegister" method="post">
 					<div class="form-group">
 					
 					
 					<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
                                    <tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title'></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="30" class="form-control" rows="3" name='content'></textarea></td>
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
                           

                                <c:forEach items="${list}" var="notice">
                                	<tr>
                                		<td><c:out value="${notice.nno}" /></td>
                                		<td><a class="move" href='<c:out value="${notice.nno}" />'><c:out value="${notice.title}" />
                                		</a></td>
                                		<td><c:out value="${notice.writer}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.updateDate}" /></td>
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
		});
		formObj.append(str).submit();

		
	});
});	
</script>
  
  
  
 <%@include file="../includes/footer.jsp" %>
