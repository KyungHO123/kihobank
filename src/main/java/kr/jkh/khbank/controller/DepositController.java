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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.pagination.Criteria;
import kr.jkh.khbank.pagination.PageMaker;
import kr.jkh.khbank.service.AdminService;
import kr.jkh.khbank.service.DepositService;

@Controller
public class DepositController {
	@Autowired
	private DepositService depositService;
	@Autowired
	private AdminService adminService;

	@GetMapping("/deposit/list")
	public String agree(Locale locale, Model model, HttpSession session) {
		model.addAttribute("title", "기호은행 - 저축상품 리스트");
		

		return "/deposit/list";
	}
	@ResponseBody
	@PostMapping("/deposit/ajaxList")
	public Map<String, Object> ajaxList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		ArrayList<DepositVO> depositList = adminService.getDepositList(cri);
		for(DepositVO dt : depositList) {
			DepositTypeVO dp = adminService.getDepositType(dt.getDpDtNum());
			dt.setDepositType(dp);
		}
		
		int totalCount = adminService.getDpTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("depositList", depositList);
		map.put("pm", pm);
		return map;
	}
	
	/*@ResponseBody
	@GetMapping("/loan/getLoanNum")
	public LoanVO getLoanNum(@RequestParam("laNum")  int laNum) {
		return adminService.getLoanNum(laNum);
	}*/
	
	/*@GetMapping("/loan/app")
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
	}*/
	
	/*@PostMapping("/loan/apply")
	public String apply(Model model,LoanSubscriptionVO loanSub) {
		boolean res = loanService.applyLoanSub(loanSub);
		if(res) {
			model.addAttribute("msg","대출 신청이 완료 되었습니다. 관리자 승인 후 입금 됩니다.");
			model.addAttribute("url","/loan/list");
		}else {
			model.addAttribute("msg","대출 신청에 실패 하였습니다.");
			model.addAttribute("url","/loan/app");
		}
		
		return "message";
	}*/

}
