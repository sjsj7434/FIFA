package com.game.fifa.dao.FO4errorReportDAO;

import java.util.List;

import com.game.fifa.vo.FO4errorReportVO;

public interface FO4errorReportDAO {
	public void insertErrorReport(FO4errorReportVO errorReportVO);
	public List<FO4errorReportVO> selectErrorReportList(FO4errorReportVO errorReportVO);
}
