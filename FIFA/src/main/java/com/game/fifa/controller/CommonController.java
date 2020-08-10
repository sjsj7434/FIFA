package com.game.fifa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.game.fifa.service.FO4announcementService.FO4announcementService;
import com.game.fifa.service.FO4visitorSessionService.FO4visitorSessionService;

@Controller
public class CommonController {
	
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	FO4announcementService announcementService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String normal(Model model) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		return "playerSearch";
	}

}