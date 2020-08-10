package com.game.fifa.service.FO4playerService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.fifa.dao.FO4playerDAO.FO4playerDAO;
import com.game.fifa.vo.FO4playerVO;

@Service
public class FO4playerServiceImpl implements FO4playerService{
	
	@Autowired
	private FO4playerDAO playerDAO;
	
	@Override
	public List<FO4playerVO> getPlayer(String playerName) {
		return playerDAO.getPlayer(playerName);
	}

	@Override
	public FO4playerVO getPlayerByspid(String spid) {
		return playerDAO.getPlayerByspid(spid);
	}
}