package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TeamDto;

public interface TeamDao {
	
	int getSequence();
	void teamCreate(TeamDto teamDto);
	List<TeamDto> teamList(String member_email);
}
