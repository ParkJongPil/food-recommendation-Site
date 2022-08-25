create table kakaoAddress(
	address varchar(50) not null, 		/* 지점명 */
	latitude double not null, 			/* 위도 */
	longitude	double not null			/* 경도 */
);

desc kakaoAddress;

select * from kakaoAddress;
drop table kakaoAddress;