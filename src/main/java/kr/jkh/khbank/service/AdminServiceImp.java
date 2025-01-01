package kr.jkh.khbank.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.jkh.khbank.dao.AdminDAO;
import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MemberAuthorityVO;
import kr.jkh.khbank.model.vo.MemberStateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.pagination.Criteria;

@Service
public class AdminServiceImp implements AdminService {

	@Autowired
	private AdminDAO adDao;

	@Override
	public boolean addLoan(LoanVO loan, MemberVO user) {
		if (user == null || user.getMeMaNum() == 1) {
			return false;
		}
		if (loan == null) {
			return false;
		}

		return adDao.addLoan(loan);
	}

	@Override
	public ArrayList<LoanVO> getLoanList(Criteria cri) {
		if (cri == null) {
			return null;
		}
		return adDao.selectAjaxLoanList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		if (cri == null) {
			return 0;
		}
		return adDao.selectTotalCount(cri);
	}

	@Override
	public LoanVO getLoanNum(int laNum) {
		if (laNum <= 0) {
			return null;
		}
		return adDao.getLoanNum(laNum);
	}

	@Override
	public boolean loanUpdate(LoanVO loan) {
		if (loan == null) {
			return false;
		}
		return adDao.loanUpdate(loan);
	}

	@Override
	public boolean deleteLoan(int laNum) {
		if (laNum <= 0) {
			return false;
		}
		return adDao.deleteLoan(laNum);

	}

	@Override
	public ArrayList<DepositTypeVO> getDepositTypeList() {
		return adDao.getDepositTypeList();
	}

	@Override
	public ArrayList<MemberVO> getMemberList() {
		// TODO Auto-generated method stub
		return adDao.getMemberList();
	}

	@Override
	public ArrayList<MemberStateVO> getMemberState() {
		// TODO Auto-generated method stub
		return adDao.getMemberState();
	}

	@Override
	public ArrayList<MemberAuthorityVO> getMemberauthority() {
		// TODO Auto-generated method stub
		return adDao. getMemberauthority();
	}

	@Override
	public boolean adminMemberUpdate(MemberVO member) {
		if(member.getMeMaNum() <= 0 || member.getMeMsNum() <= 0) {
			return false;
		}
		System.out.println(member + "임플");
		return adDao.adminMemberUpdate(member);
	}

	@Override
	public ArrayList<MemberVO> getAjaxMemberList(Criteria cri) {
		if(cri == null) {
			return null;
		}
		// TODO Auto-generated method stub
		return adDao.getAjaxMemberList(cri);
	}

	@Override
	public int getTotalMemberCount(Criteria cri) {
		if(cri == null) {
			return 0;
		}
		// TODO Auto-generated method stub
		return adDao.getTotalMemberCount(cri);
	}

	@Override
	public boolean addDeposit(DepositVO deposit, MemberVO user) {
		if(user == null || user.getMeMaNum() == 1)
			return false;
		if(deposit == null)
			return false;
		return adDao.addDeposit(deposit);
	}

	@Override
	public ArrayList<DepositVO> getDepositList(Criteria cri) {
		if(cri == null)
			return null;
		return adDao.getDepositList(cri);
	}

	@Override
	public int getDpTotalCount(Criteria cri) {
		if(cri == null)
			return 0;
		return adDao.getDpTotalCount(cri);
	}

	@Override
	public DepositTypeVO getDepositType(int dpDtNum) {
		// TODO Auto-generated method stub
		return adDao.getDepositType(dpDtNum);
	}

	@Override
	public DepositVO getDepositNum(int dpNum) {
		// TODO Auto-generated method stub
		return adDao.getDepositNum(dpNum);
	}

	@Override
	public boolean depositUpdate(DepositVO deposit) {
		if(deposit == null)
			return false;
		
		return adDao.depositUpdate(deposit);
	}

	@Override
	public boolean deleteDeposit(int dpNum) {
		// TODO Auto-generated method stub
		return  adDao.depositDelete(dpNum);
	}

	@Override
	public List<LoanSubscriptionVO> selectLaSubList(Criteria cri) {
		if(cri == null)
			return null;
		return adDao.selectLaSubList(cri);
	}

	@Override
	public boolean lsOk(LoanSubscriptionVO laSub) {
		System.out.println(laSub + "임플 라썹~~");
		if(laSub == null) {
			return false;
		}
		boolean res = adDao.isOk(laSub);
		if(res) {
			adDao.addLoanRepayment(laSub);
		}else {
			return false;
		}
		return true;
	}
}
