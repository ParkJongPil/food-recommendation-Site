package com.spring.javagreenS_pjp.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjp.vo.ChartVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.MemberVO;
import com.spring.javagreenS_pjp.vo.QrCodeVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;

public interface AdminDAO {

	public ArrayList<MemberVO> getMemList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public void adMemLevelChange(@Param("idx") int idx, @Param("level") int level);

	public void setRestaurantCreate(@Param("vo") RestaurantVO vo);

	public void setFoodCreate(@Param("vo") RestaurantVO vo);

	public void setFoodSaleCreate(@Param("vo") RestaurantVO vo);

	public String[] getRestaurantCreate();

	public String[] getFoodCreate();

	public void setAddressName(@Param("vo") KakaoAddressVO vo);

	public KakaoAddressVO getAddressName(@Param("address") String address);

	public List<KakaoAddressVO> getAddressNameList();

	public void adAddressDelete(@Param("address") String address);

	public String[] getFoodPrice();

	public ArrayList<RestaurantVO> getRestaurantList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setRestaurantDelete(@Param("idx") int idx);

	public void setHashTagInput(@Param("hashTag") String hashTag);

	public String qrCreate(@Param("vo") QrCodeVO vo);

	public List<ChartVO> getRecentlyVisitCount();

}
