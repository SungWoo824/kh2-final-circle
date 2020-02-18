package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TodoListDto;

@Repository
public class TodoListImpl implements TodoListDao {
	
	@Autowired SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("todoList.getSequence");
	}

	@Override
	public void todoListCreate(TodoListDto todoListDto) {
		sqlSession.insert("todoList.todoListCreate", todoListDto);
	}

}
