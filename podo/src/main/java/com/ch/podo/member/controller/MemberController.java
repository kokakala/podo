
package com.ch.podo.member.controller;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.common.PodoRenamePolicy;
import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.service.MemberService;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.member.model.vo.Pay;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private FilmService filmService;
	@Autowired
	private LikeService likeService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// @CookieValue(value="storeIdCookie", required = false) Cookie storeIdCookie
	@RequestMapping("login.do")
	public String loginMember(Member mem, HttpSession session, ModelAndView mv,
																	boolean rememberMe, HttpServletResponse response, HttpServletRequest request) {
		
		Member loginUser = memberService.selectLoginMember(mem);
		// logger.info("loginUser : " + loginUser);
		// logger.info("rememberMe : " + rememberMe);
		
		if (loginUser != null && bcryptPasswordEncoder.matches(mem.getPwd(), loginUser.getPwd())) {
			if (rememberMe == true) {
				Cookie storeEmailCookie = new Cookie("email", mem.getEmail());
				Cookie storePwdCookie = new Cookie("pwd", mem.getPwd());
				storeEmailCookie.setMaxAge(60 * 60 * 24 * 7);
        storePwdCookie.setMaxAge(60 * 60 * 24 * 7);
        response.addCookie(storeEmailCookie);
        response.addCookie(storePwdCookie);
			} else {
				Cookie[] cookies = request.getCookies();
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("email") || cookies[i].getName().equals("pwd")) {
						// logger.info("cookies[" + i + "].name : " + cookies[i].getName());
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
			}
			session.setAttribute("loginUser", loginUser);
		} else {
			session.setAttribute("msg", "아이디와 비밀번호를 확인해주세요!");
		}
		return "redirect:" + request.getHeader("Referer");
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}
	
	@RequestMapping("insertFormMember.do")
	public String insertForm() {
		return "member/memberInsertForm";
	}
	
	@RequestMapping("insertMember.do")
	public String insertMember(Member mem, HttpServletRequest request, Model model,
							 @RequestParam(value="uploadFile", required=false) MultipartFile file) {
		
		if(!file.getOriginalFilename().equals("")) {	// 프로필 사진 등록하는 경우
			String renameFileName = PodoRenamePolicy.rename(file, request, "/memberProfileImage");
			mem.setImage(renameFileName);
		} else {
			mem.setImage("podoImage.png");
		}
		
		String encPwd = bcryptPasswordEncoder.encode(mem.getPwd());
		mem.setPwd(encPwd);
		
		int result = memberService.insertMember(mem);
		
		if(result > 0) {	// 회원가입 성공
			return "redirect:home.do";
		}else {
			model.addAttribute("msg", "회원가입 실패");
			return "redirect:login.do";
		}
	}
	
	@ResponseBody
	@RequestMapping("idCheck.do")
	public String idChechk(String id) {
		int result = memberService.idCheck(id);
		
		if(result > 0) {	// 아이디 존재, 사용불가
			return "fail";
		}else { // 사용가능
			return "success";
		}
	}
	
	@ResponseBody
	@RequestMapping("nickCheck.do")
	public String nickCheck(String nick) {
		int result = memberService.nickCheck(nick);
		
		if(result > 0) {	// 닉네임 존재, 사용불가
			return "fail";
		}else {	// 사용가능
			return "success";
		}
	}
	
	@RequestMapping("myPage.do")
	public ModelAndView myPage(HttpSession session, ModelAndView mv, String id, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int reviewListCount = reviewService.myPageReviewListCount(id);
		PageInfo pi = Pagination.getPageInfo(currentPage, reviewListCount);
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id,pi);
		
		session.setAttribute("reviewListCount", reviewListCount);
		mv.addObject("review", reviewList).addObject("reviewCount", reviewListCount).addObject("reviewPi", pi).addObject("reviewCount", reviewListCount).setViewName("member/myPage");
		
		return mv;
	}
	
	@RequestMapping("updateMember.do")
	public ModelAndView updateMember(Member mem, HttpSession session, ModelAndView mv, HttpServletRequest request,
									@RequestParam(value="uploadFile", required=false) MultipartFile file) {
		
		// 정보수정만 한 경우
		if(mem.getUpdatePwd().equals("")) {
			
			if(!file.getOriginalFilename().equals("")) {
				String renameFileName = PodoRenamePolicy.rename(file, request, "/memberProfileImage");
				mem.setImage(renameFileName);
			}else {
				mem.setImage(mem.getImage());
			}
			
		  // 비밀번호만 변경 한 경우
		} else {	// 패스워드 변경을 하면 암호화 된 패스워드를 pwd에 대입
			String encPwd = bcryptPasswordEncoder.encode(mem.getUpdatePwd());
			mem.setPwd(encPwd);
		}	// 정보수정만 한 경우 updatePwd는 null
		
		int result = memberService.updateMember(mem);
		mem.setStatus("Y");
		
		if(result > 0) {	// 업데이트 성공
			session.setAttribute("loginUser", mem);
			mv.addObject("msg", "회원정보 수정 성공").setViewName("redirect:myPage.do?id="+mem.getId());
		}else {
			mv.addObject("msg", "회원정보 수정 실패").setViewName("member/mypage");
		}
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("originPwdCheck.do")
	public String originPwdCheck(String originPwd, String email, String pwd, Member mem) {
		
		// 비밀번호 암호문 비교를 위해 login객체 재 조회
		mem.setEmail(email);
		Member loginUser = memberService.selectLoginMember(mem);
		
		if (loginUser != null && bcryptPasswordEncoder.matches(originPwd, loginUser.getPwd())) {	// 비밀번호 일치
			return "success";
		}else {
			return "fail";
		}
	}
	
	
	
	// 관리자 회원 리스트 조회
	@RequestMapping("mlist.do")
	public ModelAndView memberList(ModelAndView mv, 
								  @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		ArrayList<Member> list = memberService.selectMemberList();
		
		mv.addObject("list", list)
		  .setViewName("admin/memberListView");
		
		return mv;
	}	
	
	// 관리자 블랙 리스트 조회
	@RequestMapping("blackList.do")
	public ModelAndView blackList(ModelAndView mv, 
								  @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		ArrayList<Member> list = memberService.selectBlackList();
		
		mv.addObject("list", list)
		  .setViewName("admin/blackListView");
		
		return mv;
	}
	
	
	@RequestMapping("userPage.do")
	public ModelAndView userPage(HttpSession session, ModelAndView mv, String loginUserId, String userId, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		// loginUserId = 로그인 한 회원 , userId = 유저페이지 조회할 유저
		Member userPageMem = memberService.selectUserPageMem(userId); // 유저페이지 조회 될 해당 유저 객체
		int reviewListCount = reviewService.myPageReviewListCount(userId);	
		Like likeUser = likeService.selectLikeUser(userId,loginUserId);	// 유저페이지 조회 시 라이크 여부
		PageInfo pi = Pagination.getPageInfo(currentPage, reviewListCount);
		
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(userId,pi);
		
		session.setAttribute("reviewListCount", reviewListCount);
		session.setAttribute("userPageMem", userPageMem);
		mv.addObject("likeUser", likeUser).addObject("review", reviewList).addObject("reviewCount", reviewListCount).addObject("reviewPi", pi).addObject("reviewCount", reviewListCount).setViewName("member/userPage");
		return mv;
	}
	
	@RequestMapping("premium.do")
	public String goToPremiumPage() {
		return "member/premium";
	}
	
	@ResponseBody
	@RequestMapping("pay.do")
	public int pay(Pay pay) {
		log.info("payment info : " + pay);
		return memberService.insertPaymentInfo(pay);
	}
	
	@RequestMapping("exit.do")
	public ModelAndView exit(String id, ModelAndView mv, HttpSession session) {
		int result = memberService.exit(id);
		
		if(result > 0) {
			session.removeAttribute("loginUser");
			mv.setViewName("member/myPage");
		}else {
			mv.addObject("msg", "탈퇴실패").setViewName("member/myPage");
		}
		return mv;
	}
}
