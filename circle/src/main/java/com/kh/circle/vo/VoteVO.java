package com.kh.circle.vo;

import java.util.List;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class VoteVO {
//	private String vote_create_title;
	private String vote_create_title;
	private String vote_create_detail;
	private String vote_create_anonymous;
	private String vote_create_plural;
	private String vote_create_status;
	private String vote_create_date;
	private String vote_create_time;
	private String vote_create_topic;
	private int vote_create_userno;
	private int vote_create_no;
	private List<VoteCategoryDto> category;
	private VoteCategoryDto voteCategoryDto;
}
