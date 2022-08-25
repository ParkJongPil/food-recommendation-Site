package com.spring.javagreenS_pjp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjp.vo.ReviewVO;

public interface ReviewDAO {

	public void setReviewInput(@Param("vo") ReviewVO vo);

	public List<ReviewVO> getReview(@Param("restaurantName") String restaurantName);




}
