show tables;

create table member2(
  idx		int not null auto_increment,			/* 회원 고유번호 */
  mid		varchar(30) not null,					/* 회원 아이디(중복불허) */
  pwd		varchar(100) not null,					/* 비밀번호(암호화처리) */
  name		varchar(20) not null,					/* 이름 */
  nickName	varchar(20) not null,					/* 별명(중복불허) */
  gender		varchar(5)  default '남자',			/* 성별 */
  birthday	datetime		default now(),			/* 생일 */
  tel		varchar(15),							/* 전화번호(010-1234-5678) */
  address   varchar(100),							/* 주소 */
  email		varchar(50) not null,					/* 이메일(아이디/비밀번호 분실시 필요)-형식 체크할것 */
  userDel   char(2) default 'NO',					/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
  level 		int default 3,						/* 3:준회원, 2:정회원, 1:운영자, 0:관리자 */
  startDate datetime default now(),					/* 최초 가입일 */
  lastDate 	datetime default now(),					/* 마지막 접속일 */
  photo		varchar(100) default 'noimage.jpg',		/* 회원사진 */
  primary key(idx, mid)
);

desc member2;
drop table member2;
insert into member2 values(default,'admin','1234','관리몬',default,default,'010-9772-7753','충북 청주시 증안로 100','pjp8191@naver.com',default,default,default,default,default);

select * from member2;



create table visit (
  visitDate datetime not null default now(),
  visitCount			int  not null default 1
);

drop table visit;

select now();
select date(now());

insert into visit values (date(now()),default);
insert into visit values ('2022-08-05',2);
insert into visit values ('2022-08-04',5);
insert into visit values ('2022-08-03',10);
insert into visit values ('2022-08-02',12);
insert into visit values ('2022-08-01',5);
insert into visit values ('2022-07-31',3);
insert into visit values ('2022-07-30',15);

select * from visit;
select substring(visitDate,1,10) as visitDate, visitCount from visit order by visitDate desc limit 7;