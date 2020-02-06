package com.kh.circle.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;

public class TeamServiceImpl implements TeamService {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public void create(TeamDto teamDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TopicDto> teamTopicList(int team_no) {
		
		return sqlSession.selectList("topic.teamTopicList", team_no);
	}

}
