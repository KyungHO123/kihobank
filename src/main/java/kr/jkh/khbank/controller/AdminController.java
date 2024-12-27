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

import kr.jkh.khbank.model.vo.LoanVO;
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
		System.out.println("컨트롤러"+loan);
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
		System.out.println("컨트롤러"+loan);
		map.put("res", res);
		return map;
	}
}
