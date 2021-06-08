package org.dylim.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
@Controller	
@Log4j
@RequestMapping("/house/*")
public class HouseController {
	@RequestMapping(value ="/findHouse", method = RequestMethod.GET)
	public void findHouse() {
		log.info("mainpage½ÇÇà..............");
	}
}
