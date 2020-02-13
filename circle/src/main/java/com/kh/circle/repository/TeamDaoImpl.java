package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.vo.MemberListVO;

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

	@Override
	public List<MemberListVO> memberList(int team_no) {
//		MemberListVO memberListVO = MemberListVO.builder()
//				.member_name(member_name)
//				.member_position(member_position)
//				.build();
		return sqlSession.selectList("team.memberList",team_no);
	}

	@Override
	public List<Object> teamDetail(int team_no) {
		
		return sqlSession.selectList("team.teamDetail", team_no);
	}

	@Override
	public void teamDelete(int team_no) {
		sqlSession.delete("team.teamDelete", team_no);
		
	}

	@Override
	public void editTeamName(String team_name, int team_no) {
		TeamDto teamDto = TeamDto.builder()
				.team_name(team_name)
				.team_no(team_no)
				.build();
		
		sqlSession.update("team.editTeamName", teamDto);
		
	}

	
	
	
	


}
