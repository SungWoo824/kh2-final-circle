package com.kh.circle.repository;

import com.kh.circle.entity.TeamCertDto;

public interface TeamCertDao {
	void regist(TeamCertDto teamCertDto);
	boolean check3(String member_email, String cert_no);
	void delete(String member_email);
	boolean check4(String member_email,String cert_no);
}
