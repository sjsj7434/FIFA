package com.game.fifa.service.FO4visitorSessionService;

import com.game.fifa.vo.FO4visitorSessionVO;

public interface FO4visitorSessionService {
	public void insertVisitorSession(FO4visitorSessionVO visitorSessionVO);
	public int countTodayVisitors();
	public int countAllVisitors();
}
