package kr.jkh.khbank.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//거래VO
public class TransactionTypeVO {
	private int ttNum; //거래번호
	private String ttName; //거래일자

}
