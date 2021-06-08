package org.dylim.controller;



import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.dylim.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller	
@Log4j
@RequestMapping("/main/*")
@AllArgsConstructor
public class MainController {
	
	private BoardService service;
	
	@RequestMapping(value ="/mainpage", method = RequestMethod.GET)
	public void mainpage(Model model) {
		log.info("mainpage½ÇÇà..............");
		
		
		model.addAttribute("list",service.BestReviews());
		
	}
	

	

}

