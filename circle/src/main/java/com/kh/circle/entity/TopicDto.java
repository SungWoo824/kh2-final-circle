package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TopicDto {

	private int topic_no;
	private String topic_name,
							topic_confidential,
							topic_explain,
							topic_route,
							topic_connect,
							topic_istopic;
	
}
