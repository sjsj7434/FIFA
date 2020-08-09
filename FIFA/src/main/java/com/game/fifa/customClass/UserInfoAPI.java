package com.game.fifa.customClass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class UserInfoAPI {
	
	private static final String Authorization = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiNjU0NDcxODA3IiwiYXV0aF9pZCI6IjIiLCJ0b2tlbl90eXBlIjoiQWNjZXNzVG9rZW4iLCJzZXJ2aWNlX2lkIjoiNDMwMDExNDgxIiwiWC1BcHAtUmF0ZS1MaW1pdCI6IjIwMDAwOjEwIiwibmJmIjoxNTc0NjQ5MDE2LCJleHAiOjE2Mzc3MjEwMTYsImlhdCI6MTU3NDY0OTAxNn0.ofK1h46pzjKcW1-0fwRfv282vEShQHeaLPOr0pIQs8o";

	@SuppressWarnings("unchecked")
	public JSONObject findUserByNickName(String nickName) throws IOException, UnsupportedEncodingException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/users?nickname=" + URLEncoder.encode(nickName, "utf-8"));
		HttpURLConnection connection = (HttpURLConnection)url.openConnection(); 
		connection.setRequestMethod("GET");
		connection.setRequestProperty("Authorization", Authorization);
		connection.setDoOutput(false);
		
		int responseCode = connection.getResponseCode();
		BufferedReader bufferedReader;
		JSONObject json = new JSONObject();
		
        if(responseCode == 200) {
        	bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        	
        	String inputLine;
	        StringBuffer stringBuffer = new StringBuffer();
	        while ((inputLine = bufferedReader.readLine()) != null) {
	        	stringBuffer.append(inputLine);
	        }
	        bufferedReader.close();
	        connection.disconnect();
	        
	        JSONParser parser = new JSONParser();
	        Object object = parser.parse(stringBuffer.toString());
	        json = (JSONObject) object;
	        json.put("userFindByNickNameCode", responseCode);
	        
	        return json;
        }
        else {
	        json.put("userFindByNickNameCode", responseCode);
	        
        	return json;
        }
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray userMaxDivision(String accessId) throws IOException, UnsupportedEncodingException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/users/"+ URLEncoder.encode(accessId, "utf-8") +"/maxdivision");
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
	        connection.disconnect();
	        
	        JSONParser parser = new JSONParser();
	        Object object = parser.parse(stringBuffer.toString());
	        jsonArray = (JSONArray) object;
	        
	        JSONObject json = new JSONObject();
	        json.put("userMaxDivisionCode", responseCode);	        
	        jsonArray.add(json);
	        
	        return jsonArray;
        }
        else {
        	//maxdivision이 존재하지 않을 때
        	JSONObject json = new JSONObject();
	        json.put("userMaxDivisionCode", responseCode);	        
	        jsonArray.add(json);
	        
        	return jsonArray;
        }
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray userSell(String accessId, int offset, int limit) throws IOException, UnsupportedEncodingException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/users/"+ URLEncoder.encode(accessId, "utf-8") +
				"/markets?tradetype="+ URLEncoder.encode("sell", "utf-8") +
				"&offset="+ offset +
				"&limit=" +	limit);
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
	        connection.disconnect();
	        
	        JSONParser parser = new JSONParser();
			Object parsed = parser.parse(stringBuffer.toString());
	        jsonArray = (JSONArray) parsed;
	        
	        JSONObject json = new JSONObject();
	        json.put("userSellCode", responseCode);	        
	        jsonArray.add(json);
	        
	        return jsonArray;
        }
        else {
        	//sell 기록이 없을 때
        	JSONObject json = new JSONObject();
	        json.put("userSellCode", responseCode);	        
	        jsonArray.add(json);
	        
        	return jsonArray;
        }
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray userBuy(String accessId, int offset, int limit) throws IOException, UnsupportedEncodingException, ParseException {
		URL url = new URL("https://api.nexon.co.kr/fifaonline4/v1.0/users/"+ URLEncoder.encode(accessId, "utf-8") +
				"/markets?tradetype="+ URLEncoder.encode("buy", "utf-8") +
				"&offset="+ offset +
				"&limit=" +	limit);
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
	        connection.disconnect();
	        
	        JSONParser parser = new JSONParser();
	        Object parsed = parser.parse(stringBuffer.toString());
	        jsonArray = (JSONArray) parsed;
	        
	        JSONObject json = new JSONObject();
	        json.put("userBuyCode", responseCode);	        
	        jsonArray.add(json);
	        
        	return jsonArray;
        }
        else {
        	//buy 기록이 없을 때
        	JSONObject json = new JSONObject();
	        json.put("userBuyCode", responseCode);	        
	        jsonArray.add(json);
	        
        	return jsonArray;
        }
	}
}