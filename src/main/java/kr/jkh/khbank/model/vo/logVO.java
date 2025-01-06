package kr.jkh.khbank.model.vo;


import java.sql.Date;
import java.text.SimpleDateFormat;

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
	
	public String getChangeLogDate() {
		if (this.logDate != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.logDate);
		} else {
			return "존재하지 않습니다.";
		}
	}
	public String getChangeLogOutDate() {
		if (this.logOutDate != null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
			return format.format(this.logOutDate);
		} else {
			return " ";
		}
	}

}
