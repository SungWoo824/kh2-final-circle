package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.vo.MemberListVO;

public interface TeamDao {
	
	int getSequence();
	void teamCreate(TeamDto teamDto);
	List<TeamDto> teamList(int member_no);
	List<MemberListVO> memberList(String member_name, String member_position);
	void teamMemberCreate(int member_no,int team_no);
	void teamMemberCreate2(int member_no, int team_no);
}
