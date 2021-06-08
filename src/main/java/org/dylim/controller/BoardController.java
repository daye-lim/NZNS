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
		
	/* 게시물 목록 조회 (페이징) */
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list: "+cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));	// 파라미터 = cri와 전체 데이터수(total)
		
	}

	/* 게시물 등록 */
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
		// redirect시 데이터를 전달하는 방법: addFlashAttribute(post형식) -> String, Object를 전달
		return "redirect:/board/list";
		
	}
	
	/*게시물의 등록작업은 POST방식으로 처리하지만, 
	화면에서 입력을 받아야 하므로 GET방식으로 입력 페이지를 볼 수 있도록 BoardController에 register()메서드를 추가*/
		@GetMapping("/register")
		public void register() {
			
		}
	
	/* 게시물 조회 */
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// view에 해당번호의 게시물을 전달해야하므로 Model을 파라미터로 지정
		// model에 "cri"이름으로 Criteria데이터를 담음
		
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
		
		
	}
	
	
	
	/* 게시물 수정 */
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify: " + board);
		
		if(service.modify(board)) {
			// service.modify()는 수정여부를 boolean으로 처리하므로 이를 이용해서 성공한 경우에만
			// RedirectAttributes에 추가한다
			rttr.addFlashAttribute("result", "success");
		}
		
		// 수정 후 기존에 사용자가 보던 페이지로 이동		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
		
		// 수정화면에서 작업 후 다시 목록페이지로 이동시 검색 조건이 유지되도록 한다
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());

		// ▲ 위의 파라미터들을 ▼getListLink()를 통해 손쉽게 추가한다
		
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	/* 게시물 삭제 */
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove..." + bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			// delete Attach Files
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		
		// 삭제 후 기존에 사용자가 보던 페이지로 이동
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());

		// 삭제화면에서 작업 후 다시 목록페이지로 이동시 검색 조건이 유지되도록 한다
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		// ▲ 위의 파라미터들을 ▼getListLink()를 통해 손쉽게 추가한다
		
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	
	/* 게시물 추천 */
	@GetMapping("/recommend")
	public String recommend (@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		service.recommend(bno);
		return "redirect:/board/list" + cri.getListLink();
	}
	

	/* 첨부파일 목록 */
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // BoardController는 @RestController로 작성되지 않았으므로 @ResponseBody추가
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList " + bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	
	
	/* 파일 삭제 처리 */
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
