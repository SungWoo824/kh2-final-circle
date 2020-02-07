package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;


public interface VoteCreateDao {
	void create(VoteDto voteDto, int seq);
	void createCategory(VoteCategoryDto vcdto, int seq);
	List<String> getTopicList();
	List<VoteDto> getVoteList();
}
