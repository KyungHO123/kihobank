package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	private String meID;
	private String meName;
	private String mePw;
	private String meEmail;
	private String mePhone;
	private String mePost;
	private String meStreet;
	private String meDetail;
	private Date meSignup;
	private Date meUpdate;
	private int meMaNum;
	private int meMsNum;
	
	private AccountLimitVO accountLimit;
}
