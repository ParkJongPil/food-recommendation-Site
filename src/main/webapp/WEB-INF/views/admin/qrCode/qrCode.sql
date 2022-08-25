show tables;

create table qrCode(
  idx  int not null auto_increment primary key,
  restaurantName varchar(100) not null,
  qrCode varchar(100) not null,
  moveUrl varchar(100) not null
);

drop table qrCode;

desc qrCode;