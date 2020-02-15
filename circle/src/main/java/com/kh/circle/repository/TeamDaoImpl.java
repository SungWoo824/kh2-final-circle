package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.entity.TopicMemberDto;
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
	public TeamDto teamDetail(int team_no) {
		
		return sqlSession.selectOne("team.teamDetail", team_no);
	}
	
	//팀 삭제 (팀멤버와 아예 모든 정보 다 삭제)
	@Override
	public void teamDelete(int team_no) {
		sqlSession.delete("team.teamDelete", team_no);
		
	}

	//팀관리자:팀 이름 변경하기
	@Override
	public void editTeamName(String team_name, int team_no) {
		TeamDto teamDto = TeamDto.builder()
				.team_name(team_name)
				.team_no(team_no)
				.build();
		
		sqlSession.update("team.editTeamName", teamDto);
		
	}
	
	//팀관리자:팀 도메인 변경하기
	@Override
	public void editTeamDomain(String team_domain, int team_no) {
		TeamDto teamDto = TeamDto.builder()
				.team_domain(team_domain)
				.team_no(team_no)
				.build();
		sqlSession.update("team.editTeamDomain",teamDto);
	}

	//팀멤버 탈퇴 (팀삭제가 아니고 자신만 탈퇴)
	@Override
	public void teamExit(TeamMemberDto teamMemberDto) {
		
		sqlSession.delete("team.teamExit", teamMemberDto);
		
	}
	
	//팀 탈퇴시 토픽멤버에서도 탈퇴됨
	@Override
	public void topicExit(TopicMemberDto topicMemberDto) {
		sqlSession.delete("team.topicExit",topicMemberDto);
		
	}

	
	
	
	


}
