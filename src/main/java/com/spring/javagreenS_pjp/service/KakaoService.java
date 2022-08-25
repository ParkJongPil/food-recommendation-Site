package com.spring.javagreenS_pjp.service;

import java.util.HashMap;

public interface KakaoService {
	public String getAccessToken(String code);

  public HashMap<String, Object> getUserInfor(String accessToken);

  public void kakaoLogout(String accessToken);
}
