package com.game.fifa.dao.FO4errorReportDAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.game.fifa.vo.FO4errorReportVO;

@Repository
public class FO4errorReportDAOImpl implements FO4errorReportDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String mapperNamespace = "playerMapper.";//해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다

	@Override
	public void insertErrorReport(FO4errorReportVO errorReportVO) {
		sqlSession.insert(mapperNamespace + "insertErrorReport", errorReportVO);
	}

	@Override
	public List<FO4errorReportVO> selectErrorReportList(FO4errorReportVO errorReportVO) {
		return sqlSession.selectList(mapperNamespace + "selectErrorReportList", errorReportVO);
	}
}