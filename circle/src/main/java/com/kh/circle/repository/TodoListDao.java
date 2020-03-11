package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TodoListDto;
import com.kh.circle.vo.TodoListJoinVO;

public interface TodoListDao {
	int getSequence();
	void todoListCreate(TodoListDto todoListDto);
	List<TodoListJoinVO> todoPerAll(int team_no, int member_no);
	void deleteTodo(TodoListDto todoListDto);
	List<TodoListJoinVO> searchTodo(int team_no, int member_no, String todo_list_content );
	int countTodo(int team_no, int member_no);
	void editTodo(String todo_list_content ,int member_no, int todo_list_no);
	void todoDone(int member_no, int todo_list_no);
	void todoBackDone(int member_no, int todo_list_no);
}
