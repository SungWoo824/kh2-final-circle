package com.kh.circle.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.TodoListDto;
import com.kh.circle.repository.TodoListDao;
import com.kh.circle.vo.TodoListJoinVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat")
@Slf4j
public class TodoListController {
	
	@Autowired private TodoListDao todoListDao;
	
	//투두 리스트 반복문 출력 
		@GetMapping("/todo_list_main")
		public String todo_list_create(@RequestParam int team_no, 
									   @RequestParam int topic_no,
									   @ModelAttribute TodoListDto todoListDto,
									   @ModelAttribute TodoListJoinVO todoListJoinVO,  
									   Model model, HttpSession session) {
		
			model.addAttribute("team_no", team_no);
			int member_no = (int)session.getAttribute("member_no");		
				
			//할일 목록 출력
			model.addAttribute("todoPerAll", todoListDao.todoPerAll(team_no,member_no));
			
			//할일 전체 개수 출력 
			model.addAttribute("countTodo", todoListDao.countTodo(team_no, member_no));
			

			return "chat/todo_list_main";
	}
		//투두 리스트 할일 등록 
		@PostMapping("/todo_list_create")
		public String todo_list_create(@RequestParam int team_no, 
									   @RequestParam int topic_no,
									   @ModelAttribute TodoListDto todoListDto,
									   @ModelAttribute TodoListJoinVO todoListJoinVO,
									   HttpSession session , Model model) {
			//멤버 세션 받아오기
			int member_no = (int)session.getAttribute("member_no");

			
			//todo_list_content 받아오기 
			String todo_list_content = todoListDto.getTodo_list_content();
			
			//투두 리스트 겟 시퀀스 생성
			 int todo_list_no =todoListDao.getSequence();
			

			 //추가를 하면서 다음 리다이렉트 페이지에 데이터 넘겨주기
			 model.addAttribute("team_no", team_no); 
			 model.addAttribute("topic_no", topic_no);
			//할일 추가하기 
			todoListDto = TodoListDto.builder()
						.todo_list_no(todo_list_no)
						.topic_no(topic_no)
						.member_no((int) session.getAttribute("member_no"))
						.team_no(team_no)
						.todo_list_content(todo_list_content)
						.build();

			//할일 추가하면 DB에 등록
			todoListDao.todoListCreate(todoListDto);
			
			//리스트 보내기
			model.addAttribute("todoPerAll", todoListDao.todoPerAll(team_no,member_no));
//			log.info("todoListJoinVO={}",todoListJoinVO);
			return "redirect:./topic_main";
		}

		
		
		//투두 리스트에서 목록 누르면 / 상세보기 
		@GetMapping("/todo_list_detail")
		public String todo_list_detail(@RequestParam int team_no, @RequestParam String todo_list_content, Model model) {
			model.addAttribute("team_no", team_no);
			model.addAttribute("todo_list_content", todo_list_content);
			
			
			
			return "chat/todo_list_detail";
		}
		
		//투두 리스트 검색 중
		@PostMapping("/todo_list_search")
		public String todo_list_search(@RequestParam int team_no,
										@RequestParam String todo_list_content,
										@ModelAttribute TodoListJoinVO todoListJoinVO,
										Model model, HttpSession session) {
			int member_no = (int)session.getAttribute("member_no");
			model.addAttribute("team_no", team_no);
			model.addAttribute("todo_list_content", todo_list_content);
			
			//검색하기 리스트 보내기
			model.addAttribute("searchTodo", todoListDao.searchTodo(team_no,member_no, todo_list_content));
			log.info("todoListJoinVO={}",todoListJoinVO);
			
			return "redirect:./todo_list_search";
		}
		
		//투두 리스트 검색 결과 반영(동기)
		@GetMapping("/todo_list_search")
		public String todo_list_search(@RequestParam int team_no,
										@RequestParam String todo_list_content,
										Model model, HttpSession session
										) {
			int member_no = (int)session.getAttribute("member_no");
			model.addAttribute("team_no", team_no);
			model.addAttribute("todo_list_content", todo_list_content);
			
			//검색하기 리스트 받기 
			model.addAttribute("searchTodo", todoListDao.searchTodo(team_no,member_no, todo_list_content));

			return "chat/todo_list_search";
		}
		
		//검색 결과 비동기로 받기 
		@PostMapping("/todo_list_search_result")
		public String todo_list_search(@RequestParam int team_no,
									   @RequestParam int member_no,
									   @RequestParam String todo_list_content,
									   Model model) {
			model.addAttribute("searchTodo", todoListDao.searchTodo(team_no, member_no, todo_list_content));

			return "chat/todo_list_search_result";
		}
			
		
		//투두리스트 삭제 
		@PostMapping("/todo_list_delete")
		public String todo_list_delte(HttpSession session, Model model,
				@RequestParam int team_no, @RequestParam int topic_no, @RequestParam int todo_list_no) {
			//메인으로 정보 전송
			model.addAttribute("team_no", team_no);
			model.addAttribute("topic_no", topic_no);
			model.addAttribute("todo_list_no",todo_list_no);
//			model.addAttribute("todo_list_content", todo_list_content);
			int member_no = (int)session.getAttribute("member_no");

			
			//할일 삭제하기 
			TodoListDto todoListDto = TodoListDto.builder()
					.member_no(member_no)
					.todo_list_no(todo_list_no)
					.build();
			todoListDao.deleteTodo(todoListDto);
			
			return "redirect:./todo_list_main";
		}
		
		//할일 수정(list_detail-> 에서 옴)
		@PostMapping("/todo_list_edit")
		public String todo_list_edit(@RequestParam String todo_list_content,
									 @RequestParam int todo_list_no, 
									 @RequestParam int team_no,
									 @RequestParam int topic_no,
									 HttpSession session, Model model) {
			//필요 데이터 보내기 
			model.addAttribute("team_no", team_no);
			model.addAttribute("topic_no", topic_no);
			model.addAttribute("todo_list_content", todo_list_content);
			model.addAttribute("todo_list_no", todo_list_no);
			int member_no = (int)session.getAttribute("member_no");
			
			//할일 수정하기
			todoListDao.editTodo(todo_list_content, member_no, todo_list_no);
			return "redirect:./todo_list_detail";
		}
		
		//할일 완료 시키기
		@PostMapping("/todo_done")
		public String todo_done(@RequestParam int team_no,
								@RequestParam int topic_no,
								@ModelAttribute TodoListDto todoListDto,
								HttpSession session, Model model) {
			
			//보낼 데이터들
			int member_no = (int)session.getAttribute("member_no");
			model.addAttribute("team_no", team_no);
			model.addAttribute("topic_no", topic_no);	
			
			
			//완료 메소드 실행
			int todo_list_no = todoListDto.getTodo_list_no();
			todoListDao.todoDone(member_no, todo_list_no);
			
			return "redirect:./todo_list_main";
		}
		
		@GetMapping("/todo_done")
		public String todo_done(@RequestParam int team_no,
								
								Model model, HttpSession session) {
			
			int member_no = (int)session.getAttribute("member_no");
			//할일 목록 출력
			model.addAttribute("todoPerAll", todoListDao.todoPerAll(team_no,member_no));
					
			return "chat/todo_done";
		}
				
		
		//할일 진행으로 돌리기
		@PostMapping("/todo_back_done")
		public String todo_back_done(@RequestParam int team_no,
									 @RequestParam int topic_no,
									 @ModelAttribute TodoListDto todoListDto,
									 
									 HttpSession session, Model model) {
			//보낼 데이터들
			int member_no = (int)session.getAttribute("member_no");
			model.addAttribute("team_no", team_no);
			model.addAttribute("topic_no", topic_no);		

			//할일 진행중으로 다시 바꾸기 
			int todo_list_no = todoListDto.getTodo_list_no();
			todoListDao.todoBackDone(member_no, todo_list_no);

			return "redirect:./todo_list_main";
		}	

}
