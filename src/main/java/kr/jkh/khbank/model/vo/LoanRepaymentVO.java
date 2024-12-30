package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//대출상환 VO
public class LoanRepaymentVO{
	
	private int lrNum;//상환번호
	private Date lrDate;//상환날짜
	private int lrAmount;//상환금액 
	private int lrBalance;//대출잔액 
	private String lrMemo;//메모
	private int ltLsNum;//가입번호
	private int lrRtNum; //상환상태번호
	private int lrOdNum; //연체여부번호
}
