package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;

public interface TeamDao {
	
	int getSequence();
	void teamCreate(TeamDto teamDto);
	List<TeamDto> teamList(int member_no);
	void teamMemberCreate(int member_no,int team_no);
	void teamMemberCreate2(int member_no, int team_no);
}
