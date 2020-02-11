package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;
import com.kh.circle.entity.VoteSelectionDto;

public class VoteCreateDaoImpl implements VoteCreateDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void create(VoteDto voteDto, int seq) {
		voteDto.setVote_create_no(seq);
		sqlSession.insert("vote.create", voteDto);
	}

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
	@Override
	public List<VoteDto> getVoteDetail(int vote_create_no) {
		return sqlSession.selectList("vote.getVoteDetail", vote_create_no);
	}
	@Override
	public List<VoteCategoryDto> getVoteCategoryDetail(int vote_create_no) {
		return sqlSession.selectList("vote.getVoteCategoryDetail", vote_create_no);
	}

	@Override
	public String getMemberName(int member_no) {
		return sqlSession.selectOne("vote.getMemberName", member_no);
	}

	@Override
	public void selection(int member_no, int vote_create_no, String content, String selection, String name) {
		VoteSelectionDto voteSelectionDto = VoteSelectionDto.builder()
																.member_no(member_no)
																.vote_create_no(vote_create_no)
																.vote_category_content(content)
																.vote_select_true(selection)
																.member_name(name)
																.build();
		sqlSession.insert("vote.selection", voteSelectionDto);
	}

	@Override
	public Object compare(int member_no) {
		if(sqlSession.selectList("vote.compare", member_no) != null) {
			return "y";
		}else {
			return "f";
		}
	}
	
}
