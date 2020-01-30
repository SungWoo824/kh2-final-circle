package com.kh.circle.repository;

import com.kh.circle.entity.TeamDto;

public interface TeamDao {
	
	int getSequence();
	void teamCreate(TeamDto teamDto);

}
