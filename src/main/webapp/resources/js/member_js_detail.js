/**

*

*/

 

window.onload=function(){

 

 

// onsubmit

var form=document.querySelector("#memberForm");

 

form.onsubmit=function check(){

 

//pw

 

var pw=document.querySelector("#password");

var pwchk=/^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{10,18}$/;

if (pwchk.test(pw.value)){

return true;}

else {return false;}

 

//pw확인

 

var pw=document.querySelector("#password");

var pwc=document.querySelector("#pwc");

if(pwc.value.length==0){return false;}

else if (pwc.value==pw.value){return true;}

else {return false;}

 

//이름확인

 

var name=document.querySelector("#name");

if (name.value==false){return false;}

var namechk = /^[A-Za-z가-힣]{2,30}$/;

if(namechk.test(name.value)==false){return false;}

else {return true;}

 

 

//대표번호 확인

 

var phone=document.querySelector("#phone");

if (phone.value==false){return false;}

var phonechk = /^[0-9]*$/;

if (phonechk.test(tel.value)){return false;}

else if (phone.value.length!=11){return false;}

else if (phone.value.length==11){return true;}

 

//이메일 확인

 

var email=document.querySelector("#email");

var emailchk= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;

if (emailchk.test(email.value)){return true;}

else {return false;}

}

 

 

 

 

 

// pw유효성검사

var pw=document.querySelector("#password");

var pw_lb=document.querySelector("#pw_lb");

var updatebtn = document.querySelector("#update");

var delbtn = document.querySelector("#delete");

var realpw=document.querySelector("#realUserPw");

//var choice = confirm("정말로 탈퇴하시겠습니까?");



updatebtn.onclick=function(){if(pw.value.length==0){alert("비밀번호를 입력해주세요");}}

//delbtn.onclick=function(){if(pw.value!=realpw.value){alert("잘못된 비밀번호입니다.");}}
//
//delbtn.onclick=function(){if(pw.value.length==0){alert("비밀번호를 입력해주세요");}}

//delbtn.onclick=function(){
//	if(choice)
//	{
//		if(pw.value!=realpw.value){alert("잘못된 비밀번호입니다.");} 
//		else if(pw.value.length==0){alert("비밀번호를 입력해주세요");}
//		else{alert("탈퇴가 완료되었습니다.")}
//		
//	}
//	else{location.assign("/member/mypage");}
//	
//}

pw.onblur=function(){if(pw.value.length==0){pw_lb.innerHTML="비밀번호를 입력해주세요".fontcolor("red");}}

pw.onkeyup=function(){

// (?=.*?[A-Z])

var pwchk=/^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{10,18}$/;

if (pwchk.test(pw.value)){

pw_lb.innerHTML="사용가능한 비밀번호입니다".fontcolor("blue");}

else{pw_lb.innerHTML="영문 소문자/숫자/특수문자 중 2가지 이상을 포함하여 10자~18자를 입력해주세요"

.fontcolor("red");}

 

}

 

// pw확인

pwc.onkeyup=function(){

if(pwc.value.length==0){pwc_lb.innerHTML="필수 정보입니다".fontcolor("red");}

else if (pwc.value==pw.value){pwc_lb.innerHTML="비밀번호가 일치합니다".fontcolor("blue");}

else {pwc_lb.innerHTML="비밀번호가 일치하지 않습니다".fontcolor("red");}

}

 

// 상호명확인

var name=document.querySelector("#name");

 

name.onblur=function(){if (name.value==false){name_lb.innerHTML="필수 정보입니다".fontcolor("red");}

else {name_lb.innerHTML=" "}}


 

 

// 이메일확인

var email=document.querySelector("#email");

var email_lb=document.querySelector("#email_lb");

 

email.onblur=function(){if (email.value==false){email_lb.innerHTML="필수 정보입니다".fontcolor("red");}}

email.onkeyup=function(){

var emailchk= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;

if (emailchk.test(email.value)){

email_lb.innerHTML="";}

else {email_lb.innerHTML="유효한 이메일 주소를 입력해주세요.".fontcolor("red");}

}

 

 

// 대표번호확인

var phone=document.querySelector("#phone");

 

phone.onblur=function(){if (phone.value==false){phone_lb.innerHTML="필수 정보입니다".fontcolor("red");}}

phone.onkeyup=function(){

if (!phonechk.test(phone.value)){phone_lb.innerHTML="숫자만 입력해주세요.".fontcolor("red");}

else if (phone.value.length!=11){phone_lb.innerHTML="11자리 숫자를 입력해주세요".fontcolor("red");}

else if (phone.value.length>=10){phone_lb.innerHTML="";}}

 

 

 

}

 

 


