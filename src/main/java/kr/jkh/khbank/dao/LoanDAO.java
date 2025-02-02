package kr.jkh.khbank.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.DepositTypeVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.LoanRepaymentVO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.MemberAuthorityVO;
import kr.jkh.khbank.model.vo.MemberStateVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.RepayMentVO;
import kr.jkh.khbank.model.vo.logVO;
import kr.jkh.khbank.pagination.Criteria;

public interface LoanDAO {

	LoanVO getLoan(@Param("num")int laNum);

	List<LoanVO> getloanList();

	List<MaturityDateVO> getDateList();

	List<RepayMentVO> getRepayMentList();

	boolean applyLoanSub(@Param("ls")LoanSubscriptionVO loanSub);

	LoanSubscriptionVO getMemberLoanSub(@Param("id")String meID);

	void UpdateLoanMaturity(@Param("num")int lsNum,@Param("date")Date maturityDate);

	MaturityDateVO getMaturity(@Param("num")int lsMdNum);

	LoanRepaymentVO getLoanRepayment(@Param("num")int lsNum);

	AccountVO getAccount(@Param("id")String lsMeID);

	boolean updateRepayment(@Param("lr")LoanRepaymentVO lr);

	boolean updateAccount(@Param("ac")AccountVO ac);

	List<LoanSubscriptionVO> getLoanSubList();

	List<LoanVO> getLoanAllList();

	
	 


}
