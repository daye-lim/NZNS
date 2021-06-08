package org.dylim.controller;



import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;
import org.dylim.domain.PageDTO;
import org.dylim.domain.memberVO;


import org.dylim.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeBoardController {
	
	private NoticeService notice;

	
	/* �Խù� ��� ��ȸ (����¡) */
	@GetMapping("/NoticeList")
	public void list(Criteria cri, Model model) {
		
		log.info("list: "+cri);
		model.addAttribute("list", notice.NoticeGetList(cri));
		
		int total = notice.getTotal(cri);
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));	// �Ķ���� = cri�� ��ü �����ͼ�(total)
		
	}
	
	/* �Խù� ��� */
	@PostMapping("/NoticeRegister")
	public String NoticeRegister(NoticeVO nvo, RedirectAttributes rttr) {

		memberVO mvo = new memberVO();
		
		log.info("==================");
		log.info("register: " + notice);
		
		
		log.info("==================");
		
		notice.NoticeRegister(nvo);
		rttr.addFlashAttribute("result", nvo.getNno());
		// redirect�� �����͸� �����ϴ� ���: addFlashAttribute(post����) -> String, Object�� ����
		return "redirect:/notice/NoticeList";
		
	}
	
	
	/*�Խù��� ����۾��� POST������� ó��������, 
	ȭ�鿡�� �Է��� �޾ƾ� �ϹǷ� GET������� �Է� �������� �� �� �ֵ��� BoardController�� register()�޼��带 �߰�*/
		@GetMapping("/NoticeRegister")
		public void NoticeRegister() {
			
		}
	
	/* �Խù� ��ȸ */
	@GetMapping({"/NoticeGet","/NoticeModify"})
	public void NoticeGet(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, Model model) {
		// view�� �ش��ȣ�� �Խù��� �����ؾ��ϹǷ� Model�� �Ķ���ͷ� ����
		// model�� "cri"�̸����� Criteria�����͸� ����

		model.addAttribute("notice", notice.NoticeGet(nno));
		
		
	}
	
	
	
	/* �Խù� ���� */
	@PostMapping("/NoticeModify")
	public String NoticeModify(NoticeVO nvo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(notice.NoticeModify(nvo)) {
			rttr.addFlashAttribute("result", "success");
		}

		
		return "redirect:/notice/NoticeList" + cri.getListLink();
		
	}
	
	/* �Խù� ���� */
	@PostMapping("/NoticeRemove")
	public String NoticeRemove(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		if(notice.NoticeRemove(nno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/notice/NoticeList" + cri.getListLink();
		
	}
	
	
	

}
