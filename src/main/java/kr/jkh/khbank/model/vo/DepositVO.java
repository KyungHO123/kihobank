package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//저축VO
public class DepositVO {
	private int dpNum; // 저축상품번호
	private String dpName; //저축상품명
	private String dpDetail; //저축상품설명
	private double dpInterest; //저축 연이율
	private int dpDtNum;// 상품 종류번호
	
	private AccountVO account;
	private MemberVO member;
}
