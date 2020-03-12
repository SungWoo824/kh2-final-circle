package com.kh.circle.repository;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.vo.ChatFileVo;
import com.kh.circle.vo.ChatVo;

public interface ChatDao {
	void chatDataSave(ChatVo chatVo);
	List<ChatVo> topicChatList(int topic_no);
	List<Integer> memberContainTopic(int member_no,int team_no);
	void chatFileUpload(ChatFileVo chatFileVo,MultipartFile multipartFile) throws IllegalStateException, IOException;
	ChatFileVo sendChatFile(int chat_file_no);
	ChatFileVo chatFileDownload(int chat_file_no);
	byte[] getUploadNo(int chat_file_no) throws IOException;
}
