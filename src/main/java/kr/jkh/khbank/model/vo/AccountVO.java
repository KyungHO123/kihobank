package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountVO {
	private int acHeadNum;//생성번호 AI
	private String acNum;//계좌번호
	private String acName;//계좌이름
	private double acBalance;//계좌잔액
	private double acInterest;//계좌이자
	private Date acCreate;//계좌생성일
	private Date acUpdate;//계좌수정일
	private Date acClose;//계좌해지일
	private String acPW;//계좌비밀번호
	private String acMeID;//계좌회원아이디
	private int acAclNum;//계좌한도번호
	private int acAcsNum;//계좌상태번호
	
	private AccountLimitVO accountLimit;
	private MemberVO member;
}
