package com.spring.javagreenS_pjp.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private String restaurantName;
	private String grade;
	private String fDate;
	private String mid;
	private String restaurantContent;
	
	private String restaurantIdx;
	private String tempRestaurantName;
	
	private String gradeA;
	private String gradeB;
	private String gradeC;
}
