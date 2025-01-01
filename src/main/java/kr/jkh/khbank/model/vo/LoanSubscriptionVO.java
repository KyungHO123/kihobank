package kr.jkh.khbank.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//대출가입 VO
public class LoanSubscriptionVO{
	
	private int lsNum;//가입번호
	private Date lsApp;//신청일
	private Date lsOk; //승인일자
	private Date lsMaturity; //만기일자
	private String lsAccount;//대출계좌
	private int lsAmount;//대출금액 
	private String lsMeID;//회원아이디
	private int lsLaNum;//대출상품번호
	private int lsReNum; //상환방식번호
	private int lsLtNum; //대출상태번호 (승인여부)
	private int lsMdNum; //만기일자번호
	
	
	private MemberVO member;
	private LoanVO loan;
	private RepayMentVO repayMent;
	private MaturityDateVO maturity;
	private LoanTypeVO loanType;
	
	
	public String getChangeDate() {
		if (this.lsApp != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.lsApp);
		} else {
			return "존재하지 않습니다.";
		}
	}
}
