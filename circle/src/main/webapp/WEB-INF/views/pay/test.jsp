<h3>투표 제목			<input type="text" name="vote_create_title" placeholder="제목을 입력하세요" required></h3><br><br>
<h3>투표 설명(옵션)			<input type="text" name="vote_create_detail" placeholder="설명을 입력하세요"></h3><br><br>
<h3>보기 목록</h3><br>
<!-- <input type="text" name="vote_create_option1" placeholder="보기를 입력하세요" required><br><br> -->
<!-- <input type="text" name="vote_create_option2" placeholder="보기를 입력하세요" required><br><br> -->
<input type='text' name='category[0].vote_category_content' placeholder='보기를 입력하세요' required><br><br>
<input type='text' name='category[1].vote_category_content' placeholder='보기를 입력하세요' required><br><br>
<input type="button" value="+보기 추가" class="option"><br>
<br><br>
<h3>
복수선택</h3>	
<label class="switch">
<input type="checkbox"  class="switchp" name="vote_create_plural" value="y">
<span class="slider round"></span>
</label>
<br><br>

<h3>마감 시각			
<input type="date" name="vote_create_date" required>	
<select name="vote_create_time">
<option value="00:00">12:00 AM</option>
<option value="01:00">01:00 AM</option>
<option value="02:00">02:00 AM</option>
<option value="03:00">03:00 AM</option>
<option value="04:00">04:00 AM</option>
<option value="05:00">05:00 AM</option>
<option value="06:00">06:00 AM</option>
<option value="07:00">07:00 AM</option>
<option value="08:00">08:00 AM</option>
<option value="09:00">09:00 AM</option>
<option value="10:00">10:00 AM</option>
<option value="11:00">11:00 AM</option>
<option value="12:00">12:00 PM</option>
<option value="13:00">01:00 PM</option>
<option value="14:00">02:00 PM</option>
<option value="15:00">03:00 PM</option>
<option value="16:00">04:00 PM</option>
<option value="17:00">05:00 PM</option>
<option value="18:00">06:00 PM</option>
<option value="19:00">07:00 PM</option>
<option value="20:00">08:00 PM</option>
<option value="21:00">09:00 PM</option>
<option value="22:00">10:00 PM</option>
<option value="23:00">11:00 PM</option>
</select> </h3>
<span>
공유 대화방			
<select name="vote_create_topic" >
      <c:forEach var="topicList" items="${topicList}">
         <option value="<c:out value='${topicList }'/>"><c:out value="${topicList}"/></option>
      </c:forEach>
</select>
</span>
<br><br>
		
		<input type="hidden" name="vote_create_status" id="create" value="y">
		<input type="hidden" name="team_no" value="${param.team_no }">
		<input type="hidden" name="topic_no" value="${param.topic_no }">
		
		<input type="submit" value="만들기">

<a href="topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button>취소</button></a>