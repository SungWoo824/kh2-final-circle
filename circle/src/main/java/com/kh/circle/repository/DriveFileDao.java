package com.kh.circle.repository;

import java.io.IOException;
import java.util.List;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.vo.DriveFileVO;

public interface DriveFileDao {


	int getSequence();
	void upload(DriveFileDto driveFileDto);
	void newFolder(DriveFileDto driveFileDto);
	DriveFileDto getNum(int drive_file_no);
	List<DriveFileDto> getFileList(int team_no, String drive_name);
	byte[] getUploadNo(int drive_file_no) throws IOException;
//	void driveDelete(String drive_name);
	void fileDelete(int drive_file_no);
	List<DriveFileDto>  getFolderList(int team_no);
	void driveDelete(DriveFileVO driveFileVo);
}