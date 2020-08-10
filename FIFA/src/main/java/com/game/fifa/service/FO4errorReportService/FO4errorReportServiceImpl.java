package com.game.fifa.service.FO4errorReportService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.fifa.dao.FO4errorReportDAO.FO4errorReportDAO;
import com.game.fifa.vo.FO4errorReportVO;

@Service
public class FO4errorReportServiceImpl implements FO4errorReportService{

	@Autowired
	private FO4errorReportDAO errorReportDAO;
	
	@Override
	public void insertErrorReport(FO4errorReportVO errorReportVO) {
		errorReportDAO.insertErrorReport(errorReportVO);
	}

	@Override
	public List<FO4errorReportVO> selectErrorReportList(FO4errorReportVO errorReportVO) {
		return errorReportDAO.selectErrorReportList(errorReportVO);
	}
}
