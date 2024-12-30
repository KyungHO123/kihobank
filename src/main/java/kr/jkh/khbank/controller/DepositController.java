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

import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.RepayMentVO;
import kr.jkh.khbank.pagination.Criteria;
import kr.jkh.khbank.pagination.PageMaker;
import kr.jkh.khbank.service.AdminService;
import kr.jkh.khbank.service.DepositService;
import kr.jkh.khbank.service.LoanService;

@Controller
public class DepositController {
	@Autowired
	private DepositService depositService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private LoanService loanService;

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
	
	@ResponseBody
	@GetMapping("/deposit/getDepositNum")
	public DepositVO getLoanNum(@RequestParam("dpNum") int dpNum) {
		return adminService.getDepositNum(dpNum);
	}
	
	@GetMapping("/deposit/app")
	public String app(Locale locale, Model model,
			HttpSession session,@RequestParam("dpNum") int dpNum) {
		model.addAttribute("title", "기호은행 - 저축 가입");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		List<MaturityDateVO> date = loanService.getDateList();
		DepositVO deposit = depositService.getLoan(dpNum);
		
		
		model.addAttribute("date",date);
		model.addAttribute("dp",deposit);
		return "/deposit/app";
	}
	
	@PostMapping("/deposit/apply")
	public String apply(Model model,DepositSubscriptionVO dpSub) {
		boolean res = depositService.applydpSub(dpSub);
		if(res) {
			model.addAttribute("msg","상품 가입이 완료 되었습니다.");
			model.addAttribute("url","/deposit/list");
		}else {
			model.addAttribute("msg","상품 가입에 실패 하였습니다.");
			model.addAttribute("url","/deposit/app");
		}
		
		return "message";
	}

}
