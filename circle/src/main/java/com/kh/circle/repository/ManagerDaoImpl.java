package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
}
