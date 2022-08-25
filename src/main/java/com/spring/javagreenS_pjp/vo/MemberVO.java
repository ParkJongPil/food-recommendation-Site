package com.spring.javagreenS_pjp.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickName;
	private String gender;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String userDel;
	private int level;
	private String startDate;
	private String lastDate;
	private String photo;
	private int todayCnt;
	
	private int applyDiff;		// 날짜 차이 계산하는 필드
	private String strLevel;	// 회원등급을 문자로 저장하는 필드

}
