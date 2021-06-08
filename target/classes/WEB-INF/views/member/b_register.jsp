
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/business_js.js"></script>
<%@include file="../includes/header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address2").value = extraAddr;
                
                } else {
                    document.getElementById("address2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
            }
        }).open();
    }
</script>
<link rel="stylesheet" href="/resources/css/member.css">


<form method="post" name="agentForm" id="agentForm" onsubmit="return check()">
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
						<th scope="row"><label for="name">상호명</label>
							</th>
						<td><input type="text" id="name" name="name">
							<label id="name_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="owner_name">대표명</label>
							</th>
						<td><input type="text" id="owner_name" name="owner_name">
							<label id="owner_name_lb" class="lb"></label>
							</td></tr>
					<tr>
						<th scope="row"><label for="cor_num">사업자등록번호</label>
							</th>
						<td><input type="text" id="cor_num" name="cor_num">
							<label id="cor_num_lb" class="lb"></label>
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
						<th><label for="address2">주소</label></th>
						<td><input type="text" class="address" id="postcode" name="postcode">  <input type="button"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					    	<input type="text" class="address" id="address1" name="address1">
						    <input type="text" class="address" id="address2" name="address2" placeholder="상세주소를 입력해주세요">
						</td></tr>	

					<tr>
						<th scope="row"><label for="tel">대표번호</label>
						</th>
						<td><input type="text" id="tel" name="tel"> 
							<br><label id="tel_lb" class="lb"></label>
							</td></tr>

			<!-- 		<tr>
						<th scope="row"><label for="files">증빙서류첨부</label>
						</th>
						<td><input type="file" name='files' multiple>
							<br><label id="file_lb" class="lb"></label>
							</td></tr>
	 -->
					<tr>
						<th colspan="2"><input type="submit" value="가입하기" class="joinbtn"></th>
					</tr>
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
	// console.log("성공 여부" + result);
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