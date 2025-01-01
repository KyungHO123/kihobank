package kr.jkh.khbank.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.dao.LoanDAO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.RepayMentVO;

@Service
public class LoanServiceImp implements LoanService {
	
	@Autowired
	private LoanDAO laDao;

	@Override
	public List<LoanVO> getloanList() {
		return laDao.getloanList();
	}
	@Override
	public LoanVO getLoan(int laNum) {
		if(laNum <= 0)
			return null;
			
		return laDao.getLoan(laNum);
	}
	@Override
	public List<MaturityDateVO> getDateList() {
		return laDao.getDateList();
	}
	@Override
	public List<RepayMentVO> getRepayMentList() {
		return laDao.getRepayMentList();
	}
	@Override
	public boolean applyLoanSub(LoanSubscriptionVO loanSub) {
		if(loanSub == null)
			return false;
		return laDao.applyLoanSub(loanSub);
	}
	@Override
	public LoanSubscriptionVO getMemberLoanSub(String meID) {
		return laDao.getMemberLoanSub(meID);
	}
	@Override
	public void UpdateLoanMaturity(int lsNum, Date maturityDate) {
		laDao.UpdateLoanMaturity(lsNum,maturityDate);
		return;
		
	}





}
