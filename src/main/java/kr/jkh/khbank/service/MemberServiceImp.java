package kr.jkh.khbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.dao.MemberDAO;
import kr.jkh.khbank.model.dto.LoginDTO;
import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.logVO;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}

	@Override
	public boolean memberSignup(MemberVO memberVO) {
		if (memberVO == null)
			return false;
		MemberVO user = memberDAO.selectMember(memberVO.getMeID());
		if (user != null)
			return false;
		if (memberVO.getMeID() == null || memberVO.getMePw() == null || memberVO.getMeEmail() == null
				|| memberVO.getMePhone() == null || memberVO.getMePost() == null || memberVO.getMeStreet() == null
				|| memberVO.getMeDetail() == null)
			return false;
		String encPw = passwordEncoder.encode(memberVO.getMePw());
		memberVO.setMePw(encPw);
		try {
			return memberDAO.insertMember(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 로그인
	@Override
	public MemberVO login(LoginDTO loginDTO) {
		if (loginDTO == null || !checkString(loginDTO.getId()) || !checkString(loginDTO.getPw()))
			return null;
		MemberVO user = memberDAO.selectMember(loginDTO.getId());
		if (user == null || !passwordEncoder.matches(loginDTO.getPw(), user.getMePw()))
			return null;

		return user;
	}

	@Override
	public int insertLog(logVO log) {
		System.out.println("로그 임플");
		return memberDAO.insertLog(log);

	}

	@Override
	public void logout(String meID) {
		logVO log = memberDAO.selectLog(meID);
		if (log != null) {
			memberDAO.updateLog(log.getLogNum());
		}

	}

	@Override
	public MemberVO getMemberInfo(MemberVO member) {
		return memberDAO.getMemberInfo(member.getMeID());

	}

	@Override
	public boolean updateMemberInfo(MemberVO member, MemberVO user) {
		if (!checkString(member.getMeDetail()) || !checkString(member.getMeStreet()) || !checkString(member.getMePost())
				|| !checkString(member.getMeName()) || !checkString(member.getMePhone())
				|| !checkString(member.getMeEmail())) {
			return false;
		}
		// 비번을 안 바꾸는 경우 : 기존 비밀번호를 이용
		if (!checkString(member.getMePw())) {
			member.setMePw(user.getMePw());
		} else {
			String encPw = passwordEncoder.encode(member.getMePw());
			member.setMePw(encPw);
		}
		member.setMeID(user.getMeID());
		boolean res = memberDAO.updateMemberInfo(member);
		if(!res) {
			return false;
		}
		user.setMePw(member.getMePw());
		user.setMeEmail(member.getMeEmail());
		return true;
	}

	@Override
	public boolean deleteMember(MemberVO member) {
		return memberDAO.deleteMember(member.getMeID());
	}

}
