/**

*

*/

 

window.onload=function(){

 

 

// onsubmit

var form=document.querySelector("#agentForm");

 

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

 

//상호명확인

 

var name=document.querySelector("#name");

if (name.value==false){return false;}

var namechk = /^[A-Za-z가-힣]{2,30}$/;

if(namechk.test(name.value)==false){return false;}

else {return true;}

 

//대표명확인

 

var owner_name=document.querySelector("#owner_name");

if (owner_name.value==false){return false;}

var namechk = /^[A-Za-z가-힣]{2,30}$/;

if(namechk.test(owner_name.value)==false){return false;}

else {return true;}

 

//사업자등록번호 확인

 

var cor_num=document.querySelector("#cor_num");

if (cor_num.value==false){return false;}

var cor_num_chk = /^[0-9]*$/;

if (cor_num_chk.test(tel.value)){return false;}

else if (cor_num.value.length!=13){return false;}

else if (cor_num.value.length>9){return true;}

 

//대표번호 확인

 

var tel=document.querySelector("#tel");

if (tel.value==false){return false;}

var telchk = /^[0-9]*$/;

if (telchk.test(tel.value)){return false;}

else if (tel.value.length!=11){return false;}

else if (tel.value.length==11){return true;}

 

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

 

updatebtn.onclick=function(){if(pw.value.length==0){alert("비밀번호를 입력해주세요");}}

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

 

 

 

// 대표명확인

var owner_name=document.querySelector("#owner_name");

 

owner_name.onblur=function(){if (name.value==false){owner_name_lb.innerHTML="필수 정보입니다".fontcolor("red");}}

owner_name.onkeyup=function(){

var namechk = /^[가-힣]{2,6}$/;

if(namechk.test(owner_name.value)==false){owner_name_lb.innerHTML="이름을 입력해주세요".fontcolor("red");}

else {owner_name_lb.innerHTML=" "}

}

 

// 사업자등록번호확인

var cor_num=document.querySelector("#cor_num");

var cor_num_chk = /^[0-9]*$/;

cor_num.onblur=function(){if (cor_num.value==false){cor_num_lb.innerHTML="필수 정보입니다".fontcolor("red");}}

cor_num.onkeyup=function(){

if (!cor_num_chk.test(cor_num.value)){cor_num_lb.innerHTML="숫자만 입력해주세요.".fontcolor("red");}

else if (cor_num.value.length!=10){cor_num_lb.innerHTML="올바른 정보를 입력해주세요".fontcolor("red");}

else if (cor_num.value.length==10){cor_num_lb.innerHTML="";}}

 

 

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

var tel=document.querySelector("#tel");

 

tel.onblur=function(){if (tel.value==false){tel_lb.innerHTML="필수 정보입니다".fontcolor("red");}}

tel.onkeyup=function(){

if (!cor_num_chk.test(tel.value)){tel_lb.innerHTML="숫자만 입력해주세요.".fontcolor("red");}

else if (tel.value.length!=11){tel_lb.innerHTML="11자리 숫자를 입력해주세요".fontcolor("red");}

else if (tel.value.length>=10){tel_lb.innerHTML="";}}

 

 

 

}

 

 


