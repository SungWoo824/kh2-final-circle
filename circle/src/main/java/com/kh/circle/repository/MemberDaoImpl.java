package com.kh.circle.repository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Override
	public void signup(MemberDto memberDto,MemberProfileDto memberProfileDto,MultipartFile multipartFile) throws IllegalStateException, IOException {
		int no = getSequence();
		int profile_no = profileGetSequence();
		memberDto.setMember_no(no);
		memberDto.setMember_pw(encoder.encode(memberDto.getMember_pw()));
		File dir = new File("D:/upload/kh2e/memberProfile");
	    dir.mkdirs();
	    File target = new File(dir, String.valueOf(profile_no));
	    multipartFile.transferTo(target);
		
		sqlSession.insert("member.signup", memberDto);
		memberProfileDto.setMember_profile_no(profile_no);
		memberProfileDto.setMember_no(no);
		sqlSession.insert("member_profile.insert",memberProfileDto);
	}

	@Override
	public MemberDto signin(String member_email,String pw) {
		MemberDto memberDto = sqlSession.selectOne("member.signin", member_email);
		if(memberDto !=null) {
			if(encoder.matches(pw, memberDto.getMember_pw())) {
				return memberDto;
			}else {
				return null;
			}
		}else {
			return null;
		}
		
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("member.getseq");
	}
	
	@Override
	public int profileGetSequence() {
		return sqlSession.selectOne("member_profile.profileSequence");
	}
	
	@Override
	public String checkGrade(MemberDto memberDto) {
		
		return sqlSession.selectOne("member.checkgrade",memberDto);
	}

	@Override
	public void changepw(MemberDto memberDto) {
		memberDto.setMember_pw(encoder.encode(memberDto.getMember_pw()));
		sqlSession.update("member.changepw", memberDto);
		
	}

	@Override
	public MemberDto info(String member_email) {
		
		return sqlSession.selectOne("member.memberinfo", member_email);
	}

	@Override
	public void memberChangeName(String email, String name) {
		Map<String,String> param = new HashMap<>();
		
		param.put("member_email", email);
		param.put("member_name", name);
		
		sqlSession.update("member.changename", param);
	}

	@Override
	public void memberDelete(String member_email) {
		sqlSession.delete("member.delete", member_email);
	}

	@Override
	public int memberProfileNo(int member_no) {
		return sqlSession.selectOne("member.memberprofileno", member_no);
	}

	@Override
	public MemberProfileDto getMemberProfile(int member_no) {
	
		return sqlSession.selectOne("member_profile.getmemberprofile", member_no);
	}

	@Override
	public void changeProfile(MultipartFile multipartFile,
					MemberProfileDto memberProfileDto, int member_no) throws IllegalStateException, IOException {
		int profile_no = sqlSession.selectOne("member_profile.getprofileno", member_no);
		File dir = new File("D:/upload/kh2e/memberProfile");
	    dir.mkdirs();
	    File origin = new File("D:/upload/kh2e/memberProfile/"+profile_no);
	    origin.delete();
	    File target = new File(dir, String.valueOf(profile_no));
	    multipartFile.transferTo(target);
		
		memberProfileDto.setMember_profile_no(profile_no);
		sqlSession.update("member_profile.memberprofilechange",memberProfileDto);
		
	}


	
}
