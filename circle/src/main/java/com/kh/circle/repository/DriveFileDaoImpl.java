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
import com.kh.circle.vo.BoardVo;
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
	public List<DriveFileDto> getFolderList(int team_no, String drive_name) {
		Map<String, Object> param = new HashMap<>();
		param.put("team_no", team_no);
		param.put("drive_name", drive_name);
		return sqlSession.selectList("driveFile.driveFolderList", param);
	}
	
	@Override
	public List<DriveFileDto> getFolderName(int team_no) {
		return sqlSession.selectList("driveFile.driveFolderName", team_no);
	}

	//드라이브파일 목록 가져오기
	@Override
	public List<DriveFileDto> getFileList(BoardVo boardVo) {
		return sqlSession.selectList("driveFile.driveFileList", boardVo);
	}

	@Override
	public int driveListCount(BoardVo boardVo) {
		return 0;
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

	@Override
	public void fileEdit(int drive_file_no, String drive_file_uploadname) {
		Map<String, Object> param = new HashMap<>();
		param.put("drive_file_no", drive_file_no);
		param.put("drive_file_uploadname", drive_file_uploadname);
		sqlSession.update("driveFile.fileEdit", param);
		
	}


	//드라이브 파일 검색
//	@Override
//   public List<DriveFileDto> driveList(String keyword,int start, int finish) throws Exception {
//      Map<String, Object> map = new HashMap<>();
//      map.put("keyword",keyword);
//      map.put("start",start);
//      map.put("finish",finish);
//      return sqlSession.selectList("driveFile.driveList",map);
//   }





	
	
	
}