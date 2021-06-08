
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/member_js.js"></script>
<%@include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/member.css">


<form method="post" name="memberForm" id="memberForm" onsubmit="return check()">
	<div id="content">
	
	<span id="ca">Create Account</span>
		
				
				<table class="mtable">
					<tr>
						<th scope="row"><label for="id">아이디</label>
							</th>
						<td><input type="text" id="id" name="id" >
						<span class="lb" id="id_input_lb">  아이디가 이미 존재합니다</span>
						<br><label id="id_lb" class="lb"></label>
						</td></tr>
					<tr>
						<th scope="row"><label for="password">비밀번호</label>
							</th>
						<td><input type="password" id="password" name="password">
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
						<td><input type="text" id="name" name="name">
							<label id="name_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="birth">생년월일</label>
							</th>
						<td><input type="date" id="birth" name="birth">
							<label id="birth_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="email">이메일</label>
							</th>
						<td><input type="email" id="email" name="email">
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
						<td><input type="text" id="phone" name="phone"> 
							<br><label id="phone_lb" class="lb"></label>
							</td></tr>

	
					<tr>
						<th colspan="2"><input type="submit" value="가입하기" class="joinbtn"></th></tr>
				</table>
			</div>

</form>


<script type="text/javascript">

var code = "";                //이메일전송 인증번호 저장위한 코드




$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(){
	
        
	//	$("#myform").attr("action", "/member/mregister");
	//	$("#myform").submit();
	});
});	
	//아이디 중복검사
	$("#id").on("propertychange change keyup paste input", function(){

	//console.log("keyup 테스트");
	var id = $("#id").val();			// input id="id" 에 입력되는 값
	var data = {id : id}				// '컨트롤에 넘길 데이터 이름' : '데이터(#id에 입력되는 값)'

	$.ajax({
		type : "post",
		url : "/member/memberIdChk",
		data : data,
		success : function(result){
	 console.log("성공 여부" + result);
	

			if(result != 'fail'){
		//		$('#id_input_lb1').css("display", "inline-block");	
				$('#id_input_lb').css("display", "none");
				idCheck = true;
				
			} else {
		//		$('#id_input_lb1').css("display","none");
				$('#id_lb').html(" ");
				$('#id_input_lb').css("display","inline-block");
				idCheck = false;
			}
		}// success 종료
	}); // ajax 종료	

});// function 종료


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