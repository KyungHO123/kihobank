package kr.jkh.khbank.service;

import java.util.ArrayList;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.TransactionVO;

public interface AccountService {

	AccountVO getMembetAccount(String meID);

	ArrayList<AccountLimitVO> getAccountLimit();

	boolean createAccount(AccountVO account, String string);

	AccountLimitVO getLimit(int acAclNum);

	void applyInterest();

	AccountVO getAccount(String trAcNum);

	boolean transaction(TransactionVO transaction, AccountVO myAccount, AccountVO receiverAccount);

	AccountVO getMyAccount(int trAcHeadNum);



}
