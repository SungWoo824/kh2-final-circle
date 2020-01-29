package com.kh.circle.repository;

import com.kh.circle.entity.TeamDto;

public interface TeamDao {
	
	int getSequence(TeamDto teamDto);
	void teamCreate(TeamDto teamDto);

}
