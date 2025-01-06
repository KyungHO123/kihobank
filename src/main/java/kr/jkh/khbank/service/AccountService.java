package kr.jkh.khbank.service;

import java.util.ArrayList;
import java.util.List;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.TransactionVO;
import kr.jkh.khbank.pagination.Criteria;

public interface AccountService {

	AccountVO getMembetAccount(String meID);

	ArrayList<AccountLimitVO> getAccountLimit();

	boolean createAccount(AccountVO account, String string);

	AccountLimitVO getLimit(int acAclNum);

	void applyInterest();

	AccountVO getAccount(String trAcNum);

	boolean transaction(TransactionVO transaction, AccountVO myAccount, AccountVO receiverAccount);

	AccountVO getMyAccount(int trAcHeadNum);

	List<TransactionVO> selectTrList(Criteria cri, AccountVO ac);

	int getTrTotalCount(Criteria cri, AccountVO ac);



}
