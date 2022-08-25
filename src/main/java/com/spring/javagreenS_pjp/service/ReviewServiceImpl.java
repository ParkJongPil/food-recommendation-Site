package com.spring.javagreenS_pjp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjp.dao.ReviewDAO;
import com.spring.javagreenS_pjp.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public void setReviewInput(ReviewVO vo) {
		reviewDAO.setReviewInput(vo);
	}

	@Override
	public List<ReviewVO> getReview(String restaurantName) {
		return reviewDAO.getReview(restaurantName);
	}

}
