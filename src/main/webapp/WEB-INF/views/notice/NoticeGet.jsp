<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<link rel="stylesheet" href="/resources/css/board.css">
 <%@ include file ="../includes/header.jsp" %>
 <style>
 #getLogin{
	text-decoration: underline;
	color: red;
}

#replyList{
position:relative;
right:600px;
font-size:15px;
font-weight:900;
color:#369;}
</style>
<div id="content">

            <div class="row">
                <div class="col-lg-12">
                     <h1 class="page-header">공지사항 조회페이지</h1>                    
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
                        


  					<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
 						  			<tr>
                                        <th><label> nno</label></th>
                                        <td><input class="form-control" name='nno' value='<c:out value="${notice.nno }"/>' readonly="readonly"></td>
                                    </tr>
                                    <tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title' value='<c:out value="${notice.title }"/>' readonly="readonly"></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="30" class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${notice.content }"/></textarea></td>
                                    </tr>
                                    <tr>
                                        <th><label>Writer</label></th>
                                        <td> <input class="form-control" name='writer' value='<c:out value="${notice.writer }"/>' readonly="readonly"></td>
                                    </tr>

                                    
                                    <tr>
                                        <th colspan="2">
                                        <div class="regBtn">
                                     <!-- 로그인이 되어있고 본인 id인 경우에만 수정할 수 있도록 버튼을 출력 -->
                                    <c:if test = "${loginResult.id == notice.writer}">
                                        <button data-oper='modify' class="btn btn-default" onclick="location.href='/notice/modify?nno=<c:out value="${notice.nno }"/>'">수정하기</button>
                                    </c:if>
                        				<button data-oper='list' class="btn btn-info" onclick="location.href='/notice/list'">글목록</button>
                        				
                        				
                        				
                        				
                        				

 										</div>
 										</th>
                                    </tr>
                           </thead>
                     </table>   	
                        	
                        	
                        	
                        	
                        	<!-- list버튼 클릭 시  페이지 번호 유지하며 다시 목록페이지로 이동. -->
                        	<!-- 버튼을 클릭하면 <form>태그를 이용하는 방식
                        		필요한 데이터들을 추가해서 이동하도록 설정 -->
                        	<!-- cri라는 이름으로 전달된 Criteria 객체를 이용해서 pageNum과 amount값을 태그로 구성하고 
                        	버튼을 클릭했을 때 정상적으로 목록페이지로 이동하게 처리한다. -->
                        	<form id='operForm' action="/notice/modify" method="get">
                        		<input type='hidden' id='nno' name='nno' value='<c:out value="${notice.nno }"/>'>
                        		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        	</form><!-- 브라우저에서는 form태그의 내용은 보이지 않고 버튼만 보이게 된다 -->
              </div>
		   <!-- end panel-body -->
		  </div>
		  <!-- end panel-body -->
		 </div>
		 <!-- end panel -->
		</div>
		<!-- /.row -->
                        	


            

</div>
                        	        


            
<!-- p.265 -->
 <script type="text/javascript">
 	$(document).ready(function(){
 		var operForm = $("#operForm");
 		$("button[data-oper='modify']").on("click",function(e){
 			operForm.attr("action","/notice/NoticeModify").submit();
 		});
 		
 		$("button[data-oper='list']").on("click", function(e){
 			operForm.find("#nno").remove();
 			operForm.attr("action","/notice/NoticeList")
 			operForm.submit();
 		});
 	});
 </script>
 


 <%@include file="../includes/footer.jsp" %>
