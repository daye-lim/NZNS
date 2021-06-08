package org.dylim.service;

import org.dylim.domain.memberVO;
import org.dylim.domain.member_bVO;
import org.dylim.domain.member_iVO;

public interface MemberService {
	
	// 개인회원 회원가입
	public void m_register(member_iVO member) throws Exception;
	
	// 아이디 중복 검사
	public int idCheck(String id) throws Exception;
	
	/* 로그인 */
	public memberVO Login(memberVO Allmember) throws Exception;
    
    /* 비지니스회원 회원가입 */
    public void b_register(member_bVO b_member) throws Exception;

    /* 개인회원정보 조회 */
    public member_iVO readMember(String id, String password) throws Exception;

    /* 개인회원정보 수정 */
    public void updateMember(member_iVO member) throws Exception;
    
    /* 비즈니스회원정보 조회 */
    public member_bVO readAgent(String id, String password) throws Exception;
    
    /* 비즈니스회원정보 수정 */
    public void updateAgent(member_bVO b_member) throws Exception;
    
    /* 개인회원 탈퇴 */
    public void deleteMember(String id) throws Exception;
    
    /* 비즈니스회원 탈퇴 */
    public void deleteAgent(String id) throws Exception;

}