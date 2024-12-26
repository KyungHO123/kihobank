package kr.jkh.khbank.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//대출VO
public class LoanVO {
	private int laNum; // 대출상품번호
	private String laName; //대출상품명
	private String laDetail; //대출상품설명
	private double laInterest; //대출 연이율
	private int laLimitMax; //대출최대한도
	private int laLimitMin; //대출최소한도
	private double laOverdue; //연체 이자율
	private Date laCreate; //연체 이자율
	
	
	private AccountVO account;
	private MemberVO member;
	public String getChangeDate() {
		if (this.laCreate != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.laCreate);
		} else {
			return "존재하지 않습니다.";
		}
	}
}
