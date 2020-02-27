package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class TodoListJoinVO {
	private String member_name, member_email,member_position;
	private int member_no, team_no, topic_no,todo_list_no;
	private String  todo_list_content, topic_name;

}
