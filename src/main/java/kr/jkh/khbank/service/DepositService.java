package kr.jkh.khbank.service;


import java.sql.Date;

import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;

public interface DepositService {

	DepositVO getLoan(int dpNum);

	boolean applydpSub(DepositSubscriptionVO dpSub);

	DepositSubscriptionVO getMemberDepositSub(String meID);

	MaturityDateVO getMaturity(int dsMdNum);

	void UpdateDepositMaturity(int dsNum, Date maturityDate);

	 



}
