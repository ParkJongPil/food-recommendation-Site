package com.spring.javagreenS_pjp.vo;

import lombok.Data;

@Data
public class ChartVO {
	/* 공통 */
	private String title;
	private String part;
	
	/* pie 차트 */
	private String subTitle1;
	private String subTitle2;
	private String subTitle3;
	private String subTitle4;
	private String subTitle5;
	
	private String value1;
	private String value2;
	private String value3;
	private String value4;
	private String value5;
	
	/* 수직막대차트(barV) */
	private String subTitle;
	private String xTitle;
	private String legend1;
	private String legend2;
	private String legend3;
	private String x1;
	private String x2;
	private String x3;
	private String x4;
	private String x1Value1;
	private String x1Value2;
	private String x1Value3;
	private String x2Value1;
	private String x2Value2;
	private String x2Value3;
	private String x3Value1;
	private String x3Value2;
	private String x3Value3;
	private String x4Value1;
	private String x4Value2;
	private String x4Value3;
	
	/* 최근 방문자수 담을필드 */
	private String visitDate;
	private int visitCount;
	
}
