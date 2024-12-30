package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//상환방식VO
public class RepayMentVO {
	private int reNum; //상환방식번호
	private String reName; //상환방식이름
	
	private LoanSubscriptionVO loanSub;
	
}
