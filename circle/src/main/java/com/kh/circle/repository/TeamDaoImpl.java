package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TeamDto;

@Repository
public class TeamDaoImpl implements TeamDao {
	
	@Autowired SqlSession sqlSession;
	


	@Override
	public void teamCreate(TeamDto teamDto) {
		sqlSession.insert("teamCreate",teamDto);
		
	}

	@Override
	public int getSequence(TeamDto teamDto) {
		return sqlSession.selectOne("getSequence",teamDto);
		
	}



}
