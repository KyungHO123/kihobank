package kr.jkh.khbank.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.jkh.khbank.dao.AccountDAO;
import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;

@Service
public class AccountServiceImp implements AccountService {
	
	@Autowired
	private AccountDAO acDao;

	@Override
	public AccountVO getMembetAccount(String meID) {
		if(meID == null) {
			return null;
		}
		return acDao.getMemberAccount(meID);
	}

	@Override
	public ArrayList<AccountLimitVO> getAccountLimit() {
		return acDao.getAccountLimit();
	}

	@Override
	public boolean createAccount(AccountVO account, String id) {
		AccountVO ac = acDao.getMemberAccount(id);
		if(id == null||ac != null )
			return false;
		boolean add = acDao.createAccount(account,id);
		if(!add)
			return false;
		return true;
	}

	@Override
	public AccountLimitVO getLimit(int acAclNum) {
		return acDao.getLimit(acAclNum);
	}

	@Transactional
	@Override
	public void applyInterest() {
		List<AccountVO> accounts = acDao.acoountList();
		
		for(AccountVO account : accounts) {
			if(account == null) {
				return;
			}
			if(account.getAcInterest() > 0) {
				double newBalance = account.getAcBalance() + (account.getAcBalance() * account.getAcInterest()/12); 
				account.setAcBalance(newBalance);
				acDao.updateAccount(account);
				
			}
		}
	}


}
