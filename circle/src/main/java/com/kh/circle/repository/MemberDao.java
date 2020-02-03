package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;
import com.kh.circle.entity.TeamDto;

public interface MemberDao {
	void signup(MemberDto memberDto,MemberProfileDto memberProfileDto);
	int getSequence();
	MemberDto signin(String email,String pw);
	String checkGrade(MemberDto memberDto);
	void changepw(MemberDto memberDto);
	
	MemberDto info(String member_email);
}
