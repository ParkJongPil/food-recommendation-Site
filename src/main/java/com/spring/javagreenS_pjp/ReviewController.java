package com.spring.javagreenS_pjp;

import java.io.Reader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS_pjp.service.HomeService;
import com.spring.javagreenS_pjp.service.ReviewService;
import com.spring.javagreenS_pjp.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	HomeService homeService;
	//	리뷰글 작성하기
	@RequestMapping(value = "/reviewInput", method = RequestMethod.GET)
	public String reviewInputGet(String restaurantName, Model model) {
		
		model.addAttribute("restaurantName",restaurantName);
		return "review/reviewInput";
	}
	
	@RequestMapping(value = "/reviewInput", method = RequestMethod.POST)
	public String reviewInputPost(ReviewVO vo, Model model,@RequestParam("restaurantIdx")int restaurantIdx) {
		
		reviewService.setReviewInput(vo);
		homeService.setReview(restaurantIdx); // 리뷰 숫자 증가처리
		model.addAttribute("idx",vo.getRestaurantIdx());
		model.addAttribute("restaurantName",vo.getRestaurantName());
		return "redirect:/msg/reviewInputOk";
	}
}
