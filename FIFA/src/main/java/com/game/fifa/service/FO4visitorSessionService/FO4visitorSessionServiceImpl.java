package com.game.fifa.service.FO4visitorSessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.fifa.dao.FO4visitorSessionDAO.FO4visitorSessionDAO;
import com.game.fifa.vo.FO4visitorSessionVO;

@Service
public class FO4visitorSessionServiceImpl implements FO4visitorSessionService{

	@Autowired
	private FO4visitorSessionDAO visitorSessionDAO;

	@Override
	public void insertVisitorSession(FO4visitorSessionVO visitorSessionVO) {
		visitorSessionDAO.insertVisitorSession(visitorSessionVO);
	}

	@Override
	public int countTodayVisitors() {
		return visitorSessionDAO.countTodayVisitors();
	}

	@Override
	public int countAllVisitors() {
		return visitorSessionDAO.countAllVisitors();
	}

}
