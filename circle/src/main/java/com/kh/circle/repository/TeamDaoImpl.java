package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.vo.MemberListVO;
import com.kh.circle.vo.TeamMainVO;

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
	public List<TeamMainVO> teamMainList(int member_no) {
		
		return sqlSession.selectList("team.teamMainList", member_no);
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
	
	//특정 팀에 참여 중인 모든 멤버 리스트 출력
	@Override
	public List<MemberListVO> memberList(int team_no) {
//		MemberListVO memberListVO = MemberListVO.builder()
//				.member_name(member_name)
//				.member_position(member_position)
//				.build();
		return sqlSession.selectList("team.memberList",team_no);
	}
	
	//특정 팀에 참여중인 정회원 리스트 출력 
	@Override
	public List<MemberListVO> memberListRegular(int team_no) {
		return sqlSession.selectList("team.memberListRegular", team_no);
	}
	
	//특정 팀에 참여중인 준회원 리스트 출력
	@Override
	public List<MemberListVO> memberListAssociate(int team_no) {
		return sqlSession.selectList("team.memberListAssociate", team_no);
	}
	
	// 특정 팀에 참여중인 소유자 리스트 출력
	@Override
	public List<MemberListVO> memberListOwner(int team_no) {
		return sqlSession.selectList("team.memberListOwner", team_no);
	}
	
	//팀 테이블 리스트 셀렉원으로 출력 / 리스트 출력 아님
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
	
	//팀 관리자 : 멤버 등급 변경
	@Override
	public void grantPosition(int member_no, int team_no, String member_position) {
		Map<String,Object> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("team_no", team_no);
		param.put("member_position",member_position);
		
		sqlSession.update("team.grantPosition", param);
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
	
	//팀멤버 테이블 전체 목록 셀렉원으로 출력
	@Override
	public TeamMemberDto teamMemberInfo(int member_no, int team_no) {
		TeamMemberDto teamMemberDto = TeamMemberDto.builder()
													.member_no(member_no)
													.team_no(team_no)
													.build();
		return sqlSession.selectOne("team.teamMemberInfo", teamMemberDto);
	}


	@Override
	public boolean teamMemberCheck(int member_no, int team_no) {
		Map<String, Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("team_no", team_no);
		TeamMemberDto teamMemberDto = sqlSession.selectOne("team.teamMemberCheck", param);
		return teamMemberDto != null; 
}


	@Override
	public void changeAuth(TeamMemberDto teamMemberDto) {	
		sqlSession.update("team.changeAuth", teamMemberDto);
	}

	@Override
	public String checkPosition(int member_no, int team_no) {
		
		TeamMemberDto teamMemberDto = TeamMemberDto.builder()
				.member_no(member_no)
				.team_no(team_no)
				.build();
		
		return sqlSession.selectOne("team.selectPosition", teamMemberDto);
	}

	@Override
	public List<MemberListVO> minorPosition(int team_no) {
		return sqlSession.selectList("team.minor", team_no);
	}

	
	

}
