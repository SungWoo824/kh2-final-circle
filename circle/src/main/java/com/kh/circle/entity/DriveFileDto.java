package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class DriveFileDto {

	private int drive_file_no, member_no, team_no;
	private long drive_file_size;
	private String drive_name, drive_file_uploadname;
	
}