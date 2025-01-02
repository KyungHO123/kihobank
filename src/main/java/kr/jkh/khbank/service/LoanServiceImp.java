package kr.jkh.khbank.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.dao.LoanDAO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.LoanRepaymentVO;
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
	@Override
	public boolean loanRepay(LoanSubscriptionVO laSub) {
		if(laSub == null)
			return false;
		//상환테이블
		LoanRepaymentVO lr = laDao.getLoanRepayment(laSub.getLsNum());
		//만기일자 테이블
		MaturityDateVO maturity = laDao.getMaturity(laSub.getLsMdNum());
		//회원 계좌 
		AccountVO ac = laDao.getAccount(laSub.getLsMeID());
		// 년 * 12 = 개월 수
		int month = maturity.getMdDate() * 12;
		// 신청했던 대출금액 / 개월 수
		int repayMent = laSub.getLsAmount() / month;
		//lrBalance는 대출 잔액
		 if (lr.getLrBalance() < repayMent) {
		        // 초과 상환 처리
		        if (ac.getAcBalance() < repayMent) {
		        	// 계좌 잔액만큼만 상환
		            repayMent = (int) ac.getAcBalance(); 
		        }
		    }
		 ac.setAcBalance(ac.getAcBalance() - repayMent);
		 lr.setLrBalance(lr.getLrBalance() - repayMent);
		 lr.setLrAmount(lr.getLrAmount() + repayMent);
		 //updateRepayment는 대출 잔액과 대출 누적 상환금액 업데이트
		 //updateAccount는 상환 후 계좌금액 업데이트
		 if(!laDao.updateRepayment(lr)&&!laDao.updateAccount(ac)) {
			 return false;
		 }
		
		return true;
	}
	@Override
	public List<LoanSubscriptionVO> getLoanSubList() {
		// TODO Auto-generated method stub
		return laDao.getLoanSubList();
	}





}
