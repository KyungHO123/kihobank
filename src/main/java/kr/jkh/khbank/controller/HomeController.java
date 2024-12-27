package kr.jkh.khbank.controller;


import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.jkh.khbank.model.dto.LoginDTO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.logVO;
import kr.jkh.khbank.service.AccountService;
import kr.jkh.khbank.service.MemberService;

 

@Controller
public class HomeController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private AccountService accountService;
	
	@GetMapping("/")
	public String home(Locale locale, Model model,HttpSession session) {
		return "home";
	}
	@GetMapping("/member/login")
	public String login(Locale locale, Model model) {
		model.addAttribute("title","기호은행 - 로그인");
		return "/member/login";
	}
	
	@PostMapping("/member/login")
	public String loginPost(Locale locale,HttpSession session,Model model,LoginDTO loginDTO,HttpServletRequest request) {
		MemberVO user = memberService.login(loginDTO);
		if(user.getMeMsNum() == 2 || user.getMeMsNum() == 3) {
			model.addAttribute("msg","정지 혹은 탈퇴한 계정입니다.");
			model.addAttribute("url","/");
			return "message";
		}
			
		if(user != null) {
			
			logVO log = new logVO();
			log.setLogMeID(user.getMeID());
			String ip = request.getHeader("X-Forwarded-For");
			if(ip ==null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			log.setLogIP(ip);
			try {
				memberService.insertLog(log);
			} catch (Exception e) {
				System.out.println(e + "에러났다");
			}
			session.setAttribute("member", user);
			model.addAttribute("msg","로그인 했습니다.");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","아이디혹은 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url","/member/login");
		}
		return "message";
	}
	
	@GetMapping("/member/signup")
	public String signup(Locale locale, Model model) {
		model.addAttribute("title","기호은행 - 회원가입");
		return "/member/signup";
	}
	@PostMapping("/member/signup")
	public String signupPost( Locale locale, Model model,MemberVO memberVO) {
		if(memberService.memberSignup(memberVO)) {
			model.addAttribute("msg","회원가입에 성공 했습니다.");
			model.addAttribute("url","/member/successPage");
		}else {
			model.addAttribute("msg","회원가입에 실패 했습니다.");
			model.addAttribute("url","/member/signup");
		}
		return "message";
	}
	@GetMapping("/member/successPage")
	public String signupSuccess(Locale locale, Model model) {
		model.addAttribute("title","기호은행 - 회원가입성공");
		
		return "/member/successPage";
	}
	@GetMapping("/logout")
	public String logout(Locale locale, Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		session.removeAttribute("member");
		memberService.logout(member.getMeID());
		model.addAttribute("msg","로그아웃 되었습니다.");
		model.addAttribute("url","/");
		return "message";
	}
	
	@GetMapping("/member/mypage")
	public String mypage(Locale locale, Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		MemberVO user = memberService.getMemberInfo(member);
		if(user == null) {
			model.addAttribute("msg","회원 정보를 가져올 수 없습니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		AccountVO ac = accountService.getMembetAccount(member.getMeID());
		int balance = (int)ac.getAcBalance();
		ac.setAcBalance(balance);
		
		
		model.addAttribute("account",ac);
		model.addAttribute("member",user);
		
		return "/member/mypage";
	}
	
	@GetMapping("/member/update")
	public String update(Locale locale, Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		MemberVO user = memberService.getMemberInfo(member);
		model.addAttribute("member",user);
		
		return "/member/update";
	}
	
	@PostMapping("/member/update")
	public String updatePost(Locale locale, Model model,HttpSession session,MemberVO member) {
		MemberVO user = (MemberVO)session.getAttribute("member");
		
		if(memberService.updateMemberInfo(member,user)) {
			model.addAttribute("msg","수정 완료 되었습니다.");
			model.addAttribute("url","/member/mypage");
		}else {
			model.addAttribute("msg","수정 실패 했습니다.");
			model.addAttribute("url","/member/update");
		}
		return "message";
	}
	@PostMapping("/member/delete")
	public String deletePost(Locale locale, Model model,HttpSession session,MemberVO member) {
		MemberVO user = (MemberVO)session.getAttribute("member");
		
		if(memberService.deleteMember(user)) {
			model.addAttribute("msg","회원 탈퇴 되었습니다.");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","회원 탈퇴에 실패 했습니다.");
			model.addAttribute("url","/member/mypage");
		}
		return "message";
	}
	
}
