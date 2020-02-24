package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.vo.BoardVo;

public interface ManagerDao {
	List<MemberDto> memberList(BoardVo boardVo);
	int memberListCount(BoardVo boardVo);
	int memberCount();
	int teamCount();
	int fileTotalSize();
	int managerCount();
	int paySum();
	List<TeamDto> teamList(BoardVo boardVo);
	int teamListCount(BoardVo boardVo);
}
