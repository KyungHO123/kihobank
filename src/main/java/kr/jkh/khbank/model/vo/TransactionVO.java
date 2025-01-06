package kr.jkh.khbank.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//거래VO
public class TransactionVO {
	private int trNum; //거래번호
	private Date trDate; //거래일자
	private int trBalance; //거래금액
	private String trName; //거래자명
	private String trAcNum; //거래계좌
	private String trMemo; //거래메모
	private int trAfter; //거래 후 잔액
	private int trAcHeadNum; //내 계좌번호
	private int acTtNum; //거래타입번호
	private int trFeeNum;//거래수수료번호
	private String trMyAccount;
	private String trSender;
	
	private AccountVO account;
	private MemberVO member;
	private TransactionTypeVO type;
	
	public String getChangeDate() {
		if (this.trDate != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.trDate);
		} else {
			return "존재하지 않습니다.";
		}
	}
}
