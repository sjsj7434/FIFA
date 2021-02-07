package com.game.fifa.service.FO4commonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.fifa.dao.FO4commonDAO.FO4commonDAO;
import com.game.fifa.vo.FO4commonVO;

@Service
public class FO4commonServiceImpl implements FO4commonService{

	@Autowired
	private FO4commonDAO commonDAO;

	@Override
	public void insertSearchLog(FO4commonVO commonVO) {
		commonDAO.insertSearchLog(commonVO);
	}
}
