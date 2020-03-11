package com.kh.circle;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.circle.repository.DriveFileDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class DriveFileNoLoadTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DriveFileDao driveFileDao;
	
	@Test
	public void test() {
//		Map<String, Object> param = new HashMap<>();
//		param.put("team_no", 467);//1개씩 있을만한거 써주세요
//		param.put("drive_name", "dfs");
//		List<Integer> fileList = sqlSession.selectList("driveFile.fileList", param);
//		System.out.println("fileList: "+fileList);
		
//		List<Integer> list = Arrays.asList(614, 615, 616);
		List<Integer> list = driveFileDao.fileList(467, "dfs");
		System.out.println(list);
		
		String base = "D:/upload/kh2e/drivefile";
		for(int no : list) {
			File target = new File(base, String.valueOf(no));
			target.delete();
		}
	}
	
}
