package com.game.fifa.vo;

import java.sql.Timestamp;

public class FO4visitorSessionVO {
	String visitorIP;
	Timestamp sessionCreatedTime;
	String user_agent;
	String referer;

	public String getUser_agent() {
		return user_agent;
	}

	public void setUser_agent(String user_agent) {
		this.user_agent = user_agent;
	}

	public String getReferer() {
		return referer;
	}

	public void setReferer(String referer) {
		this.referer = referer;
	}

	public String getVisitorIP() {
		return visitorIP;
	}

	public void setVisitorIP(String visitorIP) {
		this.visitorIP = visitorIP;
	}

	public Timestamp getSessionCreatedTime() {
		return sessionCreatedTime;
	}

	public void setSessionCreatedTime(Timestamp sessionCreatedTime) {
		this.sessionCreatedTime = sessionCreatedTime;
	}

}