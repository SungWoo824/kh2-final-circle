package com.kh.circle.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class RandomServiceImpl implements RandomService{

	@Override
	public String generateCertificationNumber(int size) {
		StringBuffer buffer = new StringBuffer();
		Random r = new Random();
		
		for(int i = 0 ; i < size ; i++) {
			buffer.append(r.nextInt(10));
		}
		
		return buffer.toString();
	}

}
