package kr.jkh.khbank.service;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.dao.DepositDAO;
import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;

@Service
public class DepositServiceImp implements DepositService {

	@Autowired
	private DepositDAO dpDao;

	@Override
	public DepositVO getLoan(int dpNum) {
		return dpDao.getLoan(dpNum);
	}

	@Override
	public boolean applydpSub(DepositSubscriptionVO dpSub) {
		if (dpSub == null)
			return false;

		return dpDao.applydpSub(dpSub);
	}

	@Override
	public DepositSubscriptionVO getMemberDepositSub(String meID) {
		// TODO Auto-generated method stub
		return dpDao.getMemberDepositSub(meID);
	}

	@Override
	public MaturityDateVO getMaturity(int dsMdNum) {
		// TODO Auto-generated method stub
		return dpDao.getMaDate(dsMdNum);
	}

	@Override
	public void UpdateDepositMaturity(int dsNum, Date maturityDate) {
		dpDao.UpdateDepositMaturity(dsNum, maturityDate);
		return;

	}

	@Override
	public List<DepositVO> getDepositList() {
		return dpDao.getDepositList();
	}

}
