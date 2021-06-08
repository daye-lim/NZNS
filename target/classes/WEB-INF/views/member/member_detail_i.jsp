
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/member_js_detail.js"></script>
<%@include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/member.css">


<form method="post" name="memberForm" id="memberForm" onsubmit="return check()">
	<div id="content">
	
	<span id="ca">Create Account</span>
		
				
				<table class="mtable">
					<tr>
						<th scope="row"><label for="id">아이디</label>
							</th>
						<td><input type="text" id="id" name="id" readonly value="${member.id}">
						<br><label id="id_lb" class="lb"></label>
						</td></tr>
					<tr>
						<th scope="row"><label for="password">비밀번호</label>
							</th>
						<td><input type="password" id="password" name="password">
						<input type="hidden" id="realUserPw" value="${member.password}">
						<br>
						<label id="pw_lb" class="lb"></label>
						</td></tr>
					<tr>
						<th scope="row"><label for="pwc">비밀번호 확인</label>
							</th>
						<td><input type="password" id="pwc">
							<label id="pwc_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="name">이름</label>
							</th>
						<td><input type="text" id="name" name="name" value="${member.name}">
							<label id="name_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="birth">생년월일</label>
							</th>
						<td><input type="date" id="birth" name="birth" value="${member.birth}" readonly>
							<label id="birth_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="email">이메일</label>
							</th>
						<td><input type="email" id="email" name="email" value="${member.email}">
						<button class="btn" id="email_check_btn">인증번호전송</button>
							<br><label id="email_lb" class="lb"></label></td></tr>
							
					<tr>
						<th scope="row"><label for="pincode">인증번호</label>
						</th>
						<td><input type="text" id="pincode" disabled="disabled">
						
							<button class="btn" id="pincode_check_btn">인증번호확인</button>   <br><span id="pincode_warn"></span></td></tr>
							
					<tr>
						<th scope="row"><label for="phone">휴대폰번호</label>
						</th>
						<td><input type="text" id="phone" name="phone" value="${member.phone}"> 
							<br><label id="phone_lb" class="lb"></label>
							</td></tr>

	
<tr>
						<th colspan="2">
						<input type="submit" value="수정" class="joinbtn" id="update">
						<input type="submit" value="탈퇴" class="joinbtn" id="delete"></th></tr>
				</table>
			</div>

</form>


<script type="text/javascript">

$(document).ready(function(){
	$(document).ready(function(){

		$("#update").on("click",function(){
			$("form").attr("action","/member/member_update_i.do")
			$("form").attr("method","post")		
		})
		
 		$("#delete").on("click",function(){
 			$("form").attr("action","/member/member_delete_i.do")
 			$("form").attr("method","post")		
  		})
	})
})
</script>
<script type="text/javascript">
// 	$(document).ready(function() {

// 		$("#delete").on("click",function(event) {
// 			event.preventDefault();
			
// 			var choice = confirm("정말로 탈퇴하시겠습니까?");
// 			/* 컨펌창에서 확인을 누르면 */
// 			if (choice) {
				
// 				var userpw = $("#password").val(); /* input으로 입력받은 비밀번호 값 */
// 				var realUserPw = $("#realUserPw").val(); /* DB에서 넘겨받은 비밀번호 값 */ 		
				
// 				if (userpw == '') {
// 					/* 1. 비밀번호 입력란이 공란일 때 alert을 띄운 뒤 비밀번호 입력란에 focus */
// 					alert("비밀번호를 입력해주세요.");
// 					$("#password").focus();
				
// 				} 
// 				else {
// 						/* 3. 비밀번호, 체크박스 모두 입력되어있는데, DB에 저장된 비밀번호와 다른 경우 */
// 						if (userpw != realUserPw) {
// 							/* alert창을 띄워 비밀번호를 확인하게 한 뒤, 비밀번호 입력란에 focus */
// 							alert("잘못된 비밀번호입니다.");
// 							$("#password").focus();
// 						} else {
// 							/* 세가지 경우 모두에 해당하지 않는 경우 : 옳은 비밀번호 + 체크박스 체크 */
// 							$("form").submit();
// 						 	/* from 태그를 제출한다 */
// 						}

// 					}

// 			} else { /* confirm에서 취소를 선택한 경우 : 마이페이지로 돌아간다 */

// 				location.assign("/member/mypage");
// 			}
// 		});

// 	});
</script>

<script type="text/javascript">

var code = "";                //이메일전송 인증번호 저장위한 코드







/* 인증번호 버튼 기본이벤트 제거 */
$(".btn").on('click', function(e){

	e.preventDefault();

	e.stopPropagation();

	});



/* 인증번호 이메일 전송 */
$("#email_check_btn").click(function(){
	 var email = $("#email").val();       // 입력한 이메일
	 var cehckBox = $("#pincode");        // 인증번호 입력란
	 $.ajax({
	        
	        type:"GET",
	        url:"emailCheck?email=" + email,
	        success:function(data){
	        	 console.log("data : " + data);
	        	 cehckBox.attr("disabled",false);
	        	 code = data;
	        }
	    });
});



/* 인증번호 비교 */
$("#pincode_check_btn").click(function(){
	  var inputCode = $("#pincode").val();        // 입력코드    
	  var checkResult = $("#pincode_warn");   	 // 비교 결과   
	  
	   if(inputCode == code){                            // 일치할 경우
	        checkResult.html("인증번호가 일치합니다.");
	        checkResult.attr("class", "correct");        
	    } else {                                            // 일치하지 않을 경우
	        checkResult.html("인증번호를 다시 확인해주세요.");
	        checkResult.attr("class", "incorrect");
	    }    
	    
});


</script>
<%@include file="../includes/footer.jsp" %>