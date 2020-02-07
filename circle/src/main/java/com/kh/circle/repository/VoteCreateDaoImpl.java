package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;
import com.kh.circle.service.SeqService;

public class VoteCreateDaoImpl implements VoteCreateDao{

	@Autowired
	private SqlSession sqlSession;

	
	
	@Override
	public void create(VoteDto voteDto, int seq) {
		
		voteDto.setVote_create_no(seq);
		sqlSession.insert("vote.create", voteDto);
	}
//		System.out.println(voteDto);
//	@Override
//	public void createCategory(VoteCategoryDto voteCategoryDto) {
//		sqlSession.insert("vote.createCategory", voteCategoryDto);
//	}
	@Override
	public void createCategory(VoteCategoryDto vote, int seq) {
		
		vote.setVote_create_no(seq);
		sqlSession.insert("vote.createCategory", vote);
	}
	@Override
	public List<String> getTopicList() {
		return sqlSession.selectList("vote.getTopic");
	}
	
	@Override
	public List<VoteDto> getVoteList() {
		return sqlSession.selectList("vote.getVoteList");
	}
}
