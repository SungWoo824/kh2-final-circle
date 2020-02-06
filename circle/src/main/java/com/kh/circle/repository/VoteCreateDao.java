package com.kh.circle.repository;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;


public interface VoteCreateDao {
	void create(VoteDto voteDto, int seq);
	
	void createCategory(VoteCategoryDto vcdto, int seq);
}
