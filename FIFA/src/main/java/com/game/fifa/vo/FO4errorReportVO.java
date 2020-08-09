package com.game.fifa.vo;

import java.sql.Timestamp;

public class FO4errorReportVO {
	String post_title;
	String post_contents;
	String post_writer;
	Timestamp post_write_date;
	String post_type;
	String locale;
	int offset;
	int limit;

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public String getPost_title() {
		return post_title;
	}

	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}

	public String getPost_contents() {
		return post_contents;
	}

	public void setPost_contents(String post_contents) {
		this.post_contents = post_contents;
	}

	public String getPost_writer() {
		return post_writer;
	}

	public void setPost_writer(String post_writer) {
		this.post_writer = post_writer;
	}

	public Timestamp getPost_write_date() {
		return post_write_date;
	}

	public void setPost_write_date(Timestamp post_write_date) {
		this.post_write_date = post_write_date;
	}

	public String getPost_type() {
		return post_type;
	}

	public void setPost_type(String post_type) {
		this.post_type = post_type;
	}

}
