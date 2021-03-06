package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TeamDto;
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

	//할일 삭제하기
	@Override
	public void deleteTodo(TodoListDto todoListDto) {
		sqlSession.delete("todoList.deleteTodo", todoListDto);
		
	}

	// 할일 제목 검색(전체에서)
	@Override
	public List<TodoListJoinVO> searchTodo(int team_no, int member_no, String todo_list_content) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.team_no(team_no)
				.member_no(member_no)
				.todo_list_content(todo_list_content)
				.build();
		return sqlSession.selectList("todoList.searchTodo", todoListJoinVO);
	}
	
	//할일 카운트
	@Override
	public int countTodo(int team_no, int member_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.team_no(team_no)
				.member_no(member_no)
				.build();
			return sqlSession.selectOne("todoList.countTodo",todoListJoinVO);
	}

	//할일 내용 수정
	@Override
	public void editTodo(String todo_list_content, int member_no, int todo_list_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.todo_list_content(todo_list_content)
				.member_no(member_no)
				.todo_list_no(todo_list_no)
				.build();
		sqlSession.update("todoList.editTodo", todoListJoinVO);
	}

	//할일 완료 시키기
	@Override
	public void todoDone(int member_no, int todo_list_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.member_no(member_no)
				.todo_list_no(todo_list_no)
				.build();
		sqlSession.update("todoList.todoDone", todoListJoinVO);
		
	}
	
	//할일 진행으로 돌리기
	@Override
	public void todoBackDone(int member_no, int todo_list_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.member_no(member_no)
				.todo_list_no(todo_list_no)
				.build();
		sqlSession.update("todoList.todoBackDone", todoListJoinVO);
		
	}

	//완료 개수 카운트
	@Override
	public int countDone(int team_no, int member_no) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.team_no(team_no)
				.member_no(member_no)
				.build();
			return sqlSession.selectOne("todoList.countDone",todoListJoinVO);
	}

	@Override
	public int countSearch(int team_no, int member_no, String todo_list_content) {
		TodoListJoinVO todoListJoinVO = TodoListJoinVO.builder()
				.team_no(team_no)
				.member_no(member_no)
				.todo_list_content(todo_list_content)
				.build();
			return sqlSession.selectOne("todoList.countSearch",todoListJoinVO);
	}

}
