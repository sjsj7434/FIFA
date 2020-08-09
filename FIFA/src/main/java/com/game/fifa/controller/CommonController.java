package com.game.fifa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.game.fifa.service.FO4announcementService;
import com.game.fifa.service.FO4visitorSessionService;
import com.game.fifa.vo.FO4announcementVO;

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
	
	@RequestMapping(value = "/announcement", method = RequestMethod.GET)
	public String announcement(Model model, FO4announcementVO announcementVO) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		List<FO4announcementVO> announcementList = announcementService.selectAnnouncementList(announcementVO);
		model.addAttribute("announcementList", announcementList);

		return "announcement";
	}
}