
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
	private LikeService likeService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping("login.do")
	public String loginMember(Member member, HttpSession session, ModelAndView mv,
														HttpServletResponse response, HttpServletRequest request) {
		Member loginUser = memberService.selectLoginMember(member);
		if (loginUser != null && bcryptPasswordEncoder.matches(member.getPassword(), loginUser.getPassword())) {
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
	
	@RequestMapping("signup.do")
	public String insertForm() {
		return "member/signupForm";
	}
	
	@RequestMapping("insertMember.do")
	public String insertMember(Member member, HttpServletRequest request, Model model,
							 @RequestParam(value="uploadFile", required=false) MultipartFile file) {
		
		log.info(member.toString());
		
//		if (!file.getOriginalFilename().equals("")) { // 프로필 사진 등록하는 경우
//			String renameFileName = PodoRenamePolicy.rename(file, request, "/memberProfileImage");
//			member.setImage(renameFileName);
//		} else {
//			member.setImage("podoImage.png");
//		}
		Boolean existsEmail = memberService.existsEmail(member.getEmail());
		log.info("existsEmail : {}", existsEmail);
		
		if (existsEmail) {
			request.getSession().setAttribute("msg", "이미 존재하는 이메일입니다.");
			return "redirect:home.do";
		}
		
		String encPassword = bcryptPasswordEncoder.encode(member.getPassword());
		member.setPassword(encPassword);
		
		int result = memberService.insertMember(member);

		if (result > 0) { // 회원가입 성공
			return "redirect:home.do";
		} else {
			model.addAttribute("msg", "회원가입 실패");
			return "redirect:login.do";
		}
	}

	@ResponseBody
	@RequestMapping("idCheck.do")
	public String idChechk(String id) {
		int result = memberService.idCheck(id);

		if (result > 0) { // 아이디 존재, 사용불가
			return "fail";
		} else { // 사용가능
			return "success";
		}
	}

	@ResponseBody
	@RequestMapping("nickCheck.do")
	public String nickCheck(String nick) {
		int result = memberService.nickCheck(nick);

		if (result > 0) { // 닉네임 존재, 사용불가
			return "fail";
		} else { // 사용가능
			return "success";
		}
	}

	@RequestMapping("mypage.do")
	public ModelAndView myPage(HttpSession session, ModelAndView mv, String id,
															@RequestParam(value="currentPage", defaultValue="1") String currentPage) {
		int reviewListCount = reviewService.myPageReviewListCount(id);
		PageInfo pi = Pagination.getPageInfo(Integer.parseInt(currentPage), reviewListCount);
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id, pi);
		
		session.setAttribute("reviewListCount", reviewListCount);
		mv.addObject("review", reviewList)
			.addObject("reviewCount", reviewListCount)
			.addObject("reviewPi", pi)
			.addObject("reviewCount", reviewListCount)
			.setViewName("member/myPage");
		
		return mv;
	}

	@RequestMapping("updateMember.do")
	public String updateMember(Member mem, HttpSession session, ModelAndView mv, HttpServletRequest request,
			@RequestParam(value = "uploadFile", required = false) MultipartFile file) {
		log.info("file : {}", file);
		// 정보수정만 한 경우
		if (mem.getNewPassword() == null || mem.getNewPassword().equals("")) {
			
			if (!file.getOriginalFilename().equals("")) {
				log.info("file is not null");
				String renameFileName = PodoRenamePolicy.rename(file, request, "/memberProfileImage");
				log.info("renameFilName : {}", renameFileName);
				mem.setImage(renameFileName);
			} else {
				mem.setImage(mem.getImage());
			}
			
			// 비밀번호만 변경할 경우
		} else { // 패스워드 변경을 하면 암호화 된 패스워드를 Password에 대입
			String encPassword = bcryptPasswordEncoder.encode(mem.getNewPassword());
			mem.setPassword(encPassword);
		} // 정보수정만 한 경우 updatePwd는 null

		
		log.info("mem : {}", mem);
		int result = memberService.updateMember(mem);
		mem.setStatus("Y");

		if (result > 0) { // 업데이트 성공
			session.setAttribute("loginUser", mem);
			session.setAttribute("msg", "성공적으로 변경되었습니다.");
			return "redirect:mypage.do?id=" + mem.getId();
		} else {
			session.setAttribute("msg", "변경하는 데 실패하였습니다. 관리자에게 문의해주세요.");
			return "member/mypage";
		}
	}
	
	@Deprecated
	@ResponseBody
	@RequestMapping("originPwdCheck.do")
	public String originPwdCheck(String originPwd, String email, String pwd, Member mem) {

		// 비밀번호 암호문 비교를 위해 login객체 재 조회
		mem.setEmail(email);
		Member loginUser = memberService.selectLoginMember(mem);

		if (loginUser != null && bcryptPasswordEncoder.matches(originPwd, loginUser.getPassword())) { // 비밀번호 일치
			return "success";
		} else {
			return "fail";
		}
	}

	// 관리자 회원 리스트 조회
	@RequestMapping("mlist.do")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		ArrayList<Member> list = memberService.selectMemberList();

		mv.addObject("list", list)
			.setViewName("admin/memberListView");

		return mv;
	}

	// 관리자 블랙 리스트 조회
	@RequestMapping("blackList.do")
	public ModelAndView blackList(ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

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
		Like likeUser = likeService.selectLikeUser(userId, loginUserId);	// 유저페이지 조회 시 라이크 여부
		
		PageInfo pi = Pagination.getPageInfo(currentPage, reviewListCount);
		
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(userId, pi);
		// log.info(reviewList.toString());
		session.setAttribute("reviewListCount", reviewListCount);
		session.setAttribute("userPageMem", userPageMem);
		
		mv.addObject("likeUser", likeUser)
			.addObject("review", reviewList)
			.addObject("reviewCount", reviewListCount)
			.addObject("reviewPi", pi)
			.addObject("reviewCount", reviewListCount)
			.setViewName("member/userPage");
		
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

		if (result > 0) {
			session.removeAttribute("loginUser");
			mv.setViewName("member/myPage");
		} else {
			mv.addObject("msg", "탈퇴실패").setViewName("member/myPage");
		}
		return mv;
	}
}
