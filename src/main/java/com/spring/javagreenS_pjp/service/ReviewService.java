package com.spring.javagreenS_pjp.service;

import java.util.List;

import com.spring.javagreenS_pjp.vo.ReviewVO;

public interface ReviewService {

	public void setReviewInput(ReviewVO vo);

	public List<ReviewVO> getReview(String restaurantName);



}
