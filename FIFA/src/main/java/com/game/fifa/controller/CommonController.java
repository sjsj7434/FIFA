package com.game.fifa.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.game.fifa.service.FO4announcementService.FO4announcementService;
import com.game.fifa.service.FO4visitorSessionService.FO4visitorSessionService;
import com.game.fifa.vo.FO4announcementVO;

@Controller
public class CommonController {
	
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	FO4announcementService announcementService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String normal(Model model, FO4announcementVO announcementVO) {
	//방문자 counter 관련
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
	//방문자 counter 관련
		
	//공지사항 관련
		List<FO4announcementVO> announcementList = announcementService.selectAnnouncementList(announcementVO);
		int totalAnnouncementCount = announcementService.selectCountAnnouncementList();
		int pagination = 0;
		if(totalAnnouncementCount%10 > 0) {
			pagination = (totalAnnouncementCount/10) + 1;
		}
		else {
			pagination = (totalAnnouncementCount/10);
		}
		JSONArray jsonArray = new JSONArray();
		for(int index = 0; index < announcementList.size(); index++) {
			JSONObject json = new JSONObject();
			json.put("post_id", announcementList.get(index).getPost_id());
			json.put("post_title", announcementList.get(index).getPost_title());
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			json.put("post_write_date", dateFormat.format(announcementList.get(index).getPost_write_date()));
			jsonArray.add(json);
		}
	//공지사항 관련
	
		model.addAttribute("announcementList", jsonArray);
		model.addAttribute("pagination", pagination);
		model.addAttribute("offset", announcementVO.getOffset());
		
		return "announcement";
	}

}