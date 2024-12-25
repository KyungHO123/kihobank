package kr.jkh.khbank.service;

import java.util.ArrayList;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;

public interface AccountService {

	AccountVO getMembetAccount(String meID);

	ArrayList<AccountLimitVO> getAccountLimit();

	boolean createAccount(AccountVO account, String string);

	AccountLimitVO getLimit(int acAclNum);

	void applyInterest();



}
