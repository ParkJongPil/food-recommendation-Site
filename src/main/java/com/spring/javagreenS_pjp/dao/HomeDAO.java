package com.spring.javagreenS_pjp.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjp.vo.HashTagVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.KeywordVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;
import com.spring.javagreenS_pjp.vo.ReviewVO;

public interface HomeDAO {

	public ArrayList<KeywordVO> getPopularSearch();

	public ArrayList<KeywordVO> getRecentSearch();

	public ArrayList<RestaurantVO> getKeywordSearch();

	public ArrayList<RestaurantVO> getFoodStory();

	public ArrayList<RestaurantVO> getSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("searchString") String searchString);

	public int totRecCnt(@Param("searchString") String searchString);

	public RestaurantVO getSearchInfor(@Param("restaurantName") String restaurantName, @Param("mid") String mid);

	public KakaoAddressVO getKakaoAddress(@Param("restaurantName") String restaurantName);

	public ArrayList<RestaurantVO> getKeywordSearch2();

	public void getRestaurantRecent(@Param("idx") int idx, @Param("mid") String mid);

	public int getRecentCount(@Param("mid") String mid);

	public ArrayList<RestaurantVO> getRestaurantRecentList(@Param("mid") String mid);

	public void setReadNum(@Param("idx") int idx);

	public void setRecentListDelete(@Param("size") int size,@Param("mid") String mid);

	public void setBookMark(@Param("idx") int idx);

	public void setBookMark2(@Param("idx") int idx);

	public ArrayList<RestaurantVO> getRestaurantBookMarkList(@Param("mid") String mid);

	public int getRestaurantRecent(@Param("mid") String mid,@Param("idx") int idx);

	public void getRestaurantInsert(@Param("idx") int idx, @Param("mid") String mid);

	public ArrayList<RestaurantVO> getSearchMenu(@Param("restaurantName") String restaurantName);

	public ArrayList<RestaurantVO> getFilter(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("foodPrice") String foodPrice, @Param("restaurantAddress")String restaurantAddress,
			@Param("foodCategory")String foodCategory,@Param("parking") String parking);

	public void setReview(@Param("idx") int idx);

	public int getReviewCnt(@Param("restaurantName") String restaurantName);

	public List<HashTagVO> getHashTagList();

	public List<RestaurantVO> getRestaurantList(@Param("hashTag") String hashTag);

	public ReviewVO getReviewCntVo(@Param("restaurantName") String restaurantName);

	public ArrayList<RestaurantVO> getFoodStory2();

	

}
