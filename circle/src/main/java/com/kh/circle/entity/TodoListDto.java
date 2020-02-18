package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TodoListDto {
	private int todo_list_no, topic_no,member_no,team_no;
	private String todo_list_content;

}
