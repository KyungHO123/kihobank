package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//대출상태VO
public class LoanTypeVO {
	private int ltNum; //대출상태번호
	private String ltName; //대출상태이름
	
	private LoanSubscriptionVO loanSub;
	
}
