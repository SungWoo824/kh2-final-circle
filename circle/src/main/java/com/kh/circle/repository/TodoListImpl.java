package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TodoListDto;
import com.kh.circle.vo.TodoListJoinVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class TodoListImpl implements TodoListDao {
	
	@Autowired SqlSession sqlSession;
	
	//투두리스트 겟 시퀀스
	@Override
	public int getSequence() {
		return sqlSession.selectOne("todoList.getSequence");
	}
	
	//투두 리스트 DB에 추가 
	@Override
	public void todoListCreate(TodoListDto todoListDto) {
		sqlSession.insert("todoList.todoListCreate", todoListDto);
	}

	//투두 리스트 목록 반복문
	@Override
	public List<TodoListJoinVO> todoPerAll(int team_no, int member_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
										.team_no(team_no)
										.member_no(member_no)
										.build();
		log.info("todoListJoinVO={}",todoListJoinVO);
		return sqlSession.selectList("todoList.todoPerAll", todoListJoinVO);
	}

	@Override
	public void deleteTodo(TodoListDto todoListDto) {
		sqlSession.delete("todoList.deleteTodo", todoListDto);
		
	}

}
