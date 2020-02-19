package com.kh.circle.service;

import java.io.IOException;

import com.kh.circle.vo.DriveFileVO;

public interface DriveFileService {

	void upload(DriveFileVO driveFileVo) throws IllegalStateException, IOException;
	
}