package com.game.fifa.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.game.fifa.customClass.MatchInfoAPI;
import com.game.fifa.customClass.UserInfoAPI;
import com.game.fifa.service.FO4playerService.FO4playerService;
import com.game.fifa.service.FO4visitorSessionService.FO4visitorSessionService;
import com.game.fifa.vo.FO4playerVO;

@Controller
public class UserMatchSearchController {
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	FO4playerService playerService;
	
	@RequestMapping(value = "/userMatchSearch", method = RequestMethod.GET)
	public String userMatchSearch(Model model) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		return "userMatchSearch";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/userMatchSearchAjax", method = RequestMethod.GET)
	@ResponseBody
	public JSONArray userSearchAjax(Model model, HttpServletRequest request) throws IOException, ParseException {
		String nickName = request.getParameter("nickName");
		String matchtype = request.getParameter("matchtype");
		int offset = Integer.parseInt(request.getParameter("offset"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		
		JSONArray jsonArray = new JSONArray();
		UserInfoAPI userInfoAPI = new UserInfoAPI();
		MatchInfoAPI matchInfoAPI = new MatchInfoAPI();
		
		JSONObject json_findUserByNickName = userInfoAPI.findUserByNickName(nickName);
		jsonArray.add(json_findUserByNickName);
		
		int userFindByNickNameCode = (Integer) json_findUserByNickName.get("userFindByNickNameCode");
		
		if(userFindByNickNameCode == 200) {
			String accessId = json_findUserByNickName.get("accessId").toString();
			
			JSONArray json_userMaxDivision = userInfoAPI.userMaxDivision(accessId);
			jsonArray.add(json_userMaxDivision);
			
			JSONArray json_findMatchByAccessId = matchInfoAPI.findMatchByAccessId(accessId, matchtype, offset, limit);
			jsonArray.add(json_findMatchByAccessId);
			
			JSONObject jsonLastLine = (JSONObject) json_findMatchByAccessId.get(limit);
			int findMatchByAccessIdCode = (Integer) jsonLastLine.get("findMatchByAccessIdCode");
			if(findMatchByAccessIdCode == 200) {
				JSONArray json_findMatchByAccessId2 = new JSONArray();
				for(int index = 0; index < json_findMatchByAccessId.size()-1; index++) {
					String matchId = (String) json_findMatchByAccessId.get(index);
					json_findMatchByAccessId2.add(matchInfoAPI.matchDetail(matchId));
				}
				jsonArray.add(json_findMatchByAccessId2);
			}
		}
		
		return jsonArray;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/searchPlayerList", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray searchPlayerList(Model model, HttpServletRequest request, @RequestBody Map<String, Object> map) throws IOException, ParseException {
		JSONArray jsonArray = new JSONArray();
		
		for(int index = 0; index < map.size(); index++) {
			FO4playerVO vo = playerService.getPlayerByspid(map.get(Integer.toString(index)).toString());
			jsonArray.add(vo);
		}
		
		return jsonArray;
	}
}