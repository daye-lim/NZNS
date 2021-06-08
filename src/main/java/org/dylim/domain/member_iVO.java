package org.dylim.domain;

import lombok.Data;

@Data
public class member_iVO {
	private String id;			// 개인회원 id
	private String password;	// 개인회원 pw
	private String name;		// 개인회원 이름
	private String birth;		// 개인회원 생년월일
	private String email;		// 개인회원 이메일
	private String phone;		// 개인회원 휴대폰번호
	private int adminCk;		// 관리자체크 (0: 일반회원, 1:관리자)
}
