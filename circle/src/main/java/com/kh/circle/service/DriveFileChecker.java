package com.kh.circle.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.repository.DriveFileDao;

@Service
public class DriveFileChecker {
	
	@Autowired
	private DriveFileDao driveFileDao;
	
	private File base = new File("D:/upload/kh2e/drivefile");

	@Scheduled(cron = "0 0 * * * *")
	public void remove() {
		//base의 모든 파일을 불러온다
		//driveFileDao의 모든 목록을 불러온다.
		//둘다 비교해서 없으면 삭제
		
		List<DriveFileDto> list = driveFileDao.getAllList();//DB목록
		List<File> fileList = new CopyOnWriteArrayList<>();
		for(File f : base.listFiles()) {
			fileList.add(f);
		}
		
		
		for(DriveFileDto dto : list) {
			for(File f : fileList) {
				if(f.getName().equals(String.valueOf(dto.getDrive_file_no()))){
					fileList.remove(f);
				}
			}
		}
		
		//fileList에 남아있는 항목을 삭제
		for(File f : fileList) {
			f.delete();
		}
		System.out.println("삭제 완료");
		
	}
	
}








