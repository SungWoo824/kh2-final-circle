package com.kh.circle.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.repository.DriveFileDao;
import com.kh.circle.vo.DriveFileVO;

public class DriveFileServiceImpl implements DriveFileService{

	@Autowired
	private DriveFileDao driveFileDao;
	
	
	
	@Override
	public void upload(DriveFileVO driveFileVo) throws IllegalStateException, IOException {

		List<DriveFileDto> list = new ArrayList<>();
		
		for(MultipartFile mf : driveFileVo.getFile()) {
			int drive_file_no=driveFileDao.getSequence();
			
			list.add(DriveFileDto.builder()
												.drive_file_no(drive_file_no)
												.drive_name(driveFileVo.getDrive_name())
												.drive_file_size(mf.getSize())
												.drive_file_uploadname(mf.getOriginalFilename().toString())
												.team_no(driveFileVo.getTeam_no())
												.member_no(driveFileVo.getMember_no())
												.build());
		}
		File dir = new File("D:/upload/kh2e/drivefile");

		dir.mkdirs();
		
//		int drive_file_no = driveFileDao.getSequence();
		for(int i=0; i<list.size(); i++) {
			MultipartFile mf = driveFileVo.getFile().get(i);
			DriveFileDto driveFileDto = list.get(i);
			
			File target = new File(dir, String.valueOf(list.get(i).getDrive_file_no()));
			mf.transferTo(target);
			
			//파일 타입추가
			String mimeType=new Tika().detect(target);
			driveFileDto.setDrive_file_type(mimeType);
			
			driveFileDao.upload(driveFileDto);
		}
		
		
		
	}



	
	

		
	
}