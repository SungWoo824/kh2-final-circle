package com.kh.circle.repository;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;

public interface MemberDao {
	void signup(MemberDto memberDto,MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	int getSequence();
	int profileGetSequence();
	MemberDto signin(String email,String pw);
	String checkGrade(MemberDto memberDto);
	void changepw(MemberDto memberDto);
	void memberChangeName(String email,String name);
	MemberDto info(String member_email);
	void memberDelete(String member_email);
	int memberProfileNo(int member_no);
	MemberProfileDto getMemberProfile(int member_no);
}
