show tables;

create table review(
	idx int not null auto_increment primary key,			/* 식당 번호 */
	restaurantName varchar(100) not null,							/* 식당명 */
	grade varchar(5) not null,												/* 식당 평가 -> A:맜있다 B:괜찮다 C:별로 */
	fDate datetime default now(), 										/* 작성 날짜 */
	mid varchar(30) not null, 												/* 회원 아이디 */
	restaurantContent	text not null									/* 리뷰 소감 */
);

drop table review;
