package com.spring.javagreenS_pjp;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javagreenS_pjp.service.KakaoService;

@Controller
@RequestMapping("/kakao")
public class KakaoController {
  
  @Autowired
  KakaoService kakaoService;
  
  @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
  public String kakaoLoginGet() {
    return "member/memLogin";
  }
  
  @ResponseBody	//텍스트 형식으로 와야되기 때문에 responseBody 호출
  @RequestMapping(value = "/kakaoMain", method = RequestMethod.GET)
  public ModelAndView kakaoMainGet(@RequestParam("code") String code, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    // 1. 인증코드 요청하여 전달받기
    String accessToken = kakaoService.getAccessToken(code);
    
    // 2. 인증코드로 토큰 전달하기
    HashMap<String, Object> userInfor = kakaoService.getUserInfor(accessToken);
    
    System.out.println("login infor : " + userInfor.toString());
    
    if(userInfor.get("email") != null) {
//      session.setAttribute("sNickName", userInfor.get("nickname"));
      session.setAttribute("sEmail", userInfor.get("email"));
//      session.setAttribute("accessToken", accessToken);
    }
    else {		// 이메일이 null이라면 임의의 이메일을 등록시켜주었다. 
      session.setAttribute("sEmail", "cjsk1126@naver.com");
    }
    session.setAttribute("sNickName", userInfor.get("nickname"));
    session.setAttribute("accessToken", accessToken);
//    mav.addObject("userId", userInfor.get("email"));
//    mav.addObject("nickName", userInfor.get("nickname"));
//    mav.addObject("email", userInfor.get("email"));
    mav.setViewName("/member/kakaoMain");	//jsp 경로 
    return mav;
  }
  
  
  @RequestMapping(value = "/kakaoLogout", method = RequestMethod.GET)
  public ModelAndView kakaoLogoutGet(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    kakaoService.kakaoLogout((String) session.getAttribute("accessToken"));
    //session.removeAttribute("nickname");
    //session.removeAttribute("email");
    session.removeAttribute("accessToken");
    mav.setViewName("/home");
    
    return mav;
  }
}
