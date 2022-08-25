show tables;

create table notice(
	idx int not null auto_increment primary key, /* 공지사항 고유번호 */
	noticeTitle varchar(100) not null, 					 /* 공지사항 제목 */
	noticeContent text not null,								 /* 공지사항 내용 */
	nDate datetime default now(),								 /* 공지사항 작성 날짜*/
  popupSw   char(1)  default 'N'								/* 공지사항 초기화면에 개시여부 */
);

drop table notice;