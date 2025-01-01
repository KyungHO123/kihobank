package kr.jkh.khbank.service;

import java.sql.Date;
import java.util.List;

import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.RepayMentVO;

public interface LoanService {

	LoanVO getLoan(int laNum);

	List<LoanVO> getloanList();

	List<MaturityDateVO> getDateList();

	List<RepayMentVO> getRepayMentList();

	boolean applyLoanSub(LoanSubscriptionVO loanSub);

	LoanSubscriptionVO getMemberLoanSub(String meID);

	void UpdateLoanMaturity(int lsNum, Date maturityDate);
 



}
