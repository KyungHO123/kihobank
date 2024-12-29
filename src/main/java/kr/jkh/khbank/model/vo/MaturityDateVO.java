package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//만기일자VO
public class MaturityDateVO {
	private int mdNum; //만기일자 번호
	private int mdDate; //만기일자 개월
	
	private LoanSubscriptionVO loanSub;
	
}
