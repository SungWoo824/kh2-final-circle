package com.kh.circle;

import java.io.File;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.slf4j.Slf4j;

//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = {
//	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
//	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
//})
//@WebAppConfiguration
//@Slf4j
public class DriveDeleteTest {
	
	@Test
	public void test() {
		File dir = new File("D:\\upload\\kh2e\\drivefile");
		File a = new File(dir, "2a540f2b4e0bcf52f27b9e6d90f50a72.jpg");
		File b = new File(dir, "2u2l3278puw12345e61p.jpg");
		a.delete();
		b.delete();
	}
	
}
