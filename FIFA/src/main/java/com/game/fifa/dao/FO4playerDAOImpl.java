package com.game.fifa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.game.fifa.vo.FO4playerVO;

@Repository
public class FO4playerDAOImpl implements FO4playerDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String mapperNamespace = "playerMapper.";//해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다

	@Override
	public List<FO4playerVO> getPlayer(String playerName) {
		return sqlSession.selectList(mapperNamespace + "selectPlayerByName", playerName);
	}

	@Override
	public FO4playerVO getPlayerByspid(String spid) {
		return sqlSession.selectOne(mapperNamespace + "selectPlayerBySpid", spid);
	}
}
