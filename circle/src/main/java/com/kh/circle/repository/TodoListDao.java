package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TodoListDto;
import com.kh.circle.vo.TodoListJoinVO;

public interface TodoListDao {
	int getSequence();
	void todoListCreate(TodoListDto todoListDto);
	List<TodoListJoinVO> todoPerAll(int member_no, int team_no);
}
