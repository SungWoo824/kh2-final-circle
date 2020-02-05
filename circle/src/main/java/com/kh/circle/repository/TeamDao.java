package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TeamDto;

public interface TeamDao {
	
	int getSequence();
	void teamCreate(TeamDto teamDto);
	List<TeamDto> teamList(int member_no);
	void teamMemberCreate(int member_no,int team_no);
}
