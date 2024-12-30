package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountVO {
	private int acHeadNum;
	private String acNum;
	private String acName;
	private double acBalance;
	private double acInterest;
	private Date acCreate;
	private Date acUpdate;
	private Date acClose;
	private String acPW;
	private String acMeID;
	private int acAclNum;
	private int acAcsNum;
	
	private AccountLimitVO accountLimit;
	private MemberVO member;
}
