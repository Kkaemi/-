package community.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import community.bean.CommunityBoardDTO;
import community.bean.CommunityNoticeDTO;
import community.service.CommunityMainService;
import member.bean.MemberDTO;

@Controller
@RequestMapping(value="community")
public class CommunityMainController {
	@Autowired
	private CommunityMainService cMainService;

	// 커뮤니티 메인
	@RequestMapping(value = "communityMain", method = RequestMethod.GET)
	public String communityNoticeList() {
		return "/jsp/community/communityMain/communityMain";
	}
	
	//커뮤니티 자유게시판 목록
	@RequestMapping(value = "communityMainGetBoard", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView communityMainGetBoard(HttpSession session, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		List<CommunityBoardDTO> list = cMainService.getCBoardList();
		//조회수
		if(session.getAttribute("memberDTO") != null) {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
			String nickname = memberDTO.getNickname();
			
			if(nickname != null && !nickname.equals("관리자")) {
				Cookie cookie = new Cookie("hit", "ok");
				cookie.setMaxAge(30*60);//30분
				cookie.setPath("/");
				response.addCookie(cookie); //클라이언트에 보내기
			}
		}
		mav.addObject("bList", list);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//커뮤니티 공지사항 목록
	@RequestMapping(value = "communityMainGetNotice", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView communityMainGetNotice(HttpSession session, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		List<CommunityNoticeDTO> list = cMainService.getCNoticeList();

		//조회수
		if(session.getAttribute("memberDTO") != null) {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
			String nickname = memberDTO.getNickname();
			
			if(nickname != null && !nickname.equals("관리자")) {
				Cookie cookie = new Cookie("hit", "ok");
				cookie.setMaxAge(30*60);//30분
				cookie.setPath("/");
				response.addCookie(cookie); //클라이언트에 보내기
			}
		}
		
		mav.addObject("nList", list);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
}
