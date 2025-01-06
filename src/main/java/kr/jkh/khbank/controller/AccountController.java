package kr.jkh.khbank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.TransactionVO;
import kr.jkh.khbank.model.vo.logVO;
import kr.jkh.khbank.pagination.Criteria;
import kr.jkh.khbank.pagination.PageMaker;
import kr.jkh.khbank.service.AccountService;

@Controller
public class AccountController {
	@Autowired
	private AccountService accountService;

	@GetMapping("/account/agreeAccount")
	public String agree(Locale locale, Model model,HttpSession session) {
		model.addAttribute("title","기호은행 - 계좌개설");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인 후 이용해주세요.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		
		
		return "/account/agreeAccount";
	}
	@GetMapping("/account/addAccount")
	public String add(Locale locale, Model model,HttpSession session,AccountVO account,AccountLimitVO limit) {
		model.addAttribute("title","기호은행 - 계좌개설");
		ArrayList<AccountLimitVO> acl = accountService.getAccountLimit();
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인 후 이용해주세요.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		model.addAttribute("acl",acl);
			
		
		return "/account/addAccount";
	}
	@PostMapping("/account/addAccount")
	public String addPost(Locale locale, Model model,HttpSession session,AccountVO account,AccountLimitVO limit) {
		model.addAttribute("title","기호은행 - 계좌개설");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인 후 이용해주세요.");
			model.addAttribute("url","/member/login");
		}
		if(accountService.createAccount(account,member.getMeID())) {
			model.addAttribute("msg","계좌를 성공적으로 개설하였습니다");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","계좌 개설에 실패했습니다 다시 시도해주세요.");
			model.addAttribute("url","/account/addAccount");
		}
		
		return "message";
	}
	
	@GetMapping("/account/accountDetail")
	public String accountDetail(Locale locale, Model model,HttpSession session) {
		model.addAttribute("title","기호은행 - 계좌개설");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인 후 이용해주세요.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		AccountVO ac = accountService.getMembetAccount(member.getMeID());
		int balance = (int)ac.getAcBalance();
		ac.setAcBalance(balance);
		AccountLimitVO acl = accountService.getLimit(ac.getAcAclNum());
		model.addAttribute("acl",acl);
		model.addAttribute("account",ac);
		
		return "/account/accountDetail";
	}
	@PostMapping("/apply")
	public ResponseEntity<String> apply(){
		accountService.applyInterest();
		return ResponseEntity.ok("이자 적용 완료");
	}
	@ResponseBody
	@PostMapping("/myTransaction")
	public Map<String, Object> myTransaction(@RequestBody Criteria cri,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = (MemberVO)session.getAttribute("member");
		AccountVO ac = accountService.getMembetAccount(member.getMeID());
		cri.setPerPageNum(10);
		List<TransactionVO> transaction = accountService.selectTrList(cri,ac);
		int totalCount = accountService.getTrTotalCount(cri,ac);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("transaction", transaction);
		map.put("pm", pm);
		
		
		return map;
	}
}
