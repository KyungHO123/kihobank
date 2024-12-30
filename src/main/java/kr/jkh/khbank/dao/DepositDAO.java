package kr.jkh.khbank.dao;


import java.sql.Date;

import org.apache.ibatis.annotations.Param;

import kr.jkh.khbank.model.vo.DepositSubscriptionVO;
import kr.jkh.khbank.model.vo.DepositVO;
import kr.jkh.khbank.model.vo.MaturityDateVO;

public interface DepositDAO {

	DepositVO getLoan(@Param("num")int dpNum);

	boolean applydpSub(@Param("dp")DepositSubscriptionVO dpSub);

	DepositSubscriptionVO getMemberDepositSub(@Param("id")String meID);

	MaturityDateVO getMaDate(@Param("num")int dsMdNum);

	Object UpdateDepositMaturity(@Param("num")int dsNum, @Param("date") Date maturityDate);

	 
	
	 


}
