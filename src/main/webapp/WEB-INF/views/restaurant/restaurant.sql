show tables;

create table restaurant (
	idx int  not null auto_increment,												/* 식당 고유번호*/
	restaurantName varchar(100) not null,										/* 식당명 */
	restaurantContent varchar(200),													/* 식당소개 */
	restaurantNumber varchar(15) not null,									/* 식당 전화번호 */
	foodCategory varchar(100) not null default '',					/* 음식 종류 */
	foodPrice varchar(100) not null default 0, 							/* 음식 가격 */
	restaurantAddress varchar(100) not null, 								/* 식당 주소 */
	openingHours varchar(50) not null default '',	  				/* 영업시간 */
	breakTime varchar(50) not null default '',	  					/* 휴게시간 */
	regularHoliday varchar(100) not null default 'NO', 			/* 정기휴일 */
	restaurantSite varchar(50) not null default '', 				/* 식당 사이트 */
	parking varchar(10) not null default 'OK',							/* 주차 가능 여부 */
	readNum int not null default 0,													/* 조회수 */
	good int not null default 0,														/* 좋아요 */
	bookMark int not null default 0,												/* 즐겨찾기 */
	review varchar(10) not null default 0,									/* 리뷰수 */
	fName varchar(200) not null,														/* 처음 업로드할때의 파일명 */
	fSName	varchar( 200) not null,													/* 파일서버에 저장되는 실제파일명 */
	fSize	int,																							/* 총 파일 사이즈 */
	fDate  	datetime default now(),													/* 파일 업로드한 날짜 */
	hashTag varchar(200),																	  /* 해시태그 */
	primary key(idx)	
);

drop table restaurant;
alter table restaurant add column hashTag varchar(200) not null


	create table foodMenu(
		idx int not null auto_increment primary key,
		foodName varchar(100) not null,						/* 음식이름 */
		foodCategory varchar(100) not null,					/* 음식종류 */
		foodPrice varchar(100) not null 					/* 음식가격 */
	);
	
	create table restaurantCategory(						/*식당에서 판매하는 메뉴 테이블 */
		idx int not null auto_increment primary key,
		restaurantName  varchar(100) not null,
		foodName varchar(100) not null,						/* 음식이름*/
		foodPrice varchar(100) not null 					/* 음식가격 */
	);
	
	create table restaurantRecent(						/* 식당 리스트 저장 테이블 */
		idx int not null auto_increment primary key,
		rsIdx int not null,										/* 식당 고유 번호*/
		mid	varchar(30) not null,					/* 회원 아이디 */
		bookMark varchar(5) not null default 'NO',				/* 즐겨찾기한 식당 목록 */
		foreign key(rsIdx) references restaurant(idx)
	);
		/*foreign key(memMid) references member2(mid)*/
	
update restaurantRecent set bookMark ='OK' where restaurantRecent.rsIdx= 16;

select * from restaurantRecent, restaurant where mid='skluvjh0111' and restaurant.idx = restaurantRecent.rsIdx;

desc bookMark;
drop table bookMark;
drop table restaurantRecent;
select * from bookMark where 

desc restaurantRecent;	
	
desc restaurant;
desc foodMenu;
desc restaurantCategory;
drop table restaurant;
drop table foodMenu;
drop table restaurantCategory;
select * from restaurant order by idx desc;

)

select * from restaurantRecent as rc left join restaurant as r on rc.rsIdx = r.idx where rc.mid = 'admin';
union
select *
from restaurant right join foodMenu;

select * from restaurant
union
select * from foodMenu;

/*restaurant 테이블이랑 foodMenu 테이블 합치기 */
select restaurant.*, foodMenu.idx,	
foodMenu.foodName, 
foodMenu.foodCategory,
foodMenu.foodPrice
from restaurant inner join foodMenu
on restaurant.idx = foodMenu.idx;

select * from restaurantRecent where mid = 'number2' order by idx desc limit 10;