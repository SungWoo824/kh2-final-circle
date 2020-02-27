package com.kh.circle;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.circle.vo.BoardVo;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class DriveFileListByTeamTest {
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		log.info("sqlSession = {}", sqlSession);
		BoardVo vo = BoardVo.builder()
													.startIndex(1)
													.countPerPage(10)
													.team_no(314)
													.drive_name("test")
											.build();
		sqlSession.selectList("driveFile.driveFileList", vo);
	}
}
