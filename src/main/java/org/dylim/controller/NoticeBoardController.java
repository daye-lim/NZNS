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

	
	/* 게시물 목록 조회 (페이징) */
	@GetMapping("/NoticeList")
	public void list(Criteria cri, Model model) {
		
		log.info("list: "+cri);
		model.addAttribute("list", notice.NoticeGetList(cri));
		
		int total = notice.getTotal(cri);
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));	// 파라미터 = cri와 전체 데이터수(total)
		
	}
	
	/* 게시물 등록 */
	@PostMapping("/NoticeRegister")
	public String NoticeRegister(NoticeVO nvo, RedirectAttributes rttr) {

		memberVO mvo = new memberVO();
		
		log.info("==================");
		log.info("register: " + notice);
		
		
		log.info("==================");
		
		notice.NoticeRegister(nvo);
		rttr.addFlashAttribute("result", nvo.getNno());
		// redirect시 데이터를 전달하는 방법: addFlashAttribute(post형식) -> String, Object를 전달
		return "redirect:/notice/NoticeList";
		
	}
	
	
	/*게시물의 등록작업은 POST방식으로 처리하지만, 
	화면에서 입력을 받아야 하므로 GET방식으로 입력 페이지를 볼 수 있도록 BoardController에 register()메서드를 추가*/
		@GetMapping("/NoticeRegister")
		public void NoticeRegister() {
			
		}
	
	/* 게시물 조회 */
	@GetMapping({"/NoticeGet","/NoticeModify"})
	public void NoticeGet(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, Model model) {
		// view에 해당번호의 게시물을 전달해야하므로 Model을 파라미터로 지정
		// model에 "cri"이름으로 Criteria데이터를 담음

		model.addAttribute("notice", notice.NoticeGet(nno));
		
		
	}
	
	
	
	/* 게시물 수정 */
	@PostMapping("/NoticeModify")
	public String NoticeModify(NoticeVO nvo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(notice.NoticeModify(nvo)) {
			rttr.addFlashAttribute("result", "success");
		}

		
		return "redirect:/notice/NoticeList" + cri.getListLink();
		
	}
	
	/* 게시물 삭제 */
	@PostMapping("/NoticeRemove")
	public String NoticeRemove(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		if(notice.NoticeRemove(nno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/notice/NoticeList" + cri.getListLink();
		
	}
	
	
	

}
