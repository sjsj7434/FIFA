package com.game.fifa.service.FO4announcementService;

import java.util.List;

import com.game.fifa.vo.FO4announcementVO;

public interface FO4announcementService {
	public void insertAnnouncement(FO4announcementVO announcementVO);
	public List<FO4announcementVO> selectAnnouncementList(FO4announcementVO announcementVO);
	public int selectCountAnnouncementList();
}
