package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.vo.BoardVo;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ManagerDaoImpl implements ManagerDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberDto> memberList(BoardVo boardVo) {
		return sqlSession.selectList("member.memberList", boardVo);
	}

	@Override
	public int memberCount() {
		return sqlSession.selectOne("member.memberCount");
	}

	@Override
	public int teamCount() {
		return sqlSession.selectOne("team.teamCount");
	}

	@Override
	public int fileTotalSize() {
		return sqlSession.selectOne("driveFile.fileTotalSize");
	}
	

	@Override
	public int managerCount() {
		return sqlSession.selectOne("member.managerCount");
	}

	@Override
	public int paySum() {
		
		return sqlSession.selectOne("pay.paySum");
	}

	@Override
	public List<TeamDto> teamList(BoardVo boardVo) {
		return sqlSession.selectList("team.managerTeamList", boardVo);
	}

	@Override
	public int memberListCount(BoardVo boardVo) {
		return sqlSession.selectOne("member.memberListCount", boardVo);
	}

	@Override
	public int teamListCount(BoardVo boardVo) {
		return sqlSession.selectOne("team.managerTeamListCount",boardVo);
	}
	

	@Override
	public void memberAdminGrant(int member_no) {
		sqlSession.update("member.adminGrant", member_no);
	}

	@Override
	public List<DriveFileDto> teamFileTotalSize() {
		return sqlSession.selectList("driveFile.teamFileTotalSize");
	}

	@Override
	public List<Integer> teamMemCount() {
		return sqlSession.selectList("team.teamMemCount");
	}
	public int currentUserCount() {
		
		return 0;
	}

	
}
