package com.kh.circle.service;

import java.net.URISyntaxException;

import com.kh.circle.vo.CirclePayReadyReturnVO;
import com.kh.circle.vo.CirclePaySuccessReadyVO;
import com.kh.circle.vo.CirclePaySuccessReturnVO;
import com.kh.circle.vo.PayReadyVO;

public interface PayService {
	CirclePayReadyReturnVO ready(PayReadyVO vo) throws URISyntaxException;
	CirclePaySuccessReturnVO approve(CirclePaySuccessReadyVO vo) throws URISyntaxException;
}
