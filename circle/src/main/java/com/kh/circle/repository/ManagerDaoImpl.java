package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ManagerDaoImpl implements ManagerDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberDto> memberList(String type,String value) {
		Map<String,String> param = new HashMap<>();
			param.put("type", type);
			param.put("value", value);
		
		
		return sqlSession.selectList("member.memberList", param);
	}

}
