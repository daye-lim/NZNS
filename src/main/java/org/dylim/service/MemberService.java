package org.dylim.service;

import org.dylim.domain.memberVO;
import org.dylim.domain.member_bVO;
import org.dylim.domain.member_iVO;

public interface MemberService {
	
	// ����ȸ�� ȸ������
	public void m_register(member_iVO member) throws Exception;
	
	// ���̵� �ߺ� �˻�
	public int idCheck(String id) throws Exception;
	
	/* �α��� */
	public memberVO Login(memberVO Allmember) throws Exception;
    
    /* �����Ͻ�ȸ�� ȸ������ */
    public void b_register(member_bVO b_member) throws Exception;

    /* ����ȸ������ ��ȸ */
    public member_iVO readMember(String id, String password) throws Exception;

    /* ����ȸ������ ���� */
    public void updateMember(member_iVO member) throws Exception;
    
    /* ����Ͻ�ȸ������ ��ȸ */
    public member_bVO readAgent(String id, String password) throws Exception;
    
    /* ����Ͻ�ȸ������ ���� */
    public void updateAgent(member_bVO b_member) throws Exception;
    
    /* ����ȸ�� Ż�� */
    public void deleteMember(String id) throws Exception;
    
    /* ����Ͻ�ȸ�� Ż�� */
    public void deleteAgent(String id) throws Exception;

}