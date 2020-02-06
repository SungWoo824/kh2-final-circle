package com.kh.circle.repository;

import com.kh.circle.entity.TeamMemberDto;

public interface TeamMemberDao {
	
	//team_member table에 등록 시키는 메소드
	void registTeamMember(TeamMemberDto teamMemberDto);

}
