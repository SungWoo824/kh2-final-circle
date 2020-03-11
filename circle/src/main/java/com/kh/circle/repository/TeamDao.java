package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.vo.MemberListVO;

public interface TeamDao {
	int getSequence();
	void teamCreate(TeamDto teamDto);
	List<TeamDto> teamList(int member_no);
	List<MemberListVO> memberList(int team_no);
	List<MemberListVO> memberListRegular(int team_no);
	List<MemberListVO> memberListAssociate(int team_no);
	List<MemberListVO> memberListOwner(int team_no);
	void teamMemberCreate(int member_no,int team_no);
	void teamMemberCreate2(int member_no, int team_no);
	TeamDto teamDetail(int team_no);
	void teamDelete(int team_no);
	void editTeamName(String team_name, int team_no);
	void editTeamDomain(String team_domain, int team_no);
	void teamExit(TeamMemberDto teamMemberDto);
	void topicExit(TopicMemberDto topicMemberDto);
	TeamMemberDto teamMemberInfo(int member_no, int team_no);
	void grantPosition(int member_no, int team_no, String member_position);
	boolean teamMemberCheck(int member_no, int team_no);
	void changeAuth(TeamMemberDto teamMemberDto);
	String checkPosition(int member_no, int team_no);
	List<MemberListVO> minorPosition(int team_no);
}
