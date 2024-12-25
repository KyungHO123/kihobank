package kr.jkh.khbank.model.vo;


import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@Alias("logVO")
public class logVO {
	private int logNum;
	private Date logDate;
	private Date logOutDate;
	private	String logIP;
	private String logMeID;
	


}
