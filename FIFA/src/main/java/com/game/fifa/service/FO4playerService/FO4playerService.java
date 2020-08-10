package com.game.fifa.service.FO4playerService;

import java.util.List;

import com.game.fifa.vo.FO4playerVO;

public interface FO4playerService {//Service의 역할은 Dao가 DB에서 받아온 데이터를 전달받아 가공하는 것
	public List<FO4playerVO> getPlayer(String playerName);
	public FO4playerVO getPlayerByspid(String spid);
}
