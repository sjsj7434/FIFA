package com.game.fifa.vo;

import java.sql.Timestamp;

public class FO4commonVO {
	String search_key;
	String user_ip;
	Timestamp search_date;
	String search_where;
	
	public String getSearch_key() {
		return search_key;
	}
	public void setSearch_key(String search_key) {
		this.search_key = search_key;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public Timestamp getSearch_date() {
		return search_date;
	}
	public void setSearch_date(Timestamp search_date) {
		this.search_date = search_date;
	}
	public String getSearch_where() {
		return search_where;
	}
	public void setSearch_where(String search_where) {
		this.search_where = search_where;
	}
}