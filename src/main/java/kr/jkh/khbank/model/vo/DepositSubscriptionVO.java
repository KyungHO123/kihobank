package kr.jkh.khbank.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//저축가입VO
public class DepositSubscriptionVO {
	private int dsNum; // 저축가입번호
	private String dsAccount;// 저축계좌
	private int dsAmount; //저축이체금액
	private Date dsSubDate; //가입일자 
	private Date dsCloseDate; //해지일자
	private Date dsMaturity; //만기일자
	private int dsDpNum;// 상품번호
	private String dsMeID;// 아이디
	private int dsSsNum;// 가입상태번호
	private int dsMdNum;// 만기일자번호
	
	private SubscriptionstateVO state;
	private DepositVO deposit;
	private AccountVO account;
	private MemberVO member;
	private MaturityDateVO maturity;
	
	public String getChangeDate() {
		if (this.dsSubDate != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.dsSubDate);
		} else {
			return "존재하지 않습니다.";
		}
	}
}
