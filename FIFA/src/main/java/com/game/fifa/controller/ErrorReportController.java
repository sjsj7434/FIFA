package com.game.fifa.controller;

import java.sql.Timestamp;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.game.fifa.service.FO4errorReportService;
import com.game.fifa.service.FO4visitorSessionService;
import com.game.fifa.vo.FO4errorReportVO;

@Controller
public class ErrorReportController {
	
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	private FO4errorReportService errorReportService;
	
	@RequestMapping(value = "/errorReport", method = RequestMethod.GET)
	public String errorReport(Model model) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		return "errorReport";
	}
	
	@RequestMapping(value = "/errorReportWrite", method = RequestMethod.POST)
	@ResponseBody
	public String errorReportWrite(Locale locale, Model model, FO4errorReportVO errorReportVO) {
		System.out.println(locale.toString());
		Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
		errorReportVO.setPost_type("report");
		errorReportVO.setPost_write_date(timeStamp);
		errorReportVO.setLocale(locale.toString());
		
		errorReportService.insertErrorReport(errorReportVO);

		return "errorReport";
	}
}