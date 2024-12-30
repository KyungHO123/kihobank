package kr.jkh.khbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.dao.LoanDAO;
import kr.jkh.khbank.model.vo.LoanSubscriptionVO;
import kr.jkh.khbank.model.vo.LoanVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;
import kr.jkh.khbank.model.vo.RepayMentVO;

@Service
public class DepositServiceImp implements DepositService {
	
	@Autowired
	private LoanDAO laDao;

	

}
