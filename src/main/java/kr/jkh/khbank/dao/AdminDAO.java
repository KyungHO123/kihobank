package kr.jkh.khbank.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.jkh.khbank.model.vo.AccountLimitVO;
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

public interface AdminDAO {

	boolean addLoan(@Param("la")LoanVO loan);

	ArrayList<LoanVO> selectAjaxLoanList(@Param("cri")Criteria cri);

	int selectTotalCount(@Param("cri")Criteria cri);

	LoanVO getLoanNum(@Param("num")int laNum);

	boolean loanUpdate(@Param("la")LoanVO loan);

	boolean deleteLoan(@Param("num")int laNum);

	ArrayList<DepositTypeVO> getDepositTypeList();

	ArrayList<MemberVO> getMemberList();

	ArrayList<MemberStateVO> getMemberState();

	ArrayList<MemberAuthorityVO> getMemberauthority();

	boolean adminMemberUpdate(@Param("me")MemberVO member);

	ArrayList<MemberVO> getAjaxMemberList(@Param("cri")Criteria cri);

	int getTotalMemberCount(@Param("cri")Criteria cri);

	boolean addDeposit(@Param("dp")DepositVO deposit);

	ArrayList<DepositVO> getDepositList(@Param("cri") Criteria cri);

	int getDpTotalCount(@Param("cri") Criteria cri);

	DepositTypeVO getDepositType(@Param("num")int dpDtNum);

	DepositVO getDepositNum(@Param("num")int dpNum);

	boolean depositUpdate(@Param("dp")DepositVO deposit);

	boolean depositDelete(@Param("num")int dpNum);

	List<LoanSubscriptionVO> selectLaSubList(@Param("cri")Criteria cri);

	boolean isOk(@Param("ls")LoanSubscriptionVO laSub);

	boolean addLoanRepayment(@Param("ls")LoanSubscriptionVO laSub);

	AccountVO getAccount(@Param("id")String lsMeID);

	void updateAccountBalance(@Param("ac")AccountVO ac);

	AccountVO selectMemberAccount(@Param("id")String meID);

	MemberVO getLaSubMemberID(@Param("id")String lsMeID);

	List<DepositSubscriptionVO> selectDpSubList(@Param("cri")Criteria cri);

	int getDpSubTotalCount(@Param("cri")Criteria cri);

	int getLaSubTotalCount(@Param("cri")Criteria cri);

	List<logVO> selectLogList(@Param("cri")Criteria cri);

	int getLogTotalCount(@Param("cri")Criteria cri);
	

	 


}
