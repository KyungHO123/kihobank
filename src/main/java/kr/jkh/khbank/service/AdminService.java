package kr.jkh.khbank.service;

import java.util.ArrayList;
import java.util.List;

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

public interface AdminService {

	boolean addLoan(LoanVO loan, MemberVO user);

	ArrayList<LoanVO> getLoanList(Criteria cri);

	int getTotalCount(Criteria cri);

	LoanVO getLoanNum(int laNum);

	boolean loanUpdate(LoanVO loan);

	boolean deleteLoan(int laNum);

	ArrayList<DepositTypeVO> getDepositTypeList();

	ArrayList<MemberVO> getMemberList();

	ArrayList<MemberStateVO> getMemberState();

	ArrayList<MemberAuthorityVO> getMemberauthority();

	boolean adminMemberUpdate(MemberVO member);

	ArrayList<MemberVO> getAjaxMemberList(Criteria cri);

	int getTotalMemberCount(Criteria cri);

	boolean addDeposit(DepositVO deposit, MemberVO user);

	ArrayList<DepositVO> getDepositList(Criteria cri);

	int getDpTotalCount(Criteria cri);

	DepositTypeVO getDepositType(int dpDtNum);

	DepositVO getDepositNum(int dpNum);

	boolean depositUpdate(DepositVO deposit);

	boolean deleteDeposit(int dpNum);

	List<LoanSubscriptionVO> selectLaSubList(Criteria cri);

	boolean lsOk(LoanSubscriptionVO laSub, AccountVO ac);

	AccountVO selectMemberAccount(String meID);

	MemberVO getLaSubMemberID(String lsMeID);

	List<DepositSubscriptionVO> selectDpSubList(Criteria cri);

	int getDpSubTotalCount(Criteria cri);

	int getLaSubTotalCount(Criteria cri);

	List<logVO> selectLogList(Criteria cri);

	int getLogTotalCount(Criteria cri);




}
