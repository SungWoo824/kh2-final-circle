package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.MemberDto;

public interface ManagerDao {
	List<MemberDto> memberList(String type,String value);
}
