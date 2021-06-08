package org.dylim.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.dylim.domain.BoardAttachVO;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;
import org.dylim.domain.PageDTO;
import org.dylim.domain.memberVO;
import org.dylim.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
		
	/* �Խù� ��� ��ȸ (����¡) */
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list: "+cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));	// �Ķ���� = cri�� ��ü �����ͼ�(total)
		
	}

	/* �Խù� ��� */
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {

		memberVO mvo = new memberVO();
		
		log.info("==================");
		log.info("register: " + board);
		
		if(board.getAttachList() != null) {
			
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("==================");
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		// redirect�� �����͸� �����ϴ� ���: addFlashAttribute(post����) -> String, Object�� ����
		return "redirect:/board/list";
		
	}
	
	/*�Խù��� ����۾��� POST������� ó��������, 
	ȭ�鿡�� �Է��� �޾ƾ� �ϹǷ� GET������� �Է� �������� �� �� �ֵ��� BoardController�� register()�޼��带 �߰�*/
		@GetMapping("/register")
		public void register() {
			
		}
	
	/* �Խù� ��ȸ */
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// view�� �ش��ȣ�� �Խù��� �����ؾ��ϹǷ� Model�� �Ķ���ͷ� ����
		// model�� "cri"�̸����� Criteria�����͸� ����
		
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
		
		
	}
	
	
	
	/* �Խù� ���� */
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify: " + board);
		
		if(service.modify(board)) {
			// service.modify()�� �������θ� boolean���� ó���ϹǷ� �̸� �̿��ؼ� ������ ��쿡��
			// RedirectAttributes�� �߰��Ѵ�
			rttr.addFlashAttribute("result", "success");
		}
		
		// ���� �� ������ ����ڰ� ���� �������� �̵�		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
		
		// ����ȭ�鿡�� �۾� �� �ٽ� ����������� �̵��� �˻� ������ �����ǵ��� �Ѵ�
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());

		// �� ���� �Ķ���͵��� ��getListLink()�� ���� �ս��� �߰��Ѵ�
		
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	/* �Խù� ���� */
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove..." + bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			// delete Attach Files
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		
		// ���� �� ������ ����ڰ� ���� �������� �̵�
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());

		// ����ȭ�鿡�� �۾� �� �ٽ� ����������� �̵��� �˻� ������ �����ǵ��� �Ѵ�
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		// �� ���� �Ķ���͵��� ��getListLink()�� ���� �ս��� �߰��Ѵ�
		
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	
	/* �Խù� ��õ */
	@GetMapping("/recommend")
	public String recommend (@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		service.recommend(bno);
		return "redirect:/board/list" + cri.getListLink();
	}
	

	/* ÷������ ��� */
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // BoardController�� @RestController�� �ۼ����� �ʾ����Ƿ� @ResponseBody�߰�
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList " + bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	
	
	/* ���� ���� ó�� */
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files..........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" +attach.getUuid()+"_"+ attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		}); // end foreach
	}
}
