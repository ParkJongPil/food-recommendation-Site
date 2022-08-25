package com.spring.javagreenS_pjp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjp.dao.HomeDAO;
import com.spring.javagreenS_pjp.vo.HashTagVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.KeywordVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;
import com.spring.javagreenS_pjp.vo.ReviewVO;

@Service
public class HomeServiceImpl implements HomeService {
	@Autowired
	HomeDAO homeDAO;

	@Override
	public ArrayList<KeywordVO> getPopularSearch() {
		return homeDAO.getPopularSearch();
	}

	@Override
	public ArrayList<KeywordVO> getRecentSearch() {
		return homeDAO.getRecentSearch();
	}

	@Override
	public ArrayList<RestaurantVO> getKeywordSearch() {
		return homeDAO.getKeywordSearch();
	}

	@Override
	public ArrayList<RestaurantVO> getFoodStory() {
		return homeDAO.getFoodStory();
	}

	@Override
	public ArrayList<RestaurantVO> getSearchList(int startIndexNo, int pageSize, String searchString) {
		return homeDAO.getSearchList(startIndexNo, pageSize, searchString);
	}

	@Override
	public RestaurantVO getSearchInfor(String restaurantName, String mid) {
		return homeDAO.getSearchInfor(restaurantName,mid);
	}

	@Override
	public KakaoAddressVO getKakaoAddress(String restaurantName) {
		return homeDAO.getKakaoAddress(restaurantName);
	}

	@Override
	public ArrayList<RestaurantVO> getKeywordSearch2() {
		return homeDAO.getKeywordSearch2();
	}

	@Override
	public void getRestaurantRecent(int idx, String mid) {
		homeDAO.getRestaurantRecent(idx, mid);
		
	}

	@Override
	public int getRecentCount(String mid) {
		return homeDAO.getRecentCount(mid);
	}

	@Override
	public ArrayList<RestaurantVO> getRestaurantRecentList(String mid) {
		return homeDAO.getRestaurantRecentList(mid);
	}

	@Override
	public void setReadNum(int idx) {
		homeDAO.setReadNum(idx);
	}

	@Override
	public void setRecentListDelete(int size,String mid) {
		homeDAO.setRecentListDelete(size,mid);
	}

	@Override
	public void setBookMark(int idx) {
		homeDAO.setBookMark(idx);
	}

	@Override
	public void setBookMark2(int idx) {
		homeDAO.setBookMark2(idx);		
	}

	@Override
	public ArrayList<RestaurantVO> getRestaurantBookMarkList(String mid) {
		return homeDAO.getRestaurantBookMarkList(mid);
	}

	@Override
	public int getRestaurantRecent(String mid, int idx) {
		return homeDAO.getRestaurantRecent(mid, idx);
	}

	@Override
	public void getRestaurantInsert(int idx, String mid) {
		homeDAO.getRestaurantInsert(idx,mid);
	}

	@Override
	public ArrayList<RestaurantVO> getSearchMenu(String restaurantName) {
		return homeDAO.getSearchMenu(restaurantName);
	}

	@Override
	public ArrayList<RestaurantVO> getFilter(int startIndexNo, int pageSize, String foodPrice, String restaurantAddress,
			String foodCategory, String parking) {
		return homeDAO.getFilter(startIndexNo, pageSize, foodPrice, restaurantAddress, foodCategory, parking);
	}

	@Override
	public void setReview(int idx) {
		homeDAO.setReview(idx);
	}

	@Override
	public int getReviewCnt(String restaurantName) {
		return homeDAO.getReviewCnt(restaurantName);
	}

	@Override
	public List<HashTagVO> getHashTagList() {
		return homeDAO.getHashTagList();
	}

	@Override
	public List<RestaurantVO> getRestaurantList(String hashTag) {
		return homeDAO.getRestaurantList(hashTag);
	}

	@Override
	public ReviewVO getReviewCntVo(String restaurantName) {
		return homeDAO.getReviewCntVo(restaurantName);
	}

	@Override
	public ArrayList<RestaurantVO> getFoodStory2() {
		return homeDAO.getFoodStory2();
	}

}
