package com.game.fifa.service;

import java.util.List;

import com.game.fifa.vo.FO4errorReportVO;

public interface FO4errorReportService {
	public void insertErrorReport(FO4errorReportVO errorReportVO);
	public List<FO4errorReportVO> selectErrorReportList(FO4errorReportVO errorReportVO);
}
