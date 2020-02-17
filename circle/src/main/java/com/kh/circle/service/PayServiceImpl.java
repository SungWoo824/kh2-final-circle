package com.kh.circle.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.circle.entity.PayDto;
import com.kh.circle.repository.PayDao;
import com.kh.circle.vo.CirclePayReadyReturnVO;
import com.kh.circle.vo.CirclePaySuccessReadyVO;
import com.kh.circle.vo.CirclePaySuccessReturnVO;
import com.kh.circle.vo.PayReadyVO;
import com.kh.circle.vo.PayRevokeReturnVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PayServiceImpl implements PayService{
	@Autowired
	private PayDao payDao;
	
	public CirclePayReadyReturnVO ready(PayReadyVO vo) throws URISyntaxException {
		
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
//		headers.add("Authorization", "KakaoAK ee569ec5c5f8caf1156df656e8f81e96");
		headers.add("Authorization", "KakaoAK ffab66bc47f1b64f6a150b2abf0f854e");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=UTF-8");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();

		body.add("cid", "TC0ONETIME");//가맹점번호(개발자용 테스트값)
//		body.add("partner_order_id", vo.getPartner_order_id());//주문번호(seq)
		body.add("partner_order_id", vo.getPartner_order_id());//주문번호(seq)
		body.add("partner_user_id", vo.getPartner_user_id());//사용자번호(member_email)
		body.add("item_name", vo.getItem_name());//상품명(1개월, 6개월, 1년)
		body.add("quantity", String.valueOf(vo.getQuantity()));//상품수량
		body.add("total_amount", String.valueOf(vo.getTotal_amount()));//상품판매가
		body.add("vat_amount", String.valueOf(vo.getVat_amount()));//부가세액(생략가능)
		body.add("tax_free_amount", String.valueOf(vo.getTax_free_amount()));//비과세액
		
		String baseUrl = ServletUriComponentsBuilder
				.fromCurrentContextPath()
				.port(8080)
				.path("/pay/")
				.toUriString();
		body.add("approval_url", baseUrl + "success");
		body.add("fail_url", baseUrl + "fail");
		body.add("cancel_url", baseUrl + "cancel");
		log.info("baseUrl={}",baseUrl);
//		헤더+바디
		HttpEntity<MultiValueMap<String, String>> entity
											= new HttpEntity<>(body, headers);
		log.info("entity={}", entity);
//		요청주소 생성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
	

//		전송 및 응답 저장
		CirclePayReadyReturnVO returnVO = 
				template.postForObject(uri, entity, CirclePayReadyReturnVO.class);
		
//		DB 관련 등록 처리 
		PayDto payDto = PayDto.builder()
				.tid(returnVO.getTid())
				.cid("TC0ONETIME")
				.approved_time(returnVO.getCreated_at())
				.partner_user_id(vo.getPartner_user_id())
				.partner_order_id(vo.getPartner_order_id())
				.item_name(vo.getItem_name())
				.quantity(vo.getQuantity())
				.total_amount(vo.getTotal_amount())
				.aid("")
				.term(vo.getTerm())
				.price(vo.getPrice())
			.build();
		payDao.insertReady(payDto);
		return returnVO;
	}

	@Override
	public CirclePaySuccessReturnVO approve(CirclePaySuccessReadyVO vo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK ffab66bc47f1b64f6a150b2abf0f854e");
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+"; charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		
//		바디 생성
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", vo.getCid());//가맹점번호(개발자용 테스트값)
		body.add("tid", vo.getTid());
		body.add("partner_order_id", vo.getPartner_order_id());
		body.add("partner_user_id", vo.getPartner_user_id());
		body.add("pg_token", vo.getPg_token());
		
		
		HttpEntity<MultiValueMap<String, String>> entity
											= new HttpEntity<>(body, headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
//		전송 및 응답 저장(PaySuccessReturnVO)
		CirclePaySuccessReturnVO returnVO = 
				template.postForObject(uri, entity, CirclePaySuccessReturnVO.class);

		PayDto payDto = PayDto.builder()
					.aid(returnVO.getAid())
					.tid(returnVO.getTid())
					.cid(returnVO.getCid())
					.partner_order_id(returnVO.getPartner_order_id())
					.partner_user_id(returnVO.getPartner_user_id())
					.approved_time(returnVO.getCreated_at())
					.item_name(returnVO.getItem_name())
					.quantity(returnVO.getQuantity())
					.total_amount(returnVO.getAmount().getTotal())
					.term(returnVO.getTerm())
					.price(returnVO.getPrice())
				.build();
		payDao.insertSuccess(payDto);
		return returnVO;
	}

	@Override
	public PayRevokeReturnVO revoke(int no) throws URISyntaxException {
		RestTemplate template=new RestTemplate();
		PayDto payDto = payDao.get(no);
		
		HttpHeaders header = new HttpHeaders();
		header.add("Authorization", "KakaoAK ee569ec5c5f8caf1156df656e8f81e96");
		header.add("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		header.add("Accept", "application/json; charset=UTF-8");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", payDto.getCid());
		body.add("tid", payDto.getTid());
		body.add("cancel_amount", String.valueOf(payDto.getTotal_amount()));
		body.add("cancel_tax_free_amount", "0");
//		body.add("cancel_vat_amount", value);
		body.add("cancel_available_amount", String.valueOf(payDto.getTotal_amount())); //현재 남은 개수 구하기
		
		HttpEntity<MultiValueMap<String, String>> entity = 
				new HttpEntity<>(body, header);
		log.info("entity={}", entity);
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		
		PayRevokeReturnVO returnVO = template.postForObject(uri, entity, PayRevokeReturnVO.class);
		
		//DB저장
		PayDto payDto2 = PayDto.builder()
//				.aid(returnVO.getAid())
//				.tid(returnVO.getTid())
//				.cid(returnVO.getCid())
//				.partner_order_id(returnVO.getPartner_order_id())
//				.partner_user_id(returnVO.getPartner_user_id())
//				.approved_time(returnVO.getCanceled_at())
//				.item_name(returnVO.getItem_name())
//				.quantity(returnVO.getQuantity())
//				.total_amount(-1 * returnVO.getCanceled_amount().getTotal())	
//				.build();
				.aid(returnVO.getAid())
				.tid(returnVO.getTid())
				.cid(returnVO.getCid())
				.partner_order_id(returnVO.getPartner_order_id())
				.partner_user_id(returnVO.getPartner_user_id())
				.approved_time(returnVO.getCreated_at())
				.item_name(returnVO.getItem_name())
				.quantity(returnVO.getQuantity())
				.total_amount(returnVO.getAmount().getTotal())
				.term(returnVO.getTerm())
				.price(returnVO.getPrice())
			.build();
		payDao.insertRevoke(payDto2);
		
		return returnVO;
	}
	
}
