package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;

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
	public List<TeamDto> teamList(int member_no) {	
		return sqlSession.selectList("team.teamlist",member_no);
	}

	@Override
	public void teamMemberCreate(int member_no, int team_no) {
		Map<String,Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("team_no", team_no);
		
		sqlSession.insert("team.teamMemberCreate", param);
	}

	@Override
	public void teamMemberCreate2(int member_no, int team_no) {
		TeamMemberDto teamMemberDto = TeamMemberDto.builder()
						.member_no(member_no)
						.team_no(team_no)
						.build();
		sqlSession.insert("team.teamMemberCreate2",teamMemberDto);
		
	}


}
