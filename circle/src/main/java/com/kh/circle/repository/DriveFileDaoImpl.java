package com.kh.circle.repository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.*;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.vo.DriveFileVO;

@Repository
public class DriveFileDaoImpl implements DriveFileDao{

	private File dir = new File("D:/upload/kh2e/drivefile");
	
	@PostConstruct
	public void init() {
		dir.mkdirs();
	}
	
	@Autowired
	private SqlSession sqlSession;

	//폴더만 생성
	@Override
	public void newFolder(DriveFileDto driveFileDto) {
		sqlSession.insert("driveFile.newFolder", driveFileDto);
	}
	
	//파일 업로드 
	@Override
	public void upload(DriveFileDto driveFileDto) {
		sqlSession.insert("driveFile.upload",driveFileDto);
	}


	@Override
	public int getSequence() {
		return sqlSession.selectOne("driveFile.getSeq");
	}


	//디렉토리 파일번호 가져오기
	@Override
	public byte[] getUploadNo(int drive_file_no) throws IOException {
		File file = new File(dir, String.valueOf(drive_file_no));
		byte[] data = FileUtils.readFileToByteArray(file);
		return data;
	}

	//DB파일 번호 가져오기
	@Override
	public DriveFileDto getNum(int drive_file_no) {
		return sqlSession.selectOne("driveFile.getFileNo", drive_file_no);
	}

	//팀 드라이브폴더 목록 가져오기
	@Override
	public List<DriveFileDto> getFolderList(int team_no) {
		return sqlSession.selectList("driveFile.driveFolderList", team_no);
	}

	//드라이브파일 목록 가져오기
	@Override
	public List<DriveFileDto> getFileList(int team_no, String drive_name) {
		Map<String, Object> param = new HashMap<>();
		param.put("team_no", team_no);
		param.put("drive_name", drive_name);
		return sqlSession.selectList("driveFile.driveFileList", param);
	}

	//드라이브파일 삭제
	@Override
	public void fileDelete(int drive_file_no) {
		sqlSession.delete("driveFile.fileDelete",drive_file_no);
	}
	
	//드라이브 폴더 일괄 삭제
	@Override
	public void driveDelete(DriveFileVO driveFileVo) {
		sqlSession.delete("driveFile.driveDelete",driveFileVo);
	}





	
	
	
}