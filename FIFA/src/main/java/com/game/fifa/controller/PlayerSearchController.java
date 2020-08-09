package com.game.fifa.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.game.fifa.service.FO4playerService;
import com.game.fifa.service.FO4visitorSessionService;
import com.game.fifa.vo.FO4playerVO;

@Controller
public class PlayerSearchController {
	
	@Autowired
	FO4visitorSessionService visitorSessionService;
	@Autowired
	private FO4playerService playerService;
	private static final String Authorization = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiNjU0NDcxODA3IiwiYXV0aF9pZCI6IjIiLCJ0b2tlbl90eXBlIjoiQWNjZXNzVG9rZW4iLCJzZXJ2aWNlX2lkIjoiNDMwMDExNDgxIiwiWC1BcHAtUmF0ZS1MaW1pdCI6IjIwMDAwOjEwIiwibmJmIjoxNTc0NjQ5MDE2LCJleHAiOjE2Mzc3MjEwMTYsImlhdCI6MTU3NDY0OTAxNn0.ofK1h46pzjKcW1-0fwRfv282vEShQHeaLPOr0pIQs8o";

	@RequestMapping(value = "/playerSearch", method = RequestMethod.GET)
	public String playerSearch(Model model) {
		int countAllVisitors = visitorSessionService.countAllVisitors();
		model.addAttribute("countAllVisitors", countAllVisitors);
		int countTodayVisitors = visitorSessionService.countTodayVisitors();
		model.addAttribute("countTodayVisitors", countTodayVisitors);
		
		return "playerSearch";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/graphAjax", method = RequestMethod.GET)
	@ResponseBody
	public JSONArray graphAjax(HttpServletRequest request) throws IOException, ParseException {
		String matchType = request.getParameter("matchType");
		String po = request.getParameter("position");
		String [] players = request.getParameterValues("players");
		
		JSONArray jsonList = new JSONArray();
		if(players != null) {
			for(int index = 0; index < players.length; index++) {
				JSONObject json = new JSONObject();
				json.put("id", Integer.parseInt(players[index]));
				json.put("po", Integer.parseInt(po));
				jsonList.add(json);
			}
		
			URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/rankers/status?matchtype="+ matchType +"&players=" + URLEncoder.encode(jsonList.toString(), "utf-8"));
			HttpURLConnection con = (HttpURLConnection)url.openConnection(); 
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", Authorization);
			con.setDoOutput(false);
			
			int responseCode = con.getResponseCode();
	
			BufferedReader bufferedReader;
	        if(responseCode == 200) {
	        	bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        	
	        	String inputLine;
		        StringBuffer response = new StringBuffer();
		        while ((inputLine = bufferedReader.readLine()) != null) {
		            response.append(inputLine);
		        }
		        bufferedReader.close();
		        
		        JSONParser parser = new JSONParser();
		        Object obj = parser.parse(response.toString());
		        JSONArray parsedJson = (JSONArray) obj;
		        
		        for(int i = 0; i < parsedJson.size(); i++) {
		        	JSONObject test = new JSONObject();
		        	test = (JSONObject) parsedJson.get(i);
		        	
		        	FO4playerVO player = playerService.getPlayerByspid(test.get("spId").toString());
		        	
		        	test.put("playerName", player.getName());
		        	test.put("playerSeasonimg", player.getSeasonimg());
		        	test.put("playerClassname", player.getClassname());
		        	
		        	parsedJson.toArray();
		        }
		        
				return parsedJson;
	        } 
	        else {
	        	bufferedReader = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		        bufferedReader.close();
		        
				JSONArray errorJson = new JSONArray();
				errorJson.add("비정상호출");
				return errorJson;
	        }
		}
		else {
			JSONArray errorJson = new JSONArray();
			errorJson.add("선수선택");
			return errorJson;
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/searchPlayer", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray searchPlayer(Model model, HttpServletRequest request) throws IOException {
		String playerName = request.getParameter("playerName");
		playerName = playerName.replaceAll(" ", "");
		
		List<FO4playerVO> playerList = playerService.getPlayer(playerName);
		
		if(playerList.size() > 0) {
			for(int index = 0; index < playerList.size(); index++) {
				/*
				 * URL url = new URL(
				 * "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p"+
				 * playerList.get(index).getId() + ".png"); HttpURLConnection con =
				 * (HttpURLConnection)url.openConnection(); con.setRequestMethod("GET");
				 * con.setRequestProperty("Authorization", Authorization);
				 * con.setDoOutput(false);
				 */
				String imageSrc = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p"+ playerList.get(index).getId() + ".png";
				playerList.get(index).setPlayerActionShotImage(imageSrc);
			}
	        
	        JSONArray jsonList = new JSONArray();
			jsonList.add(playerList);
			
			return jsonList;
		}
		else{
			JSONArray jsonList = new JSONArray();
			jsonList.add(playerList);
			
			return jsonList;
		}
	}
	
}