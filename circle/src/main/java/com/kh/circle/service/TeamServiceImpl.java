package com.kh.circle.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;
import com.kh.circle.repository.PayDao;

@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	PayDao payDao;
	@Override
	public void create(TeamDto teamDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TopicDto> teamTopicList(int team_no) {
		
		return sqlSession.selectList("topic.teamTopicList", team_no);
	}

	@Override
	public int timeDifference(int term) throws ParseException {
		SimpleDateFormat todaySdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		//한국기준 날짜
		Calendar calendar = Calendar.getInstance();
		Date date =  new Date(calendar.getTimeInMillis());
		todaySdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
		String todayDate = todaySdf.format(date);
		long todayTimestamp = todaySdf.parse(todayDate).getTime();
		Date date2 = new Date(todayTimestamp);
		String todayDate2 = todaySdf.format(date2);
		
		//데이터베이스에서 가져온 구매날짜
		
		
		return 0;
	}
	
	
}
