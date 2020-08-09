package com.game.fifa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.fifa.dao.FO4announcementDAO;
import com.game.fifa.vo.FO4announcementVO;

@Service
public class FO4announcementServiceImpl implements FO4announcementService{

	@Autowired
	private FO4announcementDAO announcementDAO;

	@Override
	public void insertAnnouncement(FO4announcementVO announcementVO) {
		announcementDAO.insertAnnonucement(announcementVO);
	}

	@Override
	public List<FO4announcementVO> selectAnnouncementList(FO4announcementVO announcementVO) {
		return announcementDAO.selectAnnonucementList(announcementVO);
	}
	
}
