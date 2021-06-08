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

}

h2{
text-align:center;
padding-top:100px;
}

.btn{
position:relative;
top:200px;
left:130px;
margin-top:100px;}

#login_logo{
	position:relative;
	left:450px;
	padding-bottom:50px;
	width:300px;
	height:150px;
}
</style>

<div class="content">
	
		<div class="logo">
			<a href="/main/mainpage"><img src="/resources/img/logo.png" id="login_logo"></a>
		</div>
	<div class="wrap">
		<h2>회원정보 수정이 완료되었습니다.</h2>

		<div class="btn_wrap">
			<a href="/main/mainpage"><input type="button" class="btn" id="goMain" value="홈으로"></a>
			<a href="/member/mypage"><input type="button" class="btn" id="goMypage" value="내정보"></a>
		</div>	

	</div>				
</div>



<%@include file="../includes/footer.jsp" %>