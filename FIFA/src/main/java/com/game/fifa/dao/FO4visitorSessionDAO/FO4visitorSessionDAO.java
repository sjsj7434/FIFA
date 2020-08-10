package com.game.fifa.dao.FO4visitorSessionDAO;

import com.game.fifa.vo.FO4visitorSessionVO;

public interface FO4visitorSessionDAO {
	public void insertVisitorSession(FO4visitorSessionVO visitorSessionVO);
	public int countTodayVisitors();
	public int countAllVisitors();
}
