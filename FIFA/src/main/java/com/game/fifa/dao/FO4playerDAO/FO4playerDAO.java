package com.game.fifa.dao.FO4playerDAO;

import java.util.List;

import com.game.fifa.vo.FO4playerVO;

public interface FO4playerDAO {
	
	public List<FO4playerVO> getPlayer(String playerName);
	public FO4playerVO getPlayerByspid(String spid);
}
