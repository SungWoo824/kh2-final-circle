package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteCompareDto;
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
	public Object compare(int vote_create_no, int member_no) {
		VoteCompareDto voteCompareDto = VoteCompareDto.builder()
																	.vote_create_no(vote_create_no)
																	.member_no(member_no)
																	.build();
//		System.out.println(sqlSession.selectList("vote.compare", voteCompareDto).size());
		if(sqlSession.selectList("vote.compare", voteCompareDto).size() != 0) {
			return "y";
		}else {
			return "f";
		}
	}
	
	public String complete(int vote_create_no, int member_no) {
		VoteCompareDto voteCompareDto = VoteCompareDto.builder()
				.vote_create_no(vote_create_no)
				.member_no(member_no)
				.build();
		if(sqlSession.selectList("vote.complete", voteCompareDto).size() != 0) {
			return "y";
		}else {
			return "f";
		}
	}
	
	public void close(int vote_create_no) {
		sqlSession.update("vote.close", vote_create_no);
	}

	@Override
	public String status(int vote_create_no) {
		
		return sqlSession.selectOne("vote.status", vote_create_no);
	}

	@Override
	public int maxcount(int vote_create_no) {
		
		return sqlSession.selectOne("vote.maxcount", vote_create_no);
	}
	
}
