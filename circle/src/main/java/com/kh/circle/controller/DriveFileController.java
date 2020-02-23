package com.kh.circle.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

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

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.repository.DriveFileDao;
import com.kh.circle.service.DriveFileService;
import com.kh.circle.vo.DriveFileVO;


@Controller
@RequestMapping("/drive")
public class DriveFileController {

	@Autowired
	private DriveFileDao driveFileDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@GetMapping("/drive")
	public String drive(@RequestParam int team_no, @RequestParam int member_no) {
		return "drive/drive";
	}

	@PostMapping("/drive")
	public String drive(@ModelAttribute DriveFileVO driveFileVo) {
		return "redirect:../drive/drive_create?member_no="+driveFileVo.getMember_no()+"&team_no="+driveFileVo.getTeam_no()+"&drive_name="+driveFileVo.getDrive_name();
	}
	
	
	//드라이브 이름 중복검사
	@GetMapping("/drive_namecheck")
	@ResponseBody
	public String drive_namecheck(@ModelAttribute DriveFileVO driveFileVo) {
		int count = sqlSession.selectOne("driveFile.nameCheck",driveFileVo);
//		System.out.println(driveFileVo.getTeam_no());
		if(count>0) return "Y";
		else return "N";
	}
	
	
	//파일 업로드
	@GetMapping("/drive_create")
	public String upload(@RequestParam int team_no, @RequestParam int member_no) {
		return "drive/drive_create";
	}

	@Autowired
	private DriveFileService driveFileService;
	
	@PostMapping("/drive_create")
	public String upload(@ModelAttribute DriveFileVO driveFileVo) throws IllegalStateException, IOException {
		driveFileService.upload(driveFileVo);
		return "redirect:/drive/drive_view?team_no="+driveFileVo.getTeam_no()+"&drive_name="+driveFileVo.getDrive_name();
	}


	
	//드라이브 폴더 목록
	@GetMapping("/drive_folderlist")
	public String folderlist(Model model, @RequestParam int team_no) {
		List<DriveFileDto> folderlist = driveFileDao.getFolder(team_no);
		model.addAttribute("driveFolderList",folderlist);
		return "drive/drive_folderlist";
	}
	
	//드라이브 목록 이미지 미리보기
	@GetMapping("/drive_file_view")
	public ResponseEntity<ByteArrayResource> fileview(@RequestParam int drive_file_no) throws IOException{		
		DriveFileDto driveFileDto = driveFileDao.get(drive_file_no);
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
	
	//다운로드
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> download(@RequestParam int drive_file_no) throws IOException{
		DriveFileDto driveFileDto = driveFileDao.get(drive_file_no);
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
	
		
	
		//팀 드라이브 파일 목록
		@GetMapping("/drive_view")
		public String driveview(@ModelAttribute DriveFileVO driveFileVo,
													Model model) throws IOException{		
			List<DriveFileDto> fileList = driveFileDao.get2(driveFileVo);
			model.addAttribute("fileList", fileList);
			
			return "drive/drive_view";
		}
		
		//드라이브 파일삭제
		@GetMapping("/filedelete")
		public String fileDelete(@ModelAttribute DriveFileVO driveFileVo) {
			driveFileDao.fileDelete(driveFileVo.getDrive_file_no());
			File target = new File("D:/upload/kh2e/drivefile/"+driveFileVo.getDrive_file_no());
			target.delete();
			return  "redirect:/drive/drive_view?team_no="+driveFileVo.getTeam_no()+"&drive_name="+driveFileVo.getDrive_name();
		}
		
//		드라이브 파일 일괄 삭제
//		@GetMapping("/drivedelete")
//		public String driveDelete(@ModelAttribute DriveFileVO driveFileVo, Model model) {
//			
//			List<DriveFileDto> fileList = driveFileDao.get2(driveFileVo);
//			model.addAttribute("fileList", fileList);
//			for(int i = 0; i < fileList.size(); i++) {
//				driveFileDao.driveDelete(driveFileVo);
////				driveFileDao.fileDelete(driveFileVo.getDrive_file_no());
//				File target = new File("D:/upload/kh2e/drivefile/"+driveFileVo.getDrive_file_no());
//				target.delete();
//			}
//			
//			return  "redirect:/drive/drive_folderlist?team_no="+driveFileVo.getTeam_no();
//		}
		
		
		
}