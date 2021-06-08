<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/includes.css">

    
    
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="title"><a href="/main/mainpage"><img src="/resources/img/logo.png" id="main_logo"></a>
<p>내 집은 내가 산다 ! 현명한 내집마련을 위한 정보공유 웹사이트</p></div>
<div class="menu">
	<ul class="nav">
		<li><a href="/notice/NoticeList">공지사항</a></li>
		<li><a href="/board/list">자유게시판</a></li>
		<li><a href="">Q&A</a></li>
		<li><a href="">전문가상담</a></li>
		<li><a href="">후기게시판</a></li>
	</ul>
</div>

<!-- 로그인 하지 않은 상태 -->
<c:if test = "${loginResult == null }">
<div class="login">
	<ul>
	 <li><a href="/member/loginpage">회원가입</a></li>
     <li><a href="/member/loginpage">로그인</a></li>
	</ul>
</div>
</c:if>

<!-- 로그인한 상태 -->
<c:if test="${loginResult != null }">
<div class="login_s">
	<ul>
	 <li><img src="/resources/img/member_Icon.png" id="member_Icon">${loginResult.name} 님 <br>반갑습니다.</li>
     <li><br><a href="/member/mypage">내정보</a></li>
     <li><a href="/member/logout">로그아웃</a></li>
	</ul>
</div>
</c:if> 


<!-- 여기까지 header.jsp -->

