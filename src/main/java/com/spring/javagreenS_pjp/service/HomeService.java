package com.spring.javagreenS_pjp.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javagreenS_pjp.vo.HashTagVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.KeywordVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;
import com.spring.javagreenS_pjp.vo.ReviewVO;

public interface HomeService {

	public ArrayList<KeywordVO> getPopularSearch();

	public ArrayList<KeywordVO> getRecentSearch();

	public ArrayList<RestaurantVO> getKeywordSearch();

	public ArrayList<RestaurantVO> getFoodStory();

	public ArrayList<RestaurantVO> getSearchList(int startIndexNo, int pageSize, String searchString);

	public RestaurantVO getSearchInfor(String restaurantName, String mid);

	public KakaoAddressVO getKakaoAddress(String restaurantName);

	public ArrayList<RestaurantVO> getKeywordSearch2();

	public void getRestaurantRecent(int idx, String mid);

	public int getRecentCount(String mid);

	public ArrayList<RestaurantVO> getRestaurantRecentList(String mid);

	public void setReadNum(int idx);

	public void setRecentListDelete(int size,String mid);

	public void setBookMark(int idx);

	public void setBookMark2(int idx);

	public ArrayList<RestaurantVO> getRestaurantBookMarkList(String mid);

	public int getRestaurantRecent(String mid, int idx);

	public void getRestaurantInsert(int idx, String mid);

	public ArrayList<RestaurantVO> getSearchMenu(String restaurantName);

	public ArrayList<RestaurantVO> getFilter(int startIndexNo, int pageSize, String foodPrice, String restaurantAddress,
			String foodCategory, String parking);

	public void setReview(int idx);

	public int getReviewCnt(String restaurantName);

	public List<HashTagVO> getHashTagList();

	public List<RestaurantVO> getRestaurantList(String hashTag);

	public ReviewVO getReviewCntVo(String restaurantName);

	public ArrayList<RestaurantVO> getFoodStory2();

}
