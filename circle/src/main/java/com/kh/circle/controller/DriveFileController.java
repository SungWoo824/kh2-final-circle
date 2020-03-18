package com.kh.circle.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.drew.metadata.StringValue;
import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.repository.DriveFileDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.service.CompressionUtil;
//import com.kh.circle.service.CompressionUtil;
import com.kh.circle.service.DriveFileService;
import com.kh.circle.service.Pagination;
import com.kh.circle.vo.BoardVo;
import com.kh.circle.vo.DriveFileVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/drive")
public class DriveFileController {

	@Autowired
	private DriveFileDao driveFileDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	TeamDao teamDao;
	
	@GetMapping("/drive")
	public String drive(
						HttpSession session,
						@RequestParam(defaultValue="1") int curPage,
						@ModelAttribute BoardVo boardVo,
						Model model) {
		boardVo.setMember_no((int)session.getAttribute("member_no"));
		List<DriveFileDto> folderName= driveFileDao.getFolderName(boardVo.getTeam_no());
		model.addAttribute("driveFolderName", folderName);
		model.addAttribute("team_no",boardVo.getTeam_no());
		List<DriveFileDto> folderList= driveFileDao.getFolderList(boardVo.getTeam_no(),boardVo.getDrive_name());
		model.addAttribute("driveFolderList",folderList);
		model.addAttribute("member_no",session.getAttribute("member_no"));
		model.addAttribute("memberList",teamDao.memberList(boardVo.getTeam_no()));
		List<DriveFileDto> myFolderList = driveFileDao.myFolderList(boardVo.getTeam_no(),
																(int)session.getAttribute("member_no"));
		model.addAttribute("myFolderList",myFolderList);
		
		
		
		//폴더 생성됐을때만 실행
		if(folderName != null) {
			
			//파일리스트 전체페이징
			int listCount= driveFileDao.driveFileListCount(boardVo);
			Pagination pagination = new Pagination(listCount,curPage);
			boardVo.setStartIndex(pagination.getStartIndex()+1);
			boardVo.setCountPerPage(pagination.getPageSize()+pagination.getStartIndex());

			
			//내파일리스트 페이징
			int myListCount= driveFileDao.driveMyFileListCount(boardVo);
			Pagination myFilePagination = new Pagination(myListCount,curPage);
			boardVo.setStartIndex(myFilePagination .getStartIndex()+1);
			boardVo.setCountPerPage(myFilePagination.getPageSize()+myFilePagination.getStartIndex());
			
			//전체 폴더 페이징
			int folderCount= driveFileDao.driveFolderCount(boardVo);
			Pagination folderPagination = new Pagination(folderCount,curPage);
			boardVo.setStartIndex(folderPagination .getStartIndex()+1);
			boardVo.setCountPerPage(folderPagination.getPageSize() + folderPagination.getStartIndex());
			
			//내 폴더 페이징
			int myFolderCount=driveFileDao.myDriveFolderCount(boardVo);
			Pagination myFolderPagination = new Pagination(myFolderCount,curPage);
			boardVo.setStartIndex(myFolderPagination .getStartIndex()+1);
			boardVo.setCountPerPage(myFolderPagination.getPageSize() + myFolderPagination.getStartIndex());
			
			List<DriveFileDto> driveFileList = driveFileDao.getFileList(boardVo);
			List<DriveFileDto> myFileList = driveFileDao.getMyFileList(boardVo);
			
			model.addAttribute("driveFileList",driveFileList);
			model.addAttribute("listCount",listCount);
			model.addAttribute("pagination",pagination);
			
			model.addAttribute("myFileList",myFileList);
			model.addAttribute("myListCount",myListCount);
			model.addAttribute("myFilePagination",myFilePagination);
			
			model.addAttribute("folderCount", folderCount);
			model.addAttribute("folderPagination", folderPagination);
			
			model.addAttribute("myFolderCount", myFolderCount);
			model.addAttribute("myFolderPagination", myFolderPagination);
			
//			log.info("회원번호 =  {}", boardVo.getMember_no());
//			log.info("listCount = {}", listCount);
//			log.info("myListCount = {}", myListCount);
//			log.info("{}",myFileList);
		}
		
		
		return "drive/drive";
		
	}

	
	//드라이브 이름 중복검사
	@GetMapping("/drive_namecheck")
	@ResponseBody
	public String drive_namecheck(@ModelAttribute DriveFileVO driveFileVo) {
		int count = sqlSession.selectOne("driveFile.nameCheck",driveFileVo);
		if(count>0) return "Y";
		else return "N";
	}
	

	
	//폴더 생성
	@PostMapping("/drivecreate")
	public String newFolder(@ModelAttribute DriveFileDto driveFileDto,
							@RequestParam(defaultValue = "") String drive_name,
							HttpSession session, Model model
											) {
		int drive_file_no = driveFileDao.getSequence();
		model.addAttribute("team_no",driveFileDto.getTeam_no());
		driveFileDto.setDrive_file_no(drive_file_no);
		driveFileDao.newFolder(driveFileDto);
		model.addAttribute("member_no",session.getAttribute("member_no"));
		model.addAttribute("drive_name",drive_name);
		return "redirect:../drive/drive";
	}
	
	//폴더명 변경
	@PostMapping("/editfolder")
	public String editfolder(@RequestParam int team_no,
			@RequestParam String before_name,
			@RequestParam String after_name,
			Model model){
		driveFileDao.editFolder(team_no, before_name, after_name);
		model.addAttribute("team_no",team_no);
		model.addAttribute("drive_name",after_name);
		return "redirect:../drive/drive";
	}
	
	


	@Autowired
	private DriveFileService driveFileService;
	
	//파일 업로드
	@PostMapping("/driveupload")
	public String upload(@ModelAttribute DriveFileVO driveFileVo,
										HttpSession session, Model model) throws IllegalStateException, IOException {
		int drive_file_no = driveFileDao.getSequence();
		model.addAttribute("team_no",driveFileVo.getTeam_no());
		model.addAttribute("drive_name",driveFileVo.getDrive_name());
		model.addAttribute("member_no",session.getAttribute("member_no"));
		driveFileVo.setDrive_file_no(drive_file_no);
		driveFileService.upload(driveFileVo);

		
		return "redirect:../drive/drive";
	}

	
	//드라이브 이미지 미리보기
	@GetMapping("/drive_file_view")
	public ResponseEntity<ByteArrayResource> fileview(@RequestParam int drive_file_no) throws IOException{		
		DriveFileDto driveFileDto = driveFileDao.getNum(drive_file_no);
		File target = new File("D:/upload/kh2e/drivefile",String.valueOf(driveFileDto.getDrive_file_no()));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(driveFileDto.getDrive_file_size())
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						makeDispositionString(driveFileDto.getDrive_file_uploadname()))
				.body(resource);
	}

	
	@Autowired
	private CompressionUtil util;
	
	//압축 다운로드(다중)
	@PostMapping("/zipdownload")
	public ResponseEntity<ByteArrayResource> zipDownload(@RequestParam List<Integer> drive_file_no) throws IOException{
		
		//File load
		File dest = new File("D:/upload/kh2e/drivefile/temp.zip");	//파일 압축명
		FileOutputStream out = new FileOutputStream(dest);
		
		List<File> list = new ArrayList<>();
		File dir = new File("D:/upload/kh2e/drivefile");//압축파일 임시저장소
		
		for(int i = 0; i<drive_file_no.size(); i++) {
			DriveFileDto driveFileDto = driveFileDao.getNum(drive_file_no.get(i));
			File f = new File(dir, String.valueOf(drive_file_no.get(i)));
			File copy = new File(dir, driveFileDto.getDrive_file_uploadname());
			FileUtils.copyFile(f, copy);//f를 copy로 복사해라
			list.add(copy);
		}
		
		
		//압축
		util.zip(list, out);
//		System.out.println("리스트"+list);
		
		//압축하기 전 복사한 파일을 삭제(list)
		for(int i=0; i<list.size(); i++) {
			list.remove(list.get(i));
		}
		
		
//		dest를 불러와서 전송
		byte[] data = FileUtils.readFileToByteArray(dest);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//다운로드
		return 	ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.contentLength(data.length)
						.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
						.header(HttpHeaders.CONTENT_DISPOSITION, makeDispositionString("test.zip"))
						.body(resource);
		
	}
	
	
	//다운로드 
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> download(@RequestParam int drive_file_no) throws IOException{
		DriveFileDto driveFileDto = driveFileDao.getNum(drive_file_no);
		byte[] data = driveFileDao.getUploadNo(driveFileDto.getDrive_file_no());
		ByteArrayResource resource = new ByteArrayResource(data);
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(driveFileDto.getDrive_file_size())
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						makeDispositionString(driveFileDto.getDrive_file_uploadname()))
				.body(resource);
	}

	
		private String makeDispositionString(String driveUploadName) throws UnsupportedEncodingException {
			StringBuffer buffer= new StringBuffer();
			buffer.append("attachment;");
			buffer.append("filename=");
			buffer.append("\"");
			buffer.append(URLEncoder.encode(driveUploadName,"UTF-8"));
			buffer.append("\"");
			
			return buffer.toString();
		
	}
		
	
		//드라이브 파일 다중삭제
		@PostMapping("/filelistdelete")
		public String fileDelete(@RequestParam List<Integer> drive_file_no,
								@RequestParam(defaultValue="") int team_no,
								@RequestParam(defaultValue="") String drive_name,
								Model model) {
			
			for(int i = 0; i < drive_file_no.size(); i++) {
				File target = new File("D:/upload/kh2e/drivefile/" + drive_file_no.get(i));
				target.delete();
			}
			
			driveFileDao.fileListDelete(drive_file_no);
			
			model.addAttribute("team_no",team_no);
			model.addAttribute("drive_name",drive_name);
			return  "redirect:../drive/drive";
		}
		
		//드라이브 파일 삭제
		@GetMapping("/filedelete")
		public String fileDelete(@RequestParam int drive_file_no,
								@RequestParam(defaultValue="") int team_no,
								@RequestParam(defaultValue="") String drive_name,
								Model model) {
			
			File target = new File("D:/upload/kh2e/drivefile/" + drive_file_no);
			target.delete();

			driveFileDao.fileDelete(drive_file_no);
			
			model.addAttribute("team_no",team_no);
			model.addAttribute("drive_name",drive_name);
			return  "redirect:../drive/drive";
			
		
		}
		
		
//		드라이브 폴더 삭제
		@GetMapping("/drivedelete")
		public String driveDelete(@RequestParam int team_no,
								@RequestParam String drive_name, 
								Model model) {
			
			List<Integer> fileList = driveFileDao.fileList(team_no, drive_name);
			
			for(int i = 0; i < fileList.size(); i++) {
				File target = new File("D:/upload/kh2e/drivefile/"+fileList.get(i));
				target.delete();
			}
			
			driveFileDao.driveDelete(team_no, drive_name);
			
			model.addAttribute("team_no",team_no);
			return  "redirect:/drive/drive";
		}
		
		
		
}