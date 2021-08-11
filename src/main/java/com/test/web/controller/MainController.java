package com.test.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView mainWeb() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("main");
		mv.addObject("menu", "main");
		return mv;
	}
	
}
