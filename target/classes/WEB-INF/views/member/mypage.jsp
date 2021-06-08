<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script>

</script>
<%@include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/login.css">
<style>
.btn_wrap{
position:relative;
top:10px;
left:350px;
}

.btn{
position:relative;
right:80px;}

/* #ca{ */
/* position:relative; */
/* right:40px; */
/* } */
</style>

<div class="content">
	
		<div class="logo">
		<a href="/main/mainpage"><img src="/resources/img/logo.png" id="login_logo"></a>
		</div>
	<div class="wrap">
		<h2>회원정보 조회를 위해 아이디와 비밀번호를 다시 한번 입력해주세요</h2>
  <form id="login_form">
		<div class="login_wrap"> 
		<span>아이디</span>
		</div>
		

			<div class="inputbox">
					<input type="text" class="id_input" name="id" id="id">
			</div>
			
			
		<div class="login_wrap">
		<span>비밀번호	</span>
		</div>
		
			<div class="inputbox">
				<input type="password" class="pw_iput" name="password" id="password">
			</div>
			
			
			<!-- true(1)일때 태그안의 데이터 출력 -->
            <c:if test = "${result == 0 }">              
     <script>
		alert(' 사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.');
	</script>
            </c:if>

		<div class="btn_wrap">
			<input type="submit" class="btn" id="member_detail_i" value="개인회원정보조회">
			<input type="submit" class="btn" id="member_detail_b" value="비즈니스회원정보조회">
		</div>	
		
	 </form>	
	</div>				
</div>


 
<script type="text/javascript">


$(document).ready(function(){


	$("#member_detail_i").on("click",function(){  
	
		$("form").attr("action","/member/member_detail_i")
		$("form").attr("method","post")		
	})
	
	$("#member_detail_b").on("click",function(){
		$("form").attr("action","/member/member_detail_b")
		$("form").attr("method","post")		
	})
})
</script>
 <script>
 </script>


<%@include file="../includes/footer.jsp" %>