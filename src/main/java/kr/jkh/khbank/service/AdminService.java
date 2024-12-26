package kr.jkh.khbank.service;

import java.util.ArrayList;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.pagination.Criteria;

public interface AdminService {

	boolean addLoan(LoanVO loan, MemberVO user);

	ArrayList<LoanVO> getLoanList(Criteria cri);

	int getTotalCount(Criteria cri);

	LoanVO getLoanNum(int laNum);

	boolean loanUpdate(LoanVO loan);

	boolean deleteLoan(int laNum);




}
