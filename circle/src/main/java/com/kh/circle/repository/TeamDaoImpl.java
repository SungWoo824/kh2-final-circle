package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TeamDto;

@Repository
public class TeamDaoImpl implements TeamDao {
	
	@Autowired SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("team.getSequence");	
	}

	@Override
	public void teamCreate(TeamDto teamDto) {
		sqlSession.insert("team.teamCreate",teamDto);		
	}

	@Override
	public List<TeamDto> teamList(String member_email) {	
		return sqlSession.selectList("team.teamlist",member_email);
	}


}
