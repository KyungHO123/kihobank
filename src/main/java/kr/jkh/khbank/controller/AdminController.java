package kr.jkh.khbank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MemberAuthorityVO;
import kr.jkh.khbank.model.vo.MemberStateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.pagination.Criteria;
import kr.jkh.khbank.pagination.PageMaker;
import kr.jkh.khbank.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;

	
	@GetMapping("/admin/main")
	public String agree(Locale locale, Model model,HttpSession session) {
		model.addAttribute("title","기호은행 - 관리자페이지");
//		MemberVO member = (MemberVO)session.getAttribute("member");
		
		
		
		return "/admin/main";
	}
	@GetMapping("/admin/loanProduct")
	public String loanProduct(Locale locale, Model model,HttpSession session,LoanVO loan) {
		model.addAttribute("title","기호은행 - 대출상품관리");
//		MemberVO member = (MemberVO)session.getAttribute("member");
		
		
		
		return "/admin/loanProduct";
	}
	@ResponseBody
	@PostMapping("/admin/loanAdd")
	public Map<String, Object> loanAdd(@RequestBody LoanVO loan, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		boolean res = adminService.addLoan(loan, user);
		
		map.put("res", res);
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/loanList")
	public Map<String, Object> loanList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		ArrayList<LoanVO> loanList = adminService.getLoanList(cri);
		int totalCount = adminService.getTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("loanList", loanList);
		map.put("pm", pm);
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/deleteLoan")
	public Map<String, Object> deleteLoan(@RequestParam("laNum") int laNum ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2) {
			return null;
		}
		boolean loan = adminService.deleteLoan(laNum);
		map.put("loan", loan);
		return map;
	}
	@ResponseBody
	@GetMapping("/admin/getLoanNum")
	public LoanVO getLoanNum(@RequestParam("laNum")  int laNum) {
		return adminService.getLoanNum(laNum);
	}
	
	@ResponseBody
	@PostMapping("/admin/loanUpdate")
	public Map<String, Object> loanUpdate(@RequestBody LoanVO loan ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2 ||user == null) {
			return null;
		}
		boolean res = adminService.loanUpdate(loan);
		map.put("res", res);
		return map;
	}
	
	@GetMapping("/admin/depositProduct")
	public String getDepositProduct(HttpSession session,Model model) {
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user == null || user.getMeMaNum() != 2) {
			model.addAttribute("msg","로그인 후 이용바랍니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		ArrayList<DepositTypeVO> type = adminService.getDepositTypeList();
		model.addAttribute("type",type);
		
		return "/admin/depositProduct";
	}
	@GetMapping("/admin/members")
	public String getMemberList(HttpSession session,Model model) {
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user == null || user.getMeMaNum() != 2) {
			model.addAttribute("msg","로그인 후 이용바랍니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		ArrayList<MemberVO> members = adminService.getMemberList();
		for(MemberVO me : members) {
			if(me.getMeMaNum() == 1) {
				model.addAttribute("meSize",members.size());
			}
		}
		
		
		model.addAttribute("members",members);
		
		
		return "/admin/members";
	}
	
	@ResponseBody
	@PostMapping("/admin/memberUpdate")
	public Map<String, Object> memberUpdate(@RequestBody MemberVO member ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2 ||user == null) {
			return null;
		}
		boolean res = adminService.adminMemberUpdate(member);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/admin/memberList")
	public Map<String, Object> memberList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		ArrayList<MemberVO> memberList = adminService.getAjaxMemberList(cri);
		int totalCount = adminService.getTotalMemberCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		ArrayList<MemberStateVO> state = adminService.getMemberState();
		ArrayList<MemberAuthorityVO> authority = adminService.getMemberauthority();
		
		map.put("state",state);
		map.put("authority",authority);
		map.put("memberList", memberList);
		map.put("pm", pm);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/admin/depositAdd")
	public Map<String, Object> depositAdd(@RequestBody DepositVO deposit, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		boolean res = adminService.addDeposit(deposit, user);
		System.out.println(deposit);
		
		map.put("res", res);
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/depositList")
	public Map<String, Object> depositList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		ArrayList<DepositVO> depositList = adminService.getDepositList(cri);
		for(DepositVO deposit : depositList) {
			DepositTypeVO dt = adminService.getDepositType(deposit.getDpDtNum());
			deposit.setDepositType(dt);
		}
		int totalCount = adminService.getDpTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("depositList", depositList);
		map.put("pm", pm);
		return map;
	}
	
}
