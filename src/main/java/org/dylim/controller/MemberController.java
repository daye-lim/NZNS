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
	
	/*ȸ������ ������ �̵�*/
	@RequestMapping(value = "m_register", method = RequestMethod.GET)
	public void m_register() {
		
		log.info("����ȸ������ ������ ����");
		
	}
	

	
	/* �α��� ������ �̵� */
	@RequestMapping(value = "loginpage", method = RequestMethod.GET)
	public void login() {
		
		log.info("�α��� ������ ����");
		
	}

	/* ����ȸ�� ȸ������ */
	@RequestMapping(value="/m_register", method=RequestMethod.POST)
	public String m_registerPost(member_iVO member) throws Exception{
			
		log.info("����ȸ����� ����");
			
		
//		String rawPw  = "";        	   // ���ڵ� �� ��й�ȣ
//	    String encodePw = "";     		   // ���ڵ� �� ��й�ȣ
	    
	    
//	    rawPw = member.getPassword();        // ��й�ȣ ������ ����
//	    encodePw = pwEncoder.encode(rawPw);        // ��й�ȣ ���ڵ�
//	    member.setPassword(encodePw);            // ���ڵ��� ��й�ȣ member��ü�� �ٽ� ����
	    
	    
	 // ȸ������ ����(����) ����
	 memberservice.m_register(member);
	 			
	 log.info("member register Service ����");
//	 System.out.println("ȸ������ raw : "+rawPw);
//     System.out.println("ȸ������ enc : "+encodePw);
	 		
		return "redirect:/member/loginpage";
		// �α����������� �̵�
			
		}	
	
	/* ���̵� �ߺ� �˻� */
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody //�ش� �ڵ带 �߰������� �ʴ´ٸ� mregister.jsp�� �޼����� ����� ��ȯ���� ����.
	public String memberIdChkPOST(String id) throws Exception{
		
		//log.info("memberIdChk() ����");

// memberservice.idCheck(id)�� ����� int�� ���� result�� �����մϴ�. (�����Ѵٸ� '1', �������� �ʴ´ٸ� '0'�� ��ȯ�ϰ� �˴ϴ�.)
// - result�� ����� 0�� �ƴϸ� "fail"�� ��ȯ�ϰ�, result�� ����� 1�� �ƴϸ� "success"�� ��ȯ�մϴ�. 
		int result = memberservice.idCheck(id);
		
		log.info("����� = " + result);
		
		if(result != 0) {
			
			return "fail";	// �ߺ� ���̵� ����
			
		} else {
			
			return "success";	// �ߺ� ���̵� x
			
		}	
		
	} // memberIdChkPOST() ����	
	

	 
    /* �̸��� ���� */
    @RequestMapping(value="/emailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String emailCheckGET(String email) throws Exception{
        
        /* ��(View)�κ��� �Ѿ�� ������ Ȯ�� */
    	log.info("�̸��� ������ ���� Ȯ��");
    	log.info("������ȣ : " + email);
    	
        /* ������ȣ(����) ���� 111111~999999������ ���� */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        log.info("������ȣ : " + checkNum);       
        /* �̸��� ������ */
        String setFrom = "yeyeyeah_@naver.com";
        String toMail = email;	// ���Ź��� �̸����ּ�
        String title = "ȸ������ ���� �̸��� �Դϴ�.";	// �̸��� ����
        String content = 						// �̸��� ����
                "Ȩ�������� �湮���ּż� �����մϴ�." +
                "<br><br>" + 
                "���� ��ȣ�� " + checkNum + "�Դϴ�." + 
                "<br>" + 
                "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���.";

       
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
    
	/* �α��� */
	@RequestMapping(value = "/loginpage", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, memberVO Allmember, RedirectAttributes rttr) throws Exception{
	
		System.out.println("login �޼��� ����");
		System.out.println("���޵� ������ : " + Allmember);
		
		HttpSession session = request.getSession();
		memberVO mvo = memberservice.Login(Allmember); // �����Ѿ��̵�� ��ġ�ϴ� ���̵��ִ��� 

		
		/* lvo ���� null�� ��� �α��� �����̱� ������ �α��� �������� �����̷�Ʈ �ǵ���, 
		 * null�� �ƴ� ��� �α��� �����̱� ������ ���� �������� �����̷�Ʈ �ǵ��� return ���� ����
		 * */
		if(mvo == null) {                                // ��ġ���� �ʴ� ���̵�, ��й�ȣ �Է� ���
            
            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/member/loginpage";
            
        }
		
        
        session.setAttribute("loginResult", mvo);             // ��ġ�ϴ� ���̵�, ��й�ȣ ��� (�α��� ����)
        
        return "redirect:/main/mainpage";
        
        
    }    



		
		/* 
		 * ��й�ȣ ���ڵ� �ڵ�
		 * 		
		 * HttpSession session = request.getSession();
		String rawPw  = "";            // ���ڵ� �� ��й�ȣ
	    String encodePw = "";        // ���ڵ� �� ��й�ȣ
	    
	    ȸ���� ������ ��ȯ�ϴ� ������ ����(������� ���̵� �������� ��)
		=> ȸ���� ������ null�����Ǵ�
		
		
   		�� null �ΰ�� - �α��� ����
         => �α��� ���� ���� �ڵ�
   		�� null �ƴ� ��� 
         => matchers() ���� ���� �����ͺ��̽� ����� ��й�ȣ�� ����� ��й�ȣ ��ġ ���� Ȯ��
               ��(true) true�� ��� - ��й�ȣ ��ġ
                     �α��� ���� ���� �ڵ�
               ��(false) false�� ��� - ��й�ȣ ����ġ 
                     �α��� ���� ���� �ڵ�
                     
                     

		if(lvo != null) {            // ��ġ�ϴ� ���̵� �����
			
			rawPw = member.getPassword();        // ����ڰ� ������ ��й�ȣ
	        encodePw = lvo.getPassword();        // �����ͺ��̽��� ������ ���ڵ��� ��й�ȣ
	        System.out.println("raw : "+rawPw);
	        System.out.println("enc : "+encodePw);
	        
	           if(true == pwEncoder.matches(rawPw, encodePw)) {        // ��й�ȣ ��ġ���� �Ǵ�
	        	 
	        	    lvo.setPassword("");                    // ���ڵ��� ��й�ȣ ���� ����
	                session.setAttribute("member", lvo);     // session�� ������� ���� ����
	                
	                return "redirect:/main/mainpage";       // ���������� �̵�
	                
               } else {
            	   
            	   rttr.addFlashAttribute("result", 0);		// 0 = ����, 1 = ��
                   return "redirect:/member/loginpage";
                   
               }
		} else {                                // ��ġ�ϴ� ���̵� �������� ���� �� (�α��� ����)
         
			rttr.addFlashAttribute("result", 0);		// 0 = ����, 1 = ��
            return "redirect:/member/loginpage";
            
        }


	}*/
	
	
	
	  /* ���������� �α׾ƿ� -> ���� �����ϴ� �۾� */
  @RequestMapping(value="/logout", method=RequestMethod.GET)
  public String logoutMainGET(HttpServletRequest request) throws Exception{
  	   
      log.info("logoutMainGET�޼��� ����");
      
      HttpSession session = request.getSession();	// ���Ǻ��� �ʱ�ȭ
      
      session.invalidate();
      
      return "redirect:/main/mainpage";    
  }
	
	/*����Ͻ�ȸ������ ������ �̵�*/
	@RequestMapping(value = "b_register", method = RequestMethod.GET)
	public void b_register() {
		
		log.info("����Ͻ�ȸ������ ������ ����");
		
	}
	
	/* ����Ͻ�ȸ�� ȸ������ */
	@RequestMapping(value="/b_register", method=RequestMethod.POST)
	public String b_registerPost(member_bVO b_member) throws Exception{
			
		log.info("����Ͻ�ȸ����� ����");
			
	 // ȸ������ ����(����) ����
	 memberservice.b_register(b_member);
	 			
	 log.info("b_member register Service ����");
	 		
		return "redirect:/member/loginpage";
		// �α����������� �̵�
			
		} 
	
	
	
	/*���� ������ �̵�*/
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public void mypage() {	}
	

	/* ����ȸ������ ��ȸ */
	@RequestMapping(value = "/member_detail_i", method = RequestMethod.POST)
	public String ReadMemberGET(HttpServletRequest request,member_iVO member, Model model,  RedirectAttributes rttr) throws Exception{

		//���� ��ü �ȿ� �ִ� ID���� ����
		String id = (String) member.getId();
		String password = (String) member.getPassword();
		
		//���񽺾��� ȸ���������� �޼��� ȣ���� ����� ivo�� ����
		member_iVO ivo = memberservice.readMember(id,password);
		
		log.info("ivo = "+ivo);
		
		if(ivo == null) {
			//select ����� null�̸�, (id,pw����ġ ��)
				int result = 0;
	            rttr.addFlashAttribute("result", result);
	            return "redirect:/member/mypage";
		}
		

		//member_iVO�� ������ session (member)�� ����
//		session.setAttribute("Allmember",ivo);
		//�������� �� ������ �̵�
		model.addAttribute("member", ivo);

		return "member/member_detail_i";

	}	
	
	/* ����ȸ������ ���� */

	@PostMapping(value = "/member_update_i.do")
	public String MemberUpdatePOST(member_iVO member, Model model ) throws Exception {
		memberservice.updateMember(member);
		return  "/member/member_update_i";
	}
	
	/* ����ȸ�� Ż�� */
	@PostMapping(value = "/member_delete_i.do")
	public String deleteMemberPOST(String id, HttpServletRequest request) throws Exception { 
		log.info("delete�޼ҵ� ����..................."+id);
		memberservice.deleteMember(id);
	
		return "redirect:/member/member_delete_i";	
	}
	
	  @RequestMapping(value="/member_delete_i", method=RequestMethod.GET)
	  public String logoutMainGET2(HttpServletRequest request) throws Exception{
	  	   
	      log.info("logoutMainGET�޼��� ����");
	      
	      HttpSession session = request.getSession();	// ���Ǻ��� �ʱ�ȭ
	      
	      session.invalidate();
	      
	      return "redirect:/main/mainpage";    
	  }
	
	
	/* ����Ͻ�ȸ������ ��ȸ */
	@RequestMapping(value = "/member_detail_b", method = RequestMethod.POST)
	public String ReadAgentGET(HttpServletRequest request,member_bVO b_member, Model model, RedirectAttributes rttr) throws Exception{

		//���� ��ü �ȿ� �ִ� ID,PW���� ����
		String id = (String) b_member.getId();
		String password = (String) b_member.getPassword();
		log.info(" ����Ͻ�ȸ������ GET�� ���̵� "+id);

		//���񽺾��� ȸ���������� �޼��� ȣ���� ����� bvo�� ����
		member_bVO bvo = memberservice.readAgent(id,password);
		
		//member_bVO�� ������ session (b_member)�� ����

		if(bvo == null) {
			//select ����� null�̸�, (id,pw����ġ ��)
				int result = 0;
	            rttr.addFlashAttribute("result", result);
	            return "redirect:/member/mypage";
		}
		

		//�������� �� ������ �̵�
		model.addAttribute("b_member", bvo);
		log.info(" ����Ͻ�ȸ������ GET�� VO "+ bvo);
		
		return "member/member_detail_b";
	}
	
	
	/* ����Ͻ�ȸ������ ���� */

	@PostMapping(value = "/member_update_b.do")
	public String AgentUpdatePOST(member_bVO b_member, Model model ) throws Exception {
		memberservice.updateAgent(b_member);
		log.info("AgentUpdateGET b_member = " + b_member);
		return  "/member/member_update_b";
	}

	/* ����Ͻ�ȸ�� Ż��*/
	@PostMapping(value = "/member_delete_b.do")
	public String deleteAgentPOST(String id, HttpServletRequest request) throws Exception { 
		log.info("delete�޼ҵ� ����..................."+id);
		memberservice.deleteAgent(id);
	
		return "redirect:/member/member_delete_b";	
	}
	
	  @RequestMapping(value="/member_delete_b", method=RequestMethod.GET)
	  public String logoutMainGET3(HttpServletRequest request) throws Exception{
	  	   
	      log.info("logoutMainGET�޼��� ����");
	      
	      HttpSession session = request.getSession();	// ���Ǻ��� �ʱ�ȭ
	      
	      session.invalidate();
	      
	      return "redirect:/main/mainpage";    
	  }
	 
}
