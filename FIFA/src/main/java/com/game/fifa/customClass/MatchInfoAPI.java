package com.game.fifa.customClass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MatchInfoAPI {
	
	private static final String Authorization = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiNjU0NDcxODA3IiwiYXV0aF9pZCI6IjIiLCJ0b2tlbl90eXBlIjoiQWNjZXNzVG9rZW4iLCJzZXJ2aWNlX2lkIjoiNDMwMDExNDgxIiwiWC1BcHAtUmF0ZS1MaW1pdCI6IjIwMDAwOjEwIiwibmJmIjoxNTc0NjQ5MDE2LCJleHAiOjE2Mzc3MjEwMTYsImlhdCI6MTU3NDY0OTAxNn0.ofK1h46pzjKcW1-0fwRfv282vEShQHeaLPOr0pIQs8o";

	@SuppressWarnings("unchecked")
	public JSONArray findMatchByAccessId(String accessId, String matchtype, int offset, int limit) throws IOException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/users/"+ URLEncoder.encode(accessId, "utf-8") +"/matches?matchtype="+ matchtype +"&offset="+ offset +"&limit="+ limit);
        HttpURLConnection connection = (HttpURLConnection)url.openConnection(); 
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", Authorization);
        connection.setDoOutput(false);
        
        int responseCode = connection.getResponseCode();
		BufferedReader bufferedReader;
		JSONArray jsonArray = new JSONArray();

		if(responseCode == 200) {
			bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        	
        	String inputLine;
	        StringBuffer stringBuffer = new StringBuffer();
	        while ((inputLine = bufferedReader.readLine()) != null) {
	        	stringBuffer.append(inputLine);
	        }
	        bufferedReader.close();
	        
	        JSONParser parser = new JSONParser();
	        Object object = parser.parse(stringBuffer.toString());
	        jsonArray = (JSONArray) object;
	        
	        JSONObject json = new JSONObject();
	        json.put("findMatchByAccessIdCode", responseCode);
	        
	        jsonArray.add(json);
	        
	        connection.disconnect();
	        
	        return jsonArray;
		}
		else {
			JSONObject json = new JSONObject();
			json.put("findMatchByAccessIdCode", responseCode);
			
			jsonArray.add(json);
			
			return jsonArray;
		}
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject matchDetail(String matchId) throws IOException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/matches/"+ matchId);
        HttpURLConnection connection = (HttpURLConnection)url.openConnection(); 
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", Authorization);
        connection.setDoOutput(false);
        
        int responseCode = connection.getResponseCode();
		BufferedReader bufferedReader;
		JSONObject jsonObject = new JSONObject();

		if(responseCode == 200) {
			bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        	
        	String inputLine;
	        StringBuffer stringBuffer = new StringBuffer();
	        while ((inputLine = bufferedReader.readLine()) != null) {
	        	stringBuffer.append(inputLine);
	        }
	        bufferedReader.close();
	        
	        JSONParser parser = new JSONParser();
	        Object object = parser.parse(stringBuffer.toString());
	        jsonObject = (JSONObject) object;
	        
	        jsonObject.put("matchDetailCode", responseCode);
	        
	        connection.disconnect();
	        
	        return jsonObject;
		}
		else {
			jsonObject.put("matchDetailCode", responseCode);
			
			return jsonObject;
		}
	}
}