package org.dylim.mapper;

import org.dylim.domain.memberVO;
import org.dylim.domain.member_iVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper membermapper;			//MemberMapper.java �������̽� ������ ����
	
	/*ȸ������ ���� �׽�Ʈ �޼���
	@Test
	public void testmregister() throws Exception{
		member_iVO member = new member_iVO();
		
		member.setId("test");				//ȸ�� id
		member.setPassword("test");			//ȸ�� ��й�ȣ
		member.setName("test");				//ȸ�� �̸�
		member.setGender(0);				//ȸ�� ����
		member.setEmail("test");			//ȸ�� ����
		member.setPhone("010-0000-0000");	//ȸ�� ����ȣ
		member.setAdminCk(0);				//������üũ
		
		membermapper.mregister(member);			//���� �޼��� ����
		log.info(member); 
	}*/
	
	
	// ���̵� �ߺ��˻�
	@Test
	public void memberIdChk() throws Exception{
		String id = "admin";	// �����ϴ� ���̵�
		String id2 = "test123";	// �������� �ʴ� ���̵�
		membermapper.idCheck(id);
		membermapper.idCheck(id2);
	}
	
	  /* �α��� ���� mapper �޼��� �׽�Ʈ */
    @Test
    public void Login() throws Exception{
        
    	memberVO Allmember = new memberVO();    // MemberVO ���� ���� �� �ʱ�ȭ
        
        /* �ùٸ� ���̵� ��� �Է°�� */
      //  member.setId("admin");
     //   member.setPassword("admin");
        
        /* �ùٸ� ���� ���̵� ��� �Է°�� */
    	Allmember.setId("test1123");
    	Allmember.setPassword("test1321321");
        
        membermapper.Login(Allmember);
        System.out.println("��� �� : " + membermapper.Login(Allmember));
        
    }
	
}