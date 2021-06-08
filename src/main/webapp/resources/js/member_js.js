
window.onload=function(){
	
	
	// onsubmit
	var form=document.querySelector("#memberForm");
	var id=document.querySelector("#id");
	var idchk=/^[a-z0-9]{4,18}$/;
	var pw=document.querySelector("#password");
	var pwchk=/^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{10,18}$/;
	var pwc=document.querySelector("#pwc");
	var name=document.querySelector("#name");
	var namechk = /^[A-Za-z가-힣]{2,30}$/;
	var birth=document.querySelector("#birth");
	var phonenumber=document.querySelector("#phone");
	var pnchk = /^[0-9]*$/;
	var email=document.querySelector("#email");
	var emailchk= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;	
	
form.onsubmit=function check(){
		//id
		if (idchk.test(id.value) && (id.value != 0)){return true;}
		else {return false;}
}
		
form.onsubmit=function check(){
		//pw
		if (pwchk.test(pw.value) && (pw.value != 0)){return true;}
		else {return false;}
}
	
form.onsubmit=function check(){
		//pw확인
		if(pwc.value.length==0){return false;}
		else if (pwc.value==pw.value){return true;}
		else {return false;}
}
	
form.onsubmit=function check(){
	//이름 확인
	if (name.value==false){return false;}
	if(namechk.test(name.value)==false){return false;}
	else {return true;}
}

form.onsubmit=function check(){
	//birth 확인
	if (birth.value==false){return false;}
	else {return true;}
}

		
		
form.onsubmit=function check(){
	//휴대폰번호 확인
	if (phonenumber.value==false){return false;}
	if (pnchk.test(phonenumber.value)){return false;}
	else if (phonenumber.value.length!=11){return false;}
	else if (phonenumber.value.length==11){return true;}
}	
		
		
form.onsubmit=function check(){
	//이메일 확인
	if (emailchk.test(email.value)){return true;}
	else {return false;}
}
	
	
	
	
	
	
		
		//id유효성검사
		var id=document.querySelector("#id");
		var id_lb=document.querySelector("#id_lb");
		var id_span=document.querySelector("#id_input_lb2");
		
		id.onblur=function(){
			if(id.value.length==0){
				id_lb.innerHTML="필수정보입니다.".fontcolor("red");}
			}
		id.onkeyup=function(){
			var idchk=/^[a-z0-9]{4,18}$/;
			if (idchk.test(id.value)){
				id_lb.innerHTML="사용가능한 아이디입니다".fontcolor("blue");}
			else{id_lb.innerHTML="영문 소문자/숫자를 포함하여 4~18자를 입력해주세요".fontcolor("red");
				}
		}
	
	
	//pw유효성검사
	var pw=document.querySelector("#password");
	var pw_lb=document.querySelector("#pw_lb");
	pw.onblur=function(){if(pw.value.length==0){pw_lb.innerHTML="필수 정보입니다".fontcolor("red");}}
	pw.onkeyup=function(){
//		(?=.*?[A-Z])
		var pwchk=/^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{10,18}$/;
		if (pwchk.test(pw.value)){
			pw_lb.innerHTML="사용가능한 비밀번호입니다".fontcolor("blue");}
		else{pw_lb.innerHTML="영문 소문자/숫자/특수문자 중 2가지 이상을 포함하여 10자~18자를 입력해주세요"
			.fontcolor("red");}

	}
	
	//pw확인
	pwc.onkeyup=function(){
		if(pwc.value.length==0){pwc_lb.innerHTML="필수 정보입니다".fontcolor("red");}
		else if (pwc.value==pw.value){pwc_lb.innerHTML="비밀번호가 일치합니다".fontcolor("blue");}
		else {pwc_lb.innerHTML="비밀번호가 일치하지 않습니다".fontcolor("red");}
	}
	
	//이름확인
	var name=document.querySelector("#name");
	
	name.onblur=function(){if (name.value==false){name_lb.innerHTML="필수 정보입니다".fontcolor("red");}}
	name.onkeyup=function(){
		var namechk = /^[가-힣]{2,6}$/;		
		if(namechk.test(name.value)==false){name_lb.innerHTML="이름을 입력해주세요".fontcolor("red");}
		else {name_lb.innerHTML=" "}
	}
	

	
	//휴대폰번호 확인
	var phonenumber=document.querySelector("#phone");
	
	phonenumber.onblur=function(){if (phonenumber.value==false){phone_lb.innerHTML="필수 정보입니다".fontcolor("red");}}
	phonenumber.onkeyup=function(){
		var pnchk = /^[0-9]*$/;
		if (!pnchk.test(phonenumber.value)){phone_lb.innerHTML="숫자만 입력해주세요.".fontcolor("red");}
		else if (phonenumber.value.length!=11){phone_lb.innerHTML="11자리 숫자를 입력해주세요".fontcolor("red");}
		else if (phonenumber.value.length==11){phone_lb.innerHTML="";}}

	
	//이메일 확인
	var email=document.querySelector("#email");
	var email_lb=document.querySelector("#email_lb");
	
	email.onblur=function(){if (email.value==false){email_lb.innerHTML="필수 정보입니다".fontcolor("red");}}
	email.onkeyup=function(){
		var emailchk= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		if (emailchk.test(email.value)){
			email_lb.innerHTML="";}
		else {email_lb.innerHTML="유효한 이메일 주소를 입력해주세요.".fontcolor("red");}
	}
	

}

