package kr.jkh.khbank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.RepayMentVO;
import kr.jkh.khbank.pagination.Criteria;
import kr.jkh.khbank.pagination.PageMaker;
import kr.jkh.khbank.service.AdminService;
import kr.jkh.khbank.service.LoanService;

@Controller
public class LoanController {
	@Autowired
	private LoanService loanService;
	@Autowired
	private AdminService adminService;

	@GetMapping("/loan/list")
	public String agree(Locale locale, Model model, HttpSession session) {
		model.addAttribute("title", "기호은행 - 대출 리스트");
		/*
		 * List<LoanVO> loan = loanService.getloanList();
		 * model.addAttribute("loan",loan);
		 */

		return "/loan/list";
	}
	
	@ResponseBody
	@PostMapping("/loan/ajaxList")
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
	@GetMapping("/loan/getLoanNum")
	public LoanVO getLoanNum(@RequestParam("laNum")  int laNum) {
		return adminService.getLoanNum(laNum);
	}
	
	@GetMapping("/loan/app")
	public String app(Locale locale, Model model,
			HttpSession session,@RequestParam("laNum") int laNum) {
		model.addAttribute("title", "기호은행 - 대출 신청");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		LoanVO loan = loanService.getLoan(laNum);
		List<MaturityDateVO> date = loanService.getDateList();
		List<RepayMentVO> repayMent = loanService.getRepayMentList();
		
		
		model.addAttribute("date",date);
		model.addAttribute("repayMent",repayMent);
		model.addAttribute("loan",loan);
		return "/loan/app";
	}
	@PostMapping("/loan/apply")
	public String apply(Model model,LoanSubscriptionVO loanSub) {
		System.out.println(loanSub + "여기@@@@@@@@@@@@@@@");
		boolean res = loanService.applyLoanSub(loanSub);
		if(res) {
			model.addAttribute("msg","대출 신청이 완료 되었습니다. 관리자 승인 후 입금 됩니다.");
			model.addAttribute("url","/loan/list");
		}else {
			model.addAttribute("msg","대출 신청에 실패 하였습니다.");
			model.addAttribute("url","/loan/app");
		}
		
		return "message";
	}
	
}
