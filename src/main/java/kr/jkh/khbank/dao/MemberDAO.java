package kr.jkh.khbank.dao;

import java.sql.Date;

import org.apache.ibatis.annotations.Param;

import kr.jkh.khbank.model.vo.MemberVO;
import kr.jkh.khbank.model.vo.logVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("meId") String meID);

	boolean insertMember(@Param("me") MemberVO memberVO);

	int insertLog(@Param("log") logVO log);

	logVO selectLog(@Param("id")String meID);

	void updateLog(@Param("i") int i);

	MemberVO getMemberInfo(@Param("id")String meID);

	boolean updateMemberInfo(@Param("m") MemberVO member);

	boolean deleteMember(@Param("id")String meID);

}
