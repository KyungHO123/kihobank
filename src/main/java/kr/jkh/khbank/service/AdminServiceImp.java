package kr.jkh.khbank.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.jkh.khbank.dao.AdminDAO;
import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.LoanVO;
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
		System.out.println("임플"+laNum);
		return adDao.deleteLoan(laNum);

	}
}
