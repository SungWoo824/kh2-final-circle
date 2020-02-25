package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;


public interface VoteCreateDao {
	void create(VoteDto voteDto, int seq);
	void createCategory(VoteCategoryDto vcdto, int seq);
	List<String> getTopicList(int member_no);
	List<VoteDto> getVoteList();
	List<VoteDto> getVoteDetail(int vote_create_no);
	List<VoteCategoryDto> getVoteCategoryDetail(int vote_create_no);
	String getMemberName(int member_no);
	void selection(int member_no, int vote_create_no, String content, String selection, String name);
	Object compare(int vote_create_no, int member_no); 
	String complete(int vote_create_no, int member_no);
	void close(int vote_create_no);
	String status(int vote_create_no);
	Object maxcount(int vote_create_no);
	List<VoteDto> selectNullCheck(int vote_create_no);
}
