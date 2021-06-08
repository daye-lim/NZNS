<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<%@include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/login.css">


<div class="content">
	

	<div class="wrap">
  <form id="login_form" method="post">
		<div class="login_wrap"> 
		<span>아이디</span>
		</div>
		

			<div class="inputbox">
					<input type="text" class="id_input" name="id">
			</div>
			
			
		<div class="login_wrap">
		<span>비밀번호	</span>
		</div>
		
			<div class="inputbox">
				<input type="password" class="pw_iput" name="password">
			</div>
			
			
		<div class="login_btn_wrap">
			<input type="button" class="login_btn" value="로그인">
		</div>
			
            <c:if test = "${result == 0 }">              
     <script>
		alert(' 사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.');
	</script>
            </c:if>


		

		<div class="btn_wrap">
			<a href="/member/m_register"><input type="button" class="btn" value="개인회원가입"></a>
			<a href="/member/b_register"><input type="button" class="btn" value="비즈니스회원가입"></a>
			<input type="button" class="btn" value="아이디/비밀번호 찾기">
		</div>	
	 </form>	
	</div>				
</div>


 
<script type="text/javascript">
 
    /* 로그인 버튼 클릭 메서드 */
    $(".login_btn").click(function(){
        
      //  alert("로그인 버튼 작동");
        
        /* 로그인 메서드 서버 요청 */
        $("#login_form").attr("action", "/member/loginpage");
        $("#login_form").submit();
        
    });
 
</script>
 

<%@include file="../includes/footer.jsp" %>