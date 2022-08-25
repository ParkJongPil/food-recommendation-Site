package com.spring.javagreenS_pjp.vo;

import lombok.Data;

@Data
public class QrCodeVO {
	private int idx;
	private String restaurantName;
	private String qrCode;
	private String moveUrl;
}
