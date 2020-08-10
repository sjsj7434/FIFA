package com.game.fifa.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.game.fifa.customClass.UserInfoAPI;
import com.game.fifa.service.FO4playerService.FO4playerService;
import com.game.fifa.service.FO4visitorSessionService.FO4visitorSessionService;
import com.game.fifa.vo.FO4playerVO;

@Controller
public class UserTradeSearchController {
	
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	private FO4playerService playerService;

	@RequestMapping(value = "/userTradeSearch", method = RequestMethod.GET)
	public String userSearch(Model model) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		return "userTradeSearch";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/userTradeSearchAjax", method = RequestMethod.GET)
	@ResponseBody
	public JSONArray userTradeSearchAjax(Model model, HttpServletRequest request) throws IOException, ParseException {
		String nickName = request.getParameter("nickName");
		int offset = Integer.parseInt(request.getParameter("offset"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		
		JSONArray jsonArray = new JSONArray();
		
		UserInfoAPI userInfoAPI = new UserInfoAPI();
		
		JSONObject User = userInfoAPI.findUserByNickName(nickName);
		int userFindByNickNameCode = (Integer) User.get("userFindByNickNameCode"); 
        
		if(userFindByNickNameCode == 200) {
			String accessId = User.get("accessId").toString();
			
			jsonArray.add(User);
			jsonArray.add(userInfoAPI.userMaxDivision(accessId));
			
			//sell 기록 - 시작
			JSONArray jsonArraySell = userInfoAPI.userSell(accessId, offset, limit);
			jsonArray.add(jsonArraySell);
			JSONArray playerArray_sell = new JSONArray();
	        for(int i = 0; i < jsonArraySell.size()-1; i++) {
	        	Object object = jsonArraySell.get(i);
	        	JSONObject jsonObject = (JSONObject) object;
	        	
	        	FO4playerVO playerVO = playerService.getPlayerByspid(jsonObject.get("spid").toString());
	        	
	        	String imageSrc = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p"+ jsonObject.get("spid") + ".png";
	        	JSONObject playerSellObject = new JSONObject();
	        	
	        	playerSellObject.put("type", "sell");
	        	playerSellObject.put("spid", jsonObject.get("spid"));
	        	playerSellObject.put("imageSrc", imageSrc);
	        	playerSellObject.put("playerVO", playerVO);
	        	playerArray_sell.add(playerSellObject);
	        }
	        jsonArray.add(playerArray_sell);
			//sell 기록 - 끝
			
	        //buy 기록 - 시작
	        JSONArray jsonArrayBuy = userInfoAPI.userBuy(accessId, offset, limit);
			jsonArray.add(jsonArrayBuy);
			JSONArray playerArray_buy = new JSONArray();
	        for(int i = 0; i < jsonArrayBuy.size()-1; i++) {
				Object object = jsonArrayBuy.get(i);
	        	JSONObject jsonObject = (JSONObject) object;
	        	
	        	FO4playerVO playerVO = playerService.getPlayerByspid(jsonObject.get("spid").toString());
	        	
	        	String imageSrc = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p"+ jsonObject.get("spid") + ".png";
	        	JSONObject playerBuyObject = new JSONObject();
	        	
	        	playerBuyObject.put("type", "buy");
	        	playerBuyObject.put("spid", jsonObject.get("spid"));
	        	playerBuyObject.put("imageSrc", imageSrc);
	        	playerBuyObject.put("playerVO", playerVO);
	        	playerArray_buy.add(playerBuyObject);
	        }
	        jsonArray.add(playerArray_buy);
			//buy 기록 - 끝
	        
	        return jsonArray;
		}
		else {
			return jsonArray;
		}
	}
}