package com.kh.circle.service;

import java.text.DecimalFormat;

import org.springframework.stereotype.Service;

@Service
public class ManagerService {
	public static String sizeCalculation(long size) {
	    String CalcuSize = null;
	    int i = 0;

	    double calcu = (double) size;
	    while (calcu >= 1024 && i < 5) { // 단위 숫자로 나누고 한번 나눌 때마다 i 증가
	        calcu = calcu / 1024;
	        i++;
	    }
	    DecimalFormat df = new DecimalFormat("##0.0");
	    switch (i) {
	        case 0:
	            CalcuSize = df.format(calcu) + "Byte";
	            break;
	        case 1:
	            CalcuSize = df.format(calcu) + "KB";
	            break;
	        case 2:
	            CalcuSize = df.format(calcu) + "MB";
	            break;
	        case 3:
	            CalcuSize = df.format(calcu) + "GB";
	            break;
	        case 4:
	            CalcuSize = df.format(calcu) + "TB";
	            break;
	        default:
	            CalcuSize="ZZ"; //용량표시 불가

	    }
	    return CalcuSize;
	}

}