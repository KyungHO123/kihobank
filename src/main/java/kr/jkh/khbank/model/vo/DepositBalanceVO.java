package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//저축잔액VO
public class DepositBalanceVO {
	private int dbNum; // 저축잔액번호
	private double dbBalance; //잔액
	private Date dbUpdate; //잔액업데이트날짜 
	private int dbDsNum;// 가입번호
	
	private AccountVO account;
	private MemberVO member;
}
