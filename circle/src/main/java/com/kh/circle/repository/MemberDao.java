package com.kh.circle.repository;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;

public interface MemberDao {
	void signup(MemberDto memberDto,MemberProfileDto memberProfileDto);
	int getSequence();
	MemberDto signin(String email,String pw);
	String checkGrade(MemberDto memberDto);
	void changepw(MemberDto memberDto);
	
}
