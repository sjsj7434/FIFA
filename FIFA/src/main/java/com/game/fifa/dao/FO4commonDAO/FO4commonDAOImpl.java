package com.game.fifa.dao.FO4commonDAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.game.fifa.vo.FO4commonVO;

@Repository
public class FO4commonDAOImpl implements FO4commonDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String mapperNamespace = "logMapper.";//해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다

	@Override
	public void insertSearchLog(FO4commonVO commonVO) {
		sqlSession.insert(mapperNamespace + "insertSearchLog", commonVO);
	}
}