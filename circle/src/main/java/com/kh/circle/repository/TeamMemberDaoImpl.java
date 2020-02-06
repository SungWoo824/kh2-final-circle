package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TeamMemberDto;

@Repository
public class TeamMemberDaoImpl implements TeamMemberDao {
	
	@Autowired SqlSession sqlSession;
	
	//team_member 테이블에 등록 시키는 메소드 
	@Override
	public void registTeamMember(TeamMemberDto teamMemberDto) {
		sqlSession.insert("team.registTeamMember",teamMemberDto);
		
	}

}
