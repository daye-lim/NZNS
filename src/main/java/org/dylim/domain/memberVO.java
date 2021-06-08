package org.dylim.domain;

import lombok.Data;

@Data
public class memberVO {
	private String phone;		// 개인회원 휴대폰번호
	private String id;			// 비즈니스회원 id
	private String password;	// 비즈니스회원 pw
	private String name;		// 상호
	private String owner_name;	// 대표명
	private String cor_num;		// 사업자등록번호
	private String email;		// 비즈니스회원 이메일
	private String postcode;	// 우편번호
	private String address1;	// 사무실 주소
	private String address2;	// 사무실 주소
	private String tel;			// 비즈니스회원 휴대폰번호
	private boolean files;		// 증빙서류 첨부 유무
	private int adminCk;		// 관리자체크 (0: 일반회원, 1:관리자)
	private String birth;
}
