package com.kh.circle.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class DriveFileVO {

	private int member_no, team_no, drive_file_no;
	private String drive_name;
	private List<MultipartFile> file;
	
}