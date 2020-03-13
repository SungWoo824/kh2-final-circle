package com.kh.circle.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.repository.ManagerDao;
import com.kh.circle.service.ManagerService;
import com.kh.circle.service.Pagination;
import com.kh.circle.vo.BoardVo;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/manager")
@Slf4j
public class ManagerController {
	
	@Autowired
	private ManagerDao managerDao;
	
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("memberCount", managerDao.memberCount());
		model.addAttribute("teamCount", managerDao.teamCount());
		model.addAttribute("fileTotalSize",managerDao.fileTotalSize());
		model.addAttribute("managerCount", managerDao.managerCount());
		model.addAttribute("profit",managerDao.profit());			

		return "manager/main";
	}
	
	@GetMapping("/member")
	public String member(Model model,
						HttpSession session,
						@RequestParam(defaultValue="1") int curPage,
						@ModelAttribute BoardVo boardVo) {
		int listCount = managerDao.memberListCount(boardVo);
		
		Pagination pagination = new Pagination(listCount, curPage);
		
		boardVo.setStartIndex(pagination.getStartIndex()+1);
		boardVo.setCountPerPage(pagination.getPageSize()+pagination.getStartIndex());
		List<MemberDto> memberList = managerDao.memberList(boardVo);
		
		model.addAttribute("listCount", listCount);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pagination", pagination);
		return "manager/member";
	}
	
	@GetMapping("/profit")
	public String payment(Model model,
			HttpSession session,
			@RequestParam(defaultValue="1") int curPage,
			@ModelAttribute BoardVo boardVo) {
		
		int listCount = managerDao.profitListCount(boardVo);
		Pagination pagination = new Pagination(listCount, curPage);
		
		boardVo.setStartIndex(pagination.getStartIndex()+1);
		boardVo.setCountPerPage(pagination.getPageSize()+pagination.getStartIndex());
		
		model.addAttribute("profitList",managerDao.profitList());
		model.addAttribute("listCount", listCount);
		model.addAttribute("pagination", pagination);
		return "manager/profit";
	}
	
	@Autowired
	private ManagerService managerService;
	
	@GetMapping("/team")
	public String team(Model model,
					@RequestParam(defaultValue="1") int curPage,
					@ModelAttribute BoardVo boardVo) {
		int listCount = managerDao.teamListCount(boardVo);
		
		Pagination pagination = new Pagination(listCount, curPage);
		
		boardVo.setStartIndex(pagination.getStartIndex()+1);
		boardVo.setCountPerPage(pagination.getPageSize()+pagination.getStartIndex());

		List<TeamDto> teamList = managerDao.teamList(boardVo);
		List<DriveFileDto> teamFileTotalSize = managerDao.teamFileTotalSize();
//		System.out.println(teamFileTotalSize);
		
		List<String> teamFileSizeList = new ArrayList<>();
		
		for(DriveFileDto driveFileDto : teamFileTotalSize) {
			String cal = managerService.sizeCalculation(driveFileDto.getDrive_file_size());
			teamFileSizeList.add(cal);
		}
		
		List<Integer> teamMemCount=managerDao.teamMemCount();
		model.addAttribute("teamMemCount",teamMemCount);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pagination", pagination);
		model.addAttribute("teamList", teamList);
		model.addAttribute("teamFileSizeList",teamFileSizeList);
		
		return "manager/team";
	}
	@GetMapping("/admin")
	public String admin(Model model,
						HttpSession session,
						@RequestParam(defaultValue="1") int curPage,
						@ModelAttribute BoardVo boardVo) {
		int listCount = managerDao.memberListCount(boardVo);
		
		Pagination pagination = new Pagination(listCount, curPage);
		
		boardVo.setStartIndex(pagination.getStartIndex()+1);
		boardVo.setCountPerPage(pagination.getPageSize()+pagination.getStartIndex());
		List<MemberDto> memberList = managerDao.memberList(boardVo);
		
		model.addAttribute("listCount", listCount);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pagination", pagination);
	
		return "manager/admin";
	}
	
	@GetMapping("/adminGrant")
	public String adminGrant(@RequestParam int member_no) {
		managerDao.memberAdminGrant(member_no);
		
		return "redirect:./admin?type=&value=";
	}
}
