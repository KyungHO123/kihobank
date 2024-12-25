package kr.jkh.khbank.service;

import kr.jkh.khbank.model.dto.LoginDTO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.logVO;

public interface MemberService {

	boolean memberSignup(MemberVO memberVO);

	MemberVO login(LoginDTO loginDTO);

	int insertLog(logVO log);

	void logout(String meID);

	MemberVO getMemberInfo(MemberVO member);

	boolean updateMemberInfo(MemberVO member, MemberVO user);

	boolean deleteMember(MemberVO member);

}
