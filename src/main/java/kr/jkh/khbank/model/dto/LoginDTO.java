package kr.jkh.khbank.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginDTO {

	private String id;
	private String pw;
	private boolean autoLogin;
	
}
