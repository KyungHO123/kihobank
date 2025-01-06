package kr.jkh.khbank.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.jkh.khbank.model.vo.AccountLimitVO;
import kr.jkh.khbank.model.vo.AccountVO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.TransactionVO;
import kr.jkh.khbank.model.vo.logVO;
import kr.jkh.khbank.pagination.Criteria;

public interface AccountDAO {

	AccountVO getMemberAccount(@Param("id") String meID);

	ArrayList<AccountLimitVO> getAccountLimit();

	boolean createAccount(@Param("ac") AccountVO account, @Param("id") String meID);

	AccountLimitVO getLimit(@Param("ac")int acAclNum);

	List<AccountVO> acoountList();

	void updateAccount(@Param("ac") AccountVO account);

	AccountVO getMyAccount(@Param("ac")String meID);

	AccountVO getTrAccount(@Param("ac")String trAcNum);

	AccountVO getMyAccount(@Param("num")int trAcHeadNum);

	void saveTransaction(@Param("tr")TransactionVO transaction);

	List<TransactionVO> selectTrList(@Param("cri")Criteria cri, @Param("ac")AccountVO ac);

	int getTrTotalCount(@Param("cri")Criteria cri,@Param("ac") AccountVO ac);

	void saveTransaction2(@Param("tr")TransactionVO tr);


}
