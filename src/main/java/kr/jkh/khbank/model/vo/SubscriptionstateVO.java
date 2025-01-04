package kr.jkh.khbank.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//만기일자VO
public class SubscriptionstateVO {
	private int ssNum; //만기일자 번호
	private String ssName; //만기일자 개월
	
	
}
