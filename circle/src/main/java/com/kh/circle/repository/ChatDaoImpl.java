package com.kh.circle.repository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.vo.ChatFileVo;
import com.kh.circle.vo.ChatVo;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void chatDataSave(ChatVo chatVo) {
		chatVo.setChat_no(sqlSession.selectOne("chat.getSequence"));
		sqlSession.insert("chat.insert", chatVo);
	}

	@Override
	public List<ChatVo> topicChatList(int topic_no) {
		
		return sqlSession.selectList("chat.topicChatList", topic_no);
	}

	@Override
	public List<Integer> memberContainTopic(int member_no, int team_no) {
		Map<String,Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("team_no", team_no);
		
		return sqlSession.selectList("chat.memberContainTopic", param);
	}

	@Override
	public void chatFileUpload(ChatFileVo chatFileVo, MultipartFile multipartFile) throws IllegalStateException, IOException {
		
		File dir = new File("D:/upload/kh2e/chatFile");
	    dir.mkdirs();
	    File target = new File(dir, String.valueOf(chatFileVo.getChat_file_no()));
	    multipartFile.transferTo(target);
	    String mimeType = new Tika().detect(target);
	    chatFileVo.setChat_file_type(mimeType);
	    sqlSession.insert("chat.fileinsert", chatFileVo);
		
	}

	@Override
	public ChatFileVo sendChatFile(int chat_file_no) {
		
		return sqlSession.selectOne("chat.sendChatFile", chat_file_no);
	}
	
}
