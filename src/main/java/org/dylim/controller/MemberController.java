package org.dylim.controller;

import java.security.Principal;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.dylim.domain.memberVO;
import org.dylim.domain.member_bVO;
import org.dylim.domain.member_iVO;
import org.dylim.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberservice;
	
	@Setter(onMethod_ = @Autowired)
	private JavaMailSender mailSender;
	
//	@Setter(onMethod_ = @Autowired)
//	private BCryptPasswordEncoder pwEncoder;
	
	/*회원가입 페이지 이동*/
	@RequestMapping(value = "m_register", method = RequestMethod.GET)
	public void m_register() {
		
		log.info("개인회원가입 페이지 진입");
		
	}
	

	
	/* 로그인 페이지 이동 */
	@RequestMapping(value = "loginpage", method = RequestMethod.GET)
	public void login() {
		
		log.info("로그인 페이지 진입");
		
	}

	/* 개인회원 회원가입 */
	@RequestMapping(value="/m_register", method=RequestMethod.POST)
	public String m_registerPost(member_iVO member) throws Exception{
			
		log.info("개인회원등록 진입");
			
		
//		String rawPw  = "";        	   // 인코딩 전 비밀번호
//	    String encodePw = "";     		   // 인코딩 후 비밀번호
	    
	    
//	    rawPw = member.getPassword();        // 비밀번호 데이터 얻음
//	    encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
//	    member.setPassword(encodePw);            // 인코딩된 비밀번호 member객체에 다시 저장
	    
	    
	 // 회원가입 서비스(쿼리) 실행
	 memberservice.m_register(member);
	 			
	 log.info("member register Service 성공");
//	 System.out.println("회원가입 raw : "+rawPw);
//     System.out.println("회원가입 enc : "+encodePw);
	 		
		return "redirect:/member/loginpage";
		// 로그인페이지로 이동
			
		}	
	
	/* 아이디 중복 검사 */
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody //해당 코드를 추가해주지 않는다면 mregister.jsp로 메서드의 결과가 반환되지 않음.
	public String memberIdChkPOST(String id) throws Exception{
		
		//log.info("memberIdChk() 진입");

// memberservice.idCheck(id)의 결과를 int형 변수 result에 저장합니다. (존재한다면 '1', 존재하지 않는다면 '0'을 반환하게 됩니다.)
// - result의 결과가 0이 아니면 "fail"을 반환하고, result의 결과가 1이 아니면 "success"을 반환합니다. 
		int result = memberservice.idCheck(id);
		
		log.info("결과값 = " + result);
		
		if(result != 0) {
			
			return "fail";	// 중복 아이디가 존재
			
		} else {
			
			return "success";	// 중복 아이디 x
			
		}	
		
	} // memberIdChkPOST() 종료	
	

	 
    /* 이메일 인증 */
    @RequestMapping(value="/emailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String emailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
    	log.info("이메일 데이터 전송 확인");
    	log.info("인증번호 : " + email);
    	
        /* 인증번호(난수) 생성 111111~999999범위의 숫자 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        log.info("인증번호 : " + checkNum);       
        /* 이메일 보내기 */
        String setFrom = "yeyeyeah_@naver.com";
        String toMail = email;	// 수신받을 이메일주소
        String title = "회원가입 인증 이메일 입니다.";	// 이메일 제목
        String content = 						// 이메일 내용
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

       
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }

        String num = Integer.toString(checkNum);
        
        return num;
    }
    
	/* 로그인 */
	@RequestMapping(value = "/loginpage", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, memberVO Allmember, RedirectAttributes rttr) throws Exception{
	
		System.out.println("login 메서드 진입");
		System.out.println("전달된 데이터 : " + Allmember);
		
		HttpSession session = request.getSession();
		memberVO mvo = memberservice.Login(Allmember); // 제출한아이디와 일치하는 아이디있는지 

		
		/* lvo 값이 null일 경우 로그인 실패이기 때문에 로그인 페이지로 리다이렉트 되도록, 
		 * null이 아닌 경우 로그인 성공이기 때문에 메인 페이지로 리다이렉트 되도록 return 값을 설정
		 * */
		if(mvo == null) {                                // 일치하지 않는 아이디, 비밀번호 입력 경우
            
            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/member/loginpage";
            
        }
		
        
        session.setAttribute("loginResult", mvo);             // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
        
        return "redirect:/main/mainpage";
        
        
    }    



		
		/* 
		 * 비밀번호 인코딩 코드
		 * 		
		 * HttpSession session = request.getSession();
		String rawPw  = "";            // 인코딩 전 비밀번호
	    String encodePw = "";        // 인코딩 후 비밀번호
	    
	    회원의 정보를 반환하는 쿼리문 실행(사용자의 아이디를 조건으로 함)
		=> 회원의 정보가 null인지판단
		
		
   		◇ null 인경우 - 로그인 실패
         => 로그인 실패 실행 코드
   		◆ null 아닌 경우 
         => matchers() 문을 통해 데이터베이스 저장된 비밀번호와 제출된 비밀번호 일치 여부 확인
               □(true) true인 경우 - 비밀번호 일치
                     로그인 성공 실행 코드
               ■(false) false인 경우 - 비밀번호 불일치 
                     로그인 실패 실행 코드
                     
                     

		if(lvo != null) {            // 일치하는 아이디 존재시
			
			rawPw = member.getPassword();        // 사용자가 제출한 비밀번호
	        encodePw = lvo.getPassword();        // 데이터베이스에 저장한 인코딩된 비밀번호
	        System.out.println("raw : "+rawPw);
	        System.out.println("enc : "+encodePw);
	        
	           if(true == pwEncoder.matches(rawPw, encodePw)) {        // 비밀번호 일치여부 판단
	        	 
	        	    lvo.setPassword("");                    // 인코딩된 비밀번호 정보 지움
	                session.setAttribute("member", lvo);     // session에 사용자의 정보 저장
	                
	                return "redirect:/main/mainpage";       // 메인페이지 이동
	                
               } else {
            	   
            	   rttr.addFlashAttribute("result", 0);		// 0 = 거짓, 1 = 참
                   return "redirect:/member/loginpage";
                   
               }
		} else {                                // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
         
			rttr.addFlashAttribute("result", 0);		// 0 = 거짓, 1 = 참
            return "redirect:/member/loginpage";
            
        }


	}*/
	
	
	
	  /* 메인페이지 로그아웃 -> 세션 제거하는 작업 */
  @RequestMapping(value="/logout", method=RequestMethod.GET)
  public String logoutMainGET(HttpServletRequest request) throws Exception{
  	   
      log.info("logoutMainGET메서드 진입");
      
      HttpSession session = request.getSession();	// 세션변수 초기화
      
      session.invalidate();
      
      return "redirect:/main/mainpage";    
  }
	
	/*비즈니스회원가입 페이지 이동*/
	@RequestMapping(value = "b_register", method = RequestMethod.GET)
	public void b_register() {
		
		log.info("비즈니스회원가입 페이지 진입");
		
	}
	
	/* 비즈니스회원 회원가입 */
	@RequestMapping(value="/b_register", method=RequestMethod.POST)
	public String b_registerPost(member_bVO b_member) throws Exception{
			
		log.info("비즈니스회원등록 진입");
			
	 // 회원가입 서비스(쿼리) 실행
	 memberservice.b_register(b_member);
	 			
	 log.info("b_member register Service 성공");
	 		
		return "redirect:/member/loginpage";
		// 로그인페이지로 이동
			
		} 
	
	
	
	/*마이 페이지 이동*/
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public void mypage() {	}
	

	/* 개인회원정보 조회 */
	@RequestMapping(value = "/member_detail_i", method = RequestMethod.POST)
	public String ReadMemberGET(HttpServletRequest request,member_iVO member, Model model,  RedirectAttributes rttr) throws Exception{

		//세션 객체 안에 있는 ID정보 저장
		String id = (String) member.getId();
		String password = (String) member.getPassword();
		
		//서비스안의 회원정보보기 메서드 호출후 결과를 ivo에 담음
		member_iVO ivo = memberservice.readMember(id,password);
		
		log.info("ivo = "+ivo);
		
		if(ivo == null) {
			//select 결과가 null이면, (id,pw불일치 시)
				int result = 0;
	            rttr.addFlashAttribute("result", result);
	            return "redirect:/member/mypage";
		}
		

		//member_iVO의 정보를 session (member)에 저장
//		session.setAttribute("Allmember",ivo);
		//정보저장 후 페이지 이동
		model.addAttribute("member", ivo);

		return "member/member_detail_i";

	}	
	
	/* 개인회원정보 수정 */

	@PostMapping(value = "/member_update_i.do")
	public String MemberUpdatePOST(member_iVO member, Model model ) throws Exception {
		memberservice.updateMember(member);
		return  "/member/member_update_i";
	}
	
	/* 개인회원 탈퇴 */
	@PostMapping(value = "/member_delete_i.do")
	public String deleteMemberPOST(String id, HttpServletRequest request) throws Exception { 
		log.info("delete메소드 실행..................."+id);
		memberservice.deleteMember(id);
	
		return "redirect:/member/member_delete_i";	
	}
	
	  @RequestMapping(value="/member_delete_i", method=RequestMethod.GET)
	  public String logoutMainGET2(HttpServletRequest request) throws Exception{
	  	   
	      log.info("logoutMainGET메서드 진입");
	      
	      HttpSession session = request.getSession();	// 세션변수 초기화
	      
	      session.invalidate();
	      
	      return "redirect:/main/mainpage";    
	  }
	
	
	/* 비즈니스회원정보 조회 */
	@RequestMapping(value = "/member_detail_b", method = RequestMethod.POST)
	public String ReadAgentGET(HttpServletRequest request,member_bVO b_member, Model model, RedirectAttributes rttr) throws Exception{

		//세션 객체 안에 있는 ID,PW정보 저장
		String id = (String) b_member.getId();
		String password = (String) b_member.getPassword();
		log.info(" 비즈니스회원정보 GET의 아이디 "+id);

		//서비스안의 회원정보보기 메서드 호출후 결과를 bvo에 담음
		member_bVO bvo = memberservice.readAgent(id,password);
		
		//member_bVO의 정보를 session (b_member)에 저장

		if(bvo == null) {
			//select 결과가 null이면, (id,pw불일치 시)
				int result = 0;
	            rttr.addFlashAttribute("result", result);
	            return "redirect:/member/mypage";
		}
		

		//정보저장 후 페이지 이동
		model.addAttribute("b_member", bvo);
		log.info(" 비즈니스회원정보 GET의 VO "+ bvo);
		
		return "member/member_detail_b";
	}
	
	
	/* 비즈니스회원정보 수정 */

	@PostMapping(value = "/member_update_b.do")
	public String AgentUpdatePOST(member_bVO b_member, Model model ) throws Exception {
		memberservice.updateAgent(b_member);
		log.info("AgentUpdateGET b_member = " + b_member);
		return  "/member/member_update_b";
	}

	/* 비즈니스회원 탈퇴*/
	@PostMapping(value = "/member_delete_b.do")
	public String deleteAgentPOST(String id, HttpServletRequest request) throws Exception { 
		log.info("delete메소드 실행..................."+id);
		memberservice.deleteAgent(id);
	
		return "redirect:/member/member_delete_b";	
	}
	
	  @RequestMapping(value="/member_delete_b", method=RequestMethod.GET)
	  public String logoutMainGET3(HttpServletRequest request) throws Exception{
	  	   
	      log.info("logoutMainGET메서드 진입");
	      
	      HttpSession session = request.getSession();	// 세션변수 초기화
	      
	      session.invalidate();
	      
	      return "redirect:/main/mainpage";    
	  }
	 
}
