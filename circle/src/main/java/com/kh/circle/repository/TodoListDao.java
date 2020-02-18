package com.kh.circle.repository;

import com.kh.circle.entity.TodoListDto;

public interface TodoListDao {
	int getSequence();
	void todoListCreate(TodoListDto todoListDto);

}
