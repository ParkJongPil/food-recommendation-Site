package com.spring.javagreenS_pjp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_pjp.vo.ChartVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.MemberVO;
import com.spring.javagreenS_pjp.vo.QrCodeVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;

public interface AdminService {

	public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize);

	public void adMemLevelChange(int idx, int level);

	public void setRestaurantCreate(RestaurantVO vo, MultipartHttpServletRequest file);

	public void setFoodCreate(RestaurantVO vo);

	public void setFoodSaleCreate(RestaurantVO vo);

	public String[] getRestaurantCreate();

	public String[] getFoodCreate();

	public void setAddressName(KakaoAddressVO vo);

	public KakaoAddressVO getAddressName(String address);

	public List<KakaoAddressVO> getAddressNameList();

	public void adAddressDelete(String address);

	public String[] getFoodPrice();

	public ArrayList<RestaurantVO> getRestaurantList(int startIndexNo, int pageSize);

	public void setRestaurantDelete(int idx);

	public void setHashTagInput(String hashTag);

	public String qrCreate(String uploadPath, QrCodeVO vo);

	public List<ChartVO> getRecentlyVisitCount();

}
