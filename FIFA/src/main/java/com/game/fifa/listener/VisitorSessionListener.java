package com.game.fifa.listener;

import java.sql.Timestamp;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.game.fifa.dao.FO4visitorSessionDAO.FO4visitorSessionDAO;
import com.game.fifa.vo.FO4visitorSessionVO;

public class VisitorSessionListener implements HttpSessionListener{

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		HttpSession session = se.getSession();
        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());//등록되어있는 빈을 사용할수 있도록 설정해준다
        //HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();//request를 파라미터에 넣지 않고도 사용할수 있도록 설정
        
        FO4visitorSessionDAO visitorSessionDAO = (FO4visitorSessionDAO)wac.getBean("FO4visitorSessionDAOImpl");//root-context에 설정한 빈 이름
        FO4visitorSessionVO visitorSessionVO = new FO4visitorSessionVO();
        
		Timestamp timestampNow = new Timestamp(System.currentTimeMillis());
		
        visitorSessionVO.setSessionCreatedTime(timestampNow);
        visitorSessionVO.setVisitorIP(((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getRemoteAddr());//IP
        visitorSessionVO.setUser_agent(((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("User-Agent"));//브라우저 정보
        visitorSessionVO.setReferer(((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("referer"));//접속 전 사이트 정보
        visitorSessionDAO.insertVisitorSession(visitorSessionVO);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {

	}

}