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
	private MemberMapper membermapper;			//MemberMapper.java 인터페이스 의존성 주입
	
	/*회원가입 쿼리 테스트 메서드
	@Test
	public void testmregister() throws Exception{
		member_iVO member = new member_iVO();
		
		member.setId("test");				//회원 id
		member.setPassword("test");			//회원 비밀번호
		member.setName("test");				//회원 이름
		member.setGender(0);				//회원 성별
		member.setEmail("test");			//회원 메일
		member.setPhone("010-0000-0000");	//회원 폰번호
		member.setAdminCk(0);				//관리자체크
		
		membermapper.mregister(member);			//쿼리 메서드 실행
		log.info(member); 
	}*/
	
	
	// 아이디 중복검사
	@Test
	public void memberIdChk() throws Exception{
		String id = "admin";	// 존재하는 아이디
		String id2 = "test123";	// 존재하지 않는 아이디
		membermapper.idCheck(id);
		membermapper.idCheck(id2);
	}
	
	  /* 로그인 쿼리 mapper 메서드 테스트 */
    @Test
    public void Login() throws Exception{
        
    	memberVO Allmember = new memberVO();    // MemberVO 변수 선언 및 초기화
        
        /* 올바른 아이디 비번 입력경우 */
      //  member.setId("admin");
     //   member.setPassword("admin");
        
        /* 올바른 않은 아이디 비번 입력경우 */
    	Allmember.setId("test1123");
    	Allmember.setPassword("test1321321");
        
        membermapper.Login(Allmember);
        System.out.println("결과 값 : " + membermapper.Login(Allmember));
        
    }
	
}