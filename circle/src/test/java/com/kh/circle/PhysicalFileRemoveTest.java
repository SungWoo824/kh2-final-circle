package com.kh.circle;

import java.io.File;

import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PhysicalFileRemoveTest {
	
	@Test
	public void test() {
		
//		File target = new File("D:/upload/kh2e/drivefile/"+drive_file_no);
		File target = new File("D:/upload/kh2e/drivefile", "508");
		log.info("exist = {}", target.exists());
		boolean result = target.delete();
		log.info("result = {}", result);
	}
}
