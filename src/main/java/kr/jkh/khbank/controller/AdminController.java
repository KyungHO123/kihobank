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

import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MemberAuthorityVO;
import kr.jkh.khbank.model.vo.MemberStateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.logVO;
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
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		
		return "/admin/main";
	}
	@GetMapping("/admin/loanProduct")
	public String loanProduct(Locale locale, Model model,HttpSession session,LoanVO loan) {
		model.addAttribute("title","기호은행 - 대출상품관리");
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		
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
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		ArrayList<DepositTypeVO> type = adminService.getDepositTypeList();
		model.addAttribute("type",type);
		
		return "/admin/depositProduct";
	}
	@GetMapping("/admin/members")
	public String getMemberList(HttpSession session,Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
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
	@ResponseBody
	@GetMapping("/admin/getDpNum")
	public Map<String, Object> getDpNum(@RequestParam("dpNum")  int dpNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		DepositVO dp = adminService.getDepositNum(dpNum);
		DepositTypeVO dt = adminService.getDepositType(dp.getDpDtNum());
		dp.setDepositType(dt);
		map.put("dp", dp);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/admin/dpUpdate")
	public Map<String, Object> dpUpdate(@RequestBody DepositVO deposit ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2 ||user == null) {
			return null;
		}
		boolean res = adminService.depositUpdate(deposit);
		map.put("res", res);
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/deleteDeposit")
	public Map<String, Object> deleteDeposit(@RequestParam("dpNum") int dpNum ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2) {
			return null;
		}
		boolean deposit = adminService.deleteDeposit(dpNum);
		map.put("deposit", deposit);
		return map;
	}
	
	@GetMapping("/admin/loanList")
	public String loanList(Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		return "/admin/loanList";
	}
	@ResponseBody
	@PostMapping("/admin/ajaxLoanList")
	public Map<String, Object> ajaxLoanList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		List<LoanSubscriptionVO> laSub = adminService.selectLaSubList(cri);
		int totalCount = adminService.getLaSubTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("laSub", laSub);
		map.put("pm", pm);
		
		
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/lsOk")
	public Map<String, Object> lsOk(@RequestBody LoanSubscriptionVO laSub ,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("member");
		if(user.getMeMaNum() != 2 ||user == null) {
			return null;
		}
		System.out.println(laSub.getLsMeID() + "아이디읻이디이");
		MemberVO member = adminService.getLaSubMemberID(laSub.getLsMeID());
		System.out.println(member + "멤버컨트롤러");
		AccountVO ac = adminService.selectMemberAccount(member.getMeID());
		System.out.println(ac + "어카컨트롤러");
		boolean res = adminService.lsOk(laSub,ac);
		map.put("res", res);
		return map;
	}
	@GetMapping("/admin/depositList")
	public String depositList(Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		
		return "/admin/depositList";
	}
	@ResponseBody
	@PostMapping("/admin/ajaxDepositList")
	public Map<String, Object> ajaxDepositList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		List<DepositSubscriptionVO> dpSub = adminService.selectDpSubList(cri);
		int totalCount = adminService.getDpSubTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("dpSub", dpSub);
		map.put("pm", pm);
		
		
		return map;
	}
	@GetMapping("/admin/log")
	public String log(Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg","로그인이 필요한 페이지입니다.");
			model.addAttribute("url","/member/login");
			return "message";
		}
		if(member.getMeMaNum() != 2) {
			model.addAttribute("msg","접근할 수 없는 페이지입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		return "/admin/log";
	}
	@ResponseBody
	@PostMapping("/admin/ajaxLogList")
	public Map<String, Object> ajaxLogList(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		List<logVO> log = adminService.selectLogList(cri);
		int totalCount = adminService.getLogTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("log", log);
		map.put("pm", pm);
		
		
		return map;
	}
 }
