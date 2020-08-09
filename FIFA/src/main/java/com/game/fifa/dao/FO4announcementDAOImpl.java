package com.game.fifa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.game.fifa.vo.FO4announcementVO;

@Repository
public class FO4announcementDAOImpl implements FO4announcementDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String mapperNamespace = "playerMapper.";//해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다

	@Override
	public void insertAnnonucement(FO4announcementVO announcementVO) {
		sqlSession.insert(mapperNamespace + "insertAnnouncementList", announcementVO);
	}

	@Override
	public List<FO4announcementVO> selectAnnonucementList(FO4announcementVO announcementVO) {
		return sqlSession.selectList(mapperNamespace + "selectAnnouncementList", announcementVO);
	}

}