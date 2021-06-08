package org.dylim.mapper;

import org.apache.ibatis.annotations.Param;
import org.dylim.domain.memberVO;
import org.dylim.domain.member_bVO;
import org.dylim.domain.member_iVO;

public interface MemberMapper {

	
	/* ���̵� �ߺ� �˻� */
	public int idCheck(String id);

	/* �α��� */
    public memberVO Login(memberVO Allmember);
	
	/* ����ȸ�� ȸ������ */
	public void m_register(member_iVO member);
	
    /* ����ȸ������ ��ȸ */
    public member_iVO readMember(@Param("id")String id,@Param("password")String password);
  	
    /* ����ȸ������ ���� */
  	public void updateMember(member_iVO member) throws Exception;
  	
  	/* ����ȸ�� Ż�� */
  	public void deleteMember(String id) throws Exception;
    
    /* �����Ͻ�ȸ�� ȸ������ */
    public void b_register(member_bVO b_member);
    
    /* ����Ͻ�ȸ������ ��ȸ */
    public member_bVO readAgent(@Param("id")String id,@Param("password")String password);
    
    /* ����Ͻ�ȸ������ ���� */
  	public void updateAgent(member_bVO b_member) throws Exception;
  	
  	/* �����Ͻ�ȸ�� Ż�� */
  	public void deleteAgent(String id) throws Exception;

}
