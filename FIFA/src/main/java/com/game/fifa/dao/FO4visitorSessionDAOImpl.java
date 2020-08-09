package com.game.fifa.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.game.fifa.vo.FO4visitorSessionVO;

@Repository
public class FO4visitorSessionDAOImpl implements FO4visitorSessionDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String mapperNamespace = "playerMapper.";//해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다

	@Override
	public void insertVisitorSession(FO4visitorSessionVO visitorSessionVO) {
		sqlSession.insert(mapperNamespace + "insertVisitorSession", visitorSessionVO);
	}

	@Override
	public int countTodayVisitors() {
		return sqlSession.selectOne(mapperNamespace + "countTodayVisitors");
	}

	@Override
	public int countAllVisitors() {
		return sqlSession.selectOne(mapperNamespace + "countAllVisitors");
	}

}