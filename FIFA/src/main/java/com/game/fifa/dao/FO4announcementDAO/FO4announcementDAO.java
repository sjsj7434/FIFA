package com.game.fifa.dao.FO4announcementDAO;

import java.util.List;

import com.game.fifa.vo.FO4announcementVO;

public interface FO4announcementDAO {
	public void insertAnnonucement(FO4announcementVO announcementVO);
	public List<FO4announcementVO> selectAnnonucementList(FO4announcementVO announcementVO);
	public int selectCountAnnouncementList();
}
