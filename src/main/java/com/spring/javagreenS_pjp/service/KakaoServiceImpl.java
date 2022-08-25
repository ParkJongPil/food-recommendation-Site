package com.spring.javagreenS_pjp.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoServiceImpl implements KakaoService {
	
	
	@SuppressWarnings("unused")
	@Override
  public String getAccessToken(String code) {
    String accessToken = "";
    String refreshToken = "";
    String reqURL = "https://kauth.kakao.com/oauth/token";
    
    try {
      URL url = new URL(reqURL);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setDoOutput(true);
      
      BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
      StringBuilder sb = new StringBuilder();
      sb.append("grant_type=authorization_code");
      // sb.append("&client_id=9d26530cd44f56a1c06803d9c263fa4b");
      sb.append("&client_id=f9332d17289c0485f922f6c746c53ca6");
      sb.append("&redirect_uri=http://localhost:9090/javagreenS_pjp/kakao/kakaoMain");
//      sb.append("&redirect_uri=http://49.142.157.251:9090/javagreenS_pjp/kakao/kakaoMain");	//서버로 보낼때
      sb.append("&code="+code);
      
      bw.write(sb.toString());
      bw.flush();
      
      int responseCode = conn.getResponseCode();
      System.out.println("response code = " + responseCode);
      
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      
      String line = "";
      String result = "";
      while((line = br.readLine()) != null) {
        result += line;
      }
      System.out.println("response body : " + result);
      
      JsonParser parser = new JsonParser();
      JsonElement element = parser.parse(result);
      
      accessToken = element.getAsJsonObject().get("access_token").getAsString();
      refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();
      
      br.close();
      bw.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return accessToken;
  }


  @Override
  public HashMap<String, Object> getUserInfor(String accessToken) {
    HashMap<String, Object> userInfor = new HashMap<String, Object>();
    String reqUrl = "https://kapi.kakao.com/v2/user/me";
    try {
      URL url = new URL(reqUrl);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Authorization",  "Bearer " + accessToken);
      int responseCode = conn.getResponseCode();
      System.out.println("responseCode : " + responseCode);
      
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      
      String line = "";
      String result = "";
      
      while((line = br.readLine()) != null) {
        result += line;
      }
      System.out.println("response body : " + result);
      
      JsonParser parser = new JsonParser();
      JsonElement element = parser.parse(result);
      
      JsonObject properties= element.getAsJsonObject().get("properties").getAsJsonObject();
      JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
      
      String nickname = properties.getAsJsonObject().get("nickname").getAsString();	//필수항목을 여기에 담아준다.
      String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
      
      userInfor.put("nickname", nickname);	// "명령어여서 변경 불가능"
      userInfor.put("email", email);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return userInfor;
  }


  @Override
  public void kakaoLogout(String accessToken) {
    String reqURL = "https://kapi.kakao.com/v1/user/logout";
    try {
      URL url = new URL(reqURL);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Authorization", "Bearer " + accessToken);
      int responseCode = conn.getResponseCode();
      System.out.println("responseCode = " + responseCode);
      
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      
      String result = "";
      String line = "";
      
      while((line = br.readLine()) != null) {
        result += line;
      }
      System.out.println(result);;
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
