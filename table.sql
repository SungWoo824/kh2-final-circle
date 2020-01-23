create table member(
member_no number primary key,
member_email varchar2(50) not null unique,
member_pw varchar2(20) not null,
member_name varchar2(21) not null,
member_grade varchar2(1)
);

create table member_profile(
member_profile_no number primary key,
member_no number not null unique,
member_profile_uploadname varchar2(100) not null,
member_profile_filesize number,
constraint fk_member_no foreign key(member_no) references member(member_no) on delete cascade
);

create table team(
team_no number primary key,
team_name varchar2(30) not null unique,
team_domain varchar2(50) not null unique,
team_payment date
);

create table team_member(
member_no number,
team_no number,
member_position varchar2(15) not null,
member_grade varchar2(24) not null,
constraint fk_team_member_no foreign key(member_no) references member(member_no) on delete cascade,
constraint fk_team_team_no foreign key(team_no) references team(team_no) on delete cascade
);

create table drive_file(
drive_file_no number primary key,
member_no number,
team_no number,
drive_name varchar2(50) not null,
drive_file_uploadname varchar2(100) not null,
drive_file_size number not null,
constraint fk_drive_member_no foreign key(member_no) references member(member_no) on delete cascade,
constraint fk_drive_team_no foreign key(team_no) references team(team_no) on delete cascade
);


create table topic(
topic_no number primary key,
topic_name varchar2(180) not null unique,
topic_confidential varchar2(1) not null,
topic_explain varchar2(255),
topic_route varchar2(30)  not null,
topic_connect varchar2(1),
topic_istopic varchar2(1)
);

create table topic_member(
topic_no number,
member_no number,
team_no number,
constraint fk_topic_topic_no foreign key(topic_no) references topic(topic_no) on delete cascade,
constraint fk_topic_member_no foreign key(member_no) references member(member_no) on delete cascade,
constraint fk_topic_team_no foreign key(team_no) references team(team_no) on delete cascade
);

create table todo_list(
todo_list_no number primary key,
topic_no number,
member_no,
team_no,
todo_list_content varchar2(255) not null,
constraint fk_todo_topic_no foreign key(topic_no) references topic(topic_no) on delete cascade,
constraint fk_todo_member_no foreign key(member_no) references member(member_no) on delete cascade,
constraint fk_todo_team_no foreign key(team_no) references team(team_no) on delete cascade
);

create table topic_chat_list(
topic_chat_no number primary key,
topic_chat_content varchar2(4000) not null,
topic_chat_time date default sysdate
);

create table chat_list(
chat_no number primary key,
topic_no number,
member_no number,
team_no number,
chat_content varchar2(4000),
chat_time date default sysdate,
Constraint fk_chat_topic_no foreign key(topic_no) references topic(topic_no) on delete cascade,
Constraint fk_chat_member_no foreign key(member_no) references member(member_no) on delete cascade,
Constraint fk_chat_team_no foreign key(team_no) references team(team_no) on delete cascade
);

create table chat_file(
chat_file_no number primary key,
chat_no number,
Topic_no number,
member_no number,
team_no number,
Chat_file_uploadname varchar2(50) not null,
chat_file_size number not null,
chat_file_time date not null,
Constraint fk_chat_file_chat_no foreign key(chat_no) references chat_list(chat_no) on delete cascade,
Constraint fk_chat_file_topic_no foreign key(topic_no) references topic(topic_no) on delete cascade,
Constraint fk_chat_file_member_no foreign key(member_no) references member(member_no) on delete cascade,
Constraint fk_chat_file_team_no foreign key(team_no) references team(team_no) on delete cascade
);

Create table attention(
member_no number,
Team_no number,
chat_no number,
topic_no number,
upload_member_no,
upload_team_no,
Constraint fk_attention_member_no foreign key(member_no) references member(member_no) on delete cascade,
Constraint fk_attention_team_no foreign key(team_no) references team(team_no) on delete cascade,
Constraint fk_attention_chat_no foreign key(chat_no) references chat_list(chat_no) on delete cascade,
Constraint fk_attention_topic_no foreign key(topic_no) references topic(topic_no) on delete cascade,
Constraint fk_attention_upload_member_no foreign key(upload_member_no) references member(member_no) on delete cascade,
Constraint fk_ateention_upload_team_no foreign key(upload_team_no) references team(team_no) on delete cascade
);

create sequence member_no_seq;
create sequence member_profile_no;
create sequence team_no_seq;
create sequence topic_no_seq;
create sequence todo_list_no_seq;
create sequence chat_no_seq;
create sequence chat_file_no_seq;
create sequence drive_file_no_seq;
