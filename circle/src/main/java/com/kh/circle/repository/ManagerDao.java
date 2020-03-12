package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.PayDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.vo.BoardVo;

public interface ManagerDao {
	List<MemberDto> memberList(BoardVo boardVo);
	int memberListCount(BoardVo boardVo);
	int memberCount();
	int teamCount();
	int fileTotalSize();
	int teamFileTotalSize(int team_no);
	int managerCount();
	int paySum();
	List<TeamDto> teamList(BoardVo boardVo);
	int teamListCount(BoardVo boardVo);
	void memberAdminGrant(int member_no);
	int profit();
	List<PayDto> profitList();
	int profitListCount(BoardVo boardVo);
}
