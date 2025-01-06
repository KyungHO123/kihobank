package kr.jkh.khbank.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.jkh.khbank.model.dto.LoginDTO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.TransactionVO;
import kr.jkh.khbank.model.vo.logVO;
import kr.jkh.khbank.service.AccountService;
import kr.jkh.khbank.service.DepositService;
import kr.jkh.khbank.service.LoanService;
import kr.jkh.khbank.service.MemberService;

@Controller
public class HomeController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private LoanService loanService;
	@Autowired
	private DepositService depositService;

	@GetMapping("/")
	public String home(Locale locale, Model model, HttpSession session) {
		List<LoanVO> loanList = loanService.getLoanList();
		List<DepositVO> depositList = depositService.getDepositList();
		
		model.addAttribute("depositList",depositList);
		model.addAttribute("loanList",loanList);
		
		return "home";
	}

	@GetMapping("/member/login")
	public String login(Locale locale, Model model) {
		model.addAttribute("title", "기호은행 - 로그인");
		return "/member/login";
	}

	@PostMapping("/member/login")
	public String loginPost(Locale locale, HttpSession session, Model model, LoginDTO loginDTO,
			HttpServletRequest request) {
		MemberVO user = memberService.login(loginDTO);
		if (user.getMeMsNum() == 2 || user.getMeMsNum() == 3) {
			model.addAttribute("msg", "정지 혹은 탈퇴한 계정입니다.");
			model.addAttribute("url", "/");
			return "message";
		}

		if (user != null) {

			logVO log = new logVO();
			log.setLogMeID(user.getMeID());
			String ip = request.getHeader("X-Forwarded-For");
			if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			log.setLogIP(ip);
			try {
				memberService.insertLog(log);
			} catch (Exception e) {
				System.out.println(e + "에러났다");
			}
			session.setAttribute("member", user);
			model.addAttribute("msg", "로그인 했습니다.");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "아이디혹은 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "/member/login");
		}
		return "message";
	}

	@GetMapping("/member/signup")
	public String signup(Locale locale, Model model) {
		model.addAttribute("title", "기호은행 - 회원가입");
		return "/member/signup";
	}

	@PostMapping("/member/signup")
	public String signupPost(Locale locale, Model model, MemberVO memberVO) {
		if (memberService.memberSignup(memberVO)) {
			model.addAttribute("msg", "회원가입에 성공 했습니다.");
			model.addAttribute("url", "/member/successPage");
		} else {
			model.addAttribute("msg", "회원가입에 실패 했습니다.");
			model.addAttribute("url", "/member/signup");
		}
		return "message";
	}

	@GetMapping("/member/successPage")
	public String signupSuccess(Locale locale, Model model) {
		model.addAttribute("title", "기호은행 - 회원가입성공");

		return "/member/successPage";
	}

	@GetMapping("/logout")
	public String logout(Locale locale, Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		session.removeAttribute("member");
		memberService.logout(member.getMeID());
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("url", "/");
		return "message";
	}

	@GetMapping("/member/mypage")
	public String mypage(Locale locale, Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		MemberVO user = memberService.getMemberInfo(member);
		if (user == null) {
			model.addAttribute("msg", "회원 정보를 가져올 수 없습니다.");
			model.addAttribute("url", "/member/login");
			return "message";
		}
		AccountVO ac = accountService.getMembetAccount(member.getMeID());
		if (ac != null) {
			int balance = (int) ac.getAcBalance();
			ac.setAcBalance(balance);
			model.addAttribute("account", ac);
			model.addAttribute("member", user);

			return "/member/mypage";
		}

		model.addAttribute("account", ac);
		model.addAttribute("member", user);

		return "/member/mypage";
	}

	@GetMapping("/member/update")
	public String update(Locale locale, Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		MemberVO user = memberService.getMemberInfo(member);
		model.addAttribute("member", user);

		return "/member/update";
	}

	@PostMapping("/member/update")
	public String updatePost(Locale locale, Model model, HttpSession session, MemberVO member) {
		MemberVO user = (MemberVO) session.getAttribute("member");

		if (memberService.updateMemberInfo(member, user)) {
			model.addAttribute("msg", "수정 완료 되었습니다.");
			model.addAttribute("url", "/member/mypage");
		} else {
			model.addAttribute("msg", "수정 실패 했습니다.");
			model.addAttribute("url", "/member/update");
		}
		return "message";
	}

	@PostMapping("/member/delete")
	public String deletePost(Locale locale, Model model, HttpSession session, MemberVO member) {
		MemberVO user = (MemberVO) session.getAttribute("member");

		if (memberService.deleteMember(user)) {
			model.addAttribute("msg", "회원 탈퇴 되었습니다.");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "회원 탈퇴에 실패 했습니다.");
			model.addAttribute("url", "/member/mypage");
		}
		return "message";
	}

	@GetMapping("/member/asset")
	public String asset(Locale locale, Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		AccountVO ac = accountService.getMembetAccount(member.getMeID());
		LoanSubscriptionVO laSub = loanService.getMemberLoanSub(member.getMeID());
		DepositSubscriptionVO deSub = depositService.getMemberDepositSub(member.getMeID());
		Date depositMaturityDate = null;
		Date loanMaturityDate = null;
		if(deSub.getDsSubDate() != null) {
			depositMaturityDate = depositMaturityDate(session);
		}
		if (laSub.getLsOk() != null) {
			loanMaturityDate = loanMaturityDate(session);
		}
		if (ac != null) {
			int balance = (int) ac.getAcBalance();
			ac.setAcBalance(balance);
		}
		
		model.addAttribute("deSub", deSub);
		model.addAttribute("laSub", laSub);
		model.addAttribute("account", ac);
		model.addAttribute("maturityDate", depositMaturityDate);
		model.addAttribute("loanMaturityDate", loanMaturityDate);

		return "/member/asset";
	}
	@ResponseBody
	@PostMapping("/searchAccount")
	public Map<String, Object> searchAccount(@RequestBody TransactionVO transaction) {
		Map<String, Object> map = new HashMap<String, Object>();
		//입력받은 계좌번호를 넘겨주면서 일치하는 계좌번호를 찾음
		AccountVO meAc = accountService.getAccount(transaction.getTrAcNum());
		System.out.println(meAc +"검색 메소드");
		if(meAc == null) {
			map.put("error", "계좌번호를 찾을 수 없습니다.");
			return map;
		}
		
		map.put("meAc", meAc);
		return map;
	}
	@ResponseBody
	@PostMapping("/transaction")
	public Map<String, Object> transaction(@RequestBody TransactionVO transaction,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = (MemberVO)session.getAttribute("member");
		AccountVO myAccount = accountService.getMembetAccount(member.getMeID());
		AccountVO receiverAccount = accountService.getMyAccount(transaction.getTrAcHeadNum());
		if(myAccount.getAcBalance() < transaction.getTrBalance()) {
			map.put("error", "잔액이 부족합니다.");
			return map;
		}
		boolean res = accountService.transaction(transaction,myAccount,receiverAccount);
		map.put("account", myAccount);
		map.put("res", res);
		return map;
	}
	
	
	

	public Date depositMaturityDate(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		DepositSubscriptionVO deSub = depositService.getMemberDepositSub(member.getMeID());
		MaturityDateVO md = depositService.getMaturity(deSub.getDsMdNum());
		int year = md.getMdDate(); // 연도 추가 값
		Date subDate = deSub.getDsSubDate();

		LocalDate localSubDate = subDate.toLocalDate();
		// 연도를 추가
		LocalDate localMaturityDate = localSubDate.plusYears(year);

		// LocalDate -> java.sql.Date 변환
		Date maturityDate = Date.valueOf(localMaturityDate);
		if (deSub.getDsMaturity() == null) {
			depositService.UpdateDepositMaturity(deSub.getDsNum(), maturityDate);
		}
		return maturityDate;

	}

	public Date loanMaturityDate(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		LoanSubscriptionVO laSub = loanService.getMemberLoanSub(member.getMeID());
		MaturityDateVO md = depositService.getMaturity(laSub.getLsMdNum());
		int year = md.getMdDate(); // 연도 추가 값
		Date subDate = laSub.getLsOk();

		LocalDate localSubDate = subDate.toLocalDate();
		// 연도를 추가
		LocalDate localMaturityDate = localSubDate.plusYears(year);

		// LocalDate -> java.sql.Date 변환
		Date maturityDate = Date.valueOf(localMaturityDate);
		if (laSub.getLsMaturity() == null) {
			loanService.UpdateLoanMaturity(laSub.getLsNum(), maturityDate);
		}
		return maturityDate;

	}
}
