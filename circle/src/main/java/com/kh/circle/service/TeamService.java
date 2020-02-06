package com.kh.circle.service;

import java.util.List;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;

public interface TeamService {
	void create(TeamDto teamDto);
	List<TopicDto> teamTopicList(int team_no);

}
