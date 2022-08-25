package com.spring.javagreenS_pjp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjp.pagination.PageProcess;
import com.spring.javagreenS_pjp.pagination.PageVO;
import com.spring.javagreenS_pjp.service.HomeService;
import com.spring.javagreenS_pjp.service.MemberService;
import com.spring.javagreenS_pjp.service.NoticeService;
import com.spring.javagreenS_pjp.service.ReviewService;
import com.spring.javagreenS_pjp.vo.HashTagVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.KeywordVO;
import com.spring.javagreenS_pjp.vo.NoticeVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;
import com.spring.javagreenS_pjp.vo.ReviewVO;

@Controller
public class HomeController {
	@Autowired
	HomeService homeService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 인기 검색어
		@RequestMapping(value = "/", method = RequestMethod.GET)
		public String home(Model model, HttpSession session) {
			String mid = (String) session.getAttribute("sMid");
			ArrayList<KeywordVO> pVos = homeService.getPopularSearch();							// 인기 검색
			ArrayList<KeywordVO> rVos = homeService.getRecentSearch();							// 최근 검색
			ArrayList<RestaurantVO> fVos = homeService.getKeywordSearch();					// 믿고 보는 맛집 리스트
			ArrayList<RestaurantVO> fVos2 = homeService.getKeywordSearch2();				// 맛집 스토리
			ArrayList<RestaurantVO> sVos = homeService.getFoodStory();							// 에디터가 선정한 식당
			ArrayList<RestaurantVO> sVos2 = homeService.getFoodStory2();						// TV에 나온 식당
			
			ArrayList<RestaurantVO> rcVos = homeService.getRestaurantRecentList(mid); 			// 최근 본 맛집 리스트, 즐겨찾기 맛집 리스트
			ArrayList<RestaurantVO> rcVos2 = homeService.getRestaurantBookMarkList(mid); 		// 즐겨찾기 맛집 리스트
			
			// 첫화면에 공지사항 팝업으로 띄우기
			List<NoticeVO> popupVos = noticeService.getNotifyPopup();
			
			model.addAttribute("popupVos", popupVos);
			session.setAttribute("rCount", rcVos.size());
			model.addAttribute("pVos",pVos);
			model.addAttribute("rVos",rVos);
			model.addAttribute("sVos",sVos);
			model.addAttribute("sVos2",sVos2);
			session.setAttribute("rcVos",rcVos); 
			session.setAttribute("rcVos2",rcVos2); 
			model.addAttribute("fVos",fVos);
			model.addAttribute("fVos2",fVos2);
			
			return "main/main";
		}
		

	// 검색어 입력시 조회하기
	@RequestMapping(value = "/mainSearch", method = RequestMethod.GET)
	public String mainSearchGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="foodPrice", defaultValue = "", required = false) String foodPrice,
			@RequestParam(name="restaurantAddress", defaultValue = "", required = false) String restaurantAddress,
			@RequestParam(name="foodCategory", defaultValue = "", required = false) String foodCategory,
			@RequestParam(name="parking", defaultValue = "", required = false) String parking) {
			
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "mainSearch", "", searchString);
		
		ArrayList<RestaurantVO> searchVos = homeService.getSearchList(pageVO.getStartIndexNo(), pageSize,searchString);										//등록된 맛집 리스트 보여주기
		ArrayList<RestaurantVO> kVos = homeService.getKeywordSearch();
		ArrayList<RestaurantVO> rcVos = homeService.getRestaurantRecentList(mid); 			// 최근 본 맛집 리스트
		ArrayList<RestaurantVO> rcVos2 = homeService.getRestaurantBookMarkList(mid); 		// 즐겨찾기 맛집 리스트
		
		
		model.addAttribute("rcVos",rcVos); 
		model.addAttribute("rcVos2",rcVos2); 
		model.addAttribute("kVos",kVos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("searchVos",searchVos);
		model.addAttribute("searchString",searchString);
		
		return "restaurant/restaurantMainSearch";
		
	}
	// 검색어 입력시 조회하기
	@RequestMapping(value = "/filterSearch", method = RequestMethod.GET)
	public String filterSearchGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="foodPrice", defaultValue = "", required = false) String foodPrice,
			@RequestParam(name="restaurantAddress", defaultValue = "", required = false) String restaurantAddress,
			@RequestParam(name="foodCategory", defaultValue = "", required = false) String foodCategory,
			@RequestParam(name="parking", defaultValue = "", required = false) String parking) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "filterSearch", "", searchString);
		ArrayList<RestaurantVO> filterVos = homeService.getFilter(pageVO.getStartIndexNo(), pageSize, foodPrice, restaurantAddress, foodCategory, parking);	//필터로 검색하여 맛집 리스트 보여주기
		int size = filterVos.size();
		
		ArrayList<RestaurantVO> searchVos = homeService.getSearchList(pageVO.getStartIndexNo(), pageSize,searchString);										//등록된 맛집 리스트 보여주기
		ArrayList<RestaurantVO> kVos = homeService.getKeywordSearch();
		
		
		model.addAttribute("filterVos",filterVos);
		model.addAttribute("kVos",kVos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("searchVos",searchVos);
		model.addAttribute("searchString",searchString);
		model.addAttribute("size",size);
		
		return "restaurant/restaurantFilterSearch";
		
	}
	
	//	맛집 상세보기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/restaurantInfor", method = RequestMethod.GET)
	public String restaurantInforGet(int idx, Model model, String restaurantName, HttpSession session, ReviewVO vo,
		  @RequestParam(name="pag", defaultValue="1", required= false) int pag,
		  @RequestParam(name="pageSize", defaultValue="3", required= false) int pageSize,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString
			) {
		String mid = (String) session.getAttribute("sMid");
		if(mid == null) {
			return "redirect:/msg/loginCheck";
		}
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "mainSearch", "", searchString);
		RestaurantVO iVo = homeService.getSearchInfor(restaurantName,mid);			// 식당 상세 정보 보여주기
		
		ArrayList<RestaurantVO> mVos = homeService.getSearchMenu(restaurantName);	// 식당 메뉴 정보 보여주기
		
		KakaoAddressVO kVo = homeService.getKakaoAddress(iVo.getRestaurantName());	// 카카오 주소 보여주기
		
		List<ReviewVO> rVos = reviewService.getReview(iVo.getRestaurantName());		// 리뷰 글 보여주기

		
		 		
		ArrayList<RestaurantVO> searchVos = homeService.getSearchList(pageVO.getStartIndexNo(), pageSize,searchString);										//등록된 맛집 리스트 보여주기
		
		
		// 조회수 증가(조회수 중복방지처리)
		ArrayList<String> restaurantIdx = (ArrayList) session.getAttribute("sRestaurantIdx");
		if(restaurantIdx == null) restaurantIdx = new ArrayList<String>();
		
		String imsiRestaurantIdx = "restaurant" + idx;
		if(!restaurantIdx.contains(imsiRestaurantIdx)) {
			homeService.setReadNum(idx);
			restaurantIdx.add(imsiRestaurantIdx);
		}
		session.setAttribute("sRestaurantIdx", restaurantIdx);
		
		int visitCount = homeService.getRestaurantRecent(mid, idx);
		if(visitCount == 0) {
			homeService.getRestaurantInsert(idx, mid);	// 최초 방문한 식당 리스트 DB 추가하기
		}
		
		// 리뷰개수불러오기
		int reviewCnt = homeService.getReviewCnt(restaurantName);
		
		// 각 매장별로 리뷰(맛있어요,괜찮아요,별로에요 ) 숫자 구해오기
		ReviewVO reviewCntVo= homeService.getReviewCntVo(restaurantName);
		
		model.addAttribute("searchVos",searchVos);
		model.addAttribute("searchString",searchString);
		
		model.addAttribute("reviewCntVo",reviewCntVo);
		model.addAttribute("reviewCnt",reviewCnt);
		model.addAttribute("idx",idx);
		model.addAttribute("iVo",iVo);
		model.addAttribute("mVos",mVos);
		model.addAttribute("rVos",rVos);
		model.addAttribute("kVo",kVo);
	
		return "restaurant/restaurantInfor";
}
	
	// 즐겨찾기 증가 처리
	@ResponseBody	
	@RequestMapping(value = "/bookMarkCheck", method = RequestMethod.POST)
	public int bookMarkCheckPost(int idx, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int res = 1; 
		ArrayList<RestaurantVO> vos = homeService.getRestaurantBookMarkList(mid);
		homeService.setBookMark2(idx);			// 즐겨찾기 'No'-> 'Yes"변경처리
		int vosSize = vos.size();		
		for(int i=0; i<vosSize; i++) {			// vosSize만큼 반복문 실행
			if(idx == vos.get(i).getIdx()) {	// idx랑 getId랑 비교했을때 같으면 res가 0이 된다.
				res = 0;
			}
			else {							
				homeService.setBookMark(idx);	// 반대로 같지 않다면 즐겨찾기 1씩 증가처리
				break;
			}
		}
		return res;
	}
	
	// 최근 선택한 식당 카운트 호출
	@ResponseBody	
	@RequestMapping(value = "/mainRecent", method = RequestMethod.POST)
	public String mainRecentPost(int idx, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		homeService.getRestaurantRecent(idx, mid);
		
		return "";
	}
	//	맛집 필터기로 이동 시키기
	@RequestMapping(value = "/restaurantFilter", method = RequestMethod.GET)
	public String restaurantFilterGet() {
		
		return "restaurant/restaurantFilter";
	}
	
	//	필터된 맛집 리스트 보여주기 
	@RequestMapping(value = "/restaurantFilter2", method = RequestMethod.GET)
	public String restaurantFilter2Get(
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
		Model model) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "mainSearch", "", "");
		
		model.addAttribute("pageVO",pageVO);
		return "redirect:/restaurant/restaurantMainSearch";
	}
	
	//	맛집 베스트 리스트
	@RequestMapping(value = "/restaurantTopList", method = RequestMethod.GET)
	public String restaurantTopListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="hashTag", defaultValue = "전체", required = false) String hashTag,
			Model model) {	
		List<HashTagVO> hashVos = homeService.getHashTagList();
		List<RestaurantVO> restaurantVos = homeService.getRestaurantList(hashTag);
		
		
		model.addAttribute("restaurantVos", restaurantVos);
		model.addAttribute("hashVos", hashVos);
		return "restaurant/restaurantTopList";
	}
	//	최근 맛집 리스트 삭제 하기
	@RequestMapping(value = "/recentListDel", method = RequestMethod.GET)
	public String recentListDelGet(int size, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		homeService.setRecentListDelete(size,mid);
		return "redirect:/msg/recentListDeleteOk";
	}
	
	// ckeditor에서 글을 올리때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 그림파일을 저장할수 있도록 처리한다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
			MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린(전송한) 파일을, 서버 파일시스템에 실제로 파일을 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		// 서버 파일시스템에 저장된 파일을 화면에 보여주기위한 작업.
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		/* {"atom":"12.jpg","변수":1,~~~~} */
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
}
