package com.spring.javagreenS_pjp;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_pjp.pagination.PageProcess;
import com.spring.javagreenS_pjp.pagination.PageVO;
import com.spring.javagreenS_pjp.service.AdminService;
import com.spring.javagreenS_pjp.vo.ChartVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.MemberVO;
import com.spring.javagreenS_pjp.vo.QrCodeVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	// 관리자 사이드 메뉴 
	@RequestMapping(value = "/adMenu", method = RequestMethod.GET)
	public String adMenuGet() {
		return "admin/adMenu";
	}
	
	// 관리자 메뉴
	@RequestMapping(value="/adLeft", method = RequestMethod.GET)
	public String adLeftGet() {
		return "admin/adLeft";
	}
	
	// 관리자 페이지 
	@RequestMapping(value="/adContent", method = RequestMethod.GET)
	public String adContentGet(Model model) {
		return "admin/adContent";
	}
	
	// 등급 변경
	@RequestMapping(value="/adMemLevelChange", method = RequestMethod.POST)
	public String adMemLevelChangePost(int idx, int level) {
		adminService.adMemLevelChange(idx,level);
		return "redirect:/msg/adMemLevelChangeOk";
	}
	
	// 관리자 메뉴에서 회원 리스트 보기(운영자 or 관리자) 접근 가능
	@RequestMapping(value = "/adMemList", method = RequestMethod.GET)
	public String adListGet(Model model,  
		@RequestParam(name ="pag" , defaultValue = "1", required=false) int pag,
		@RequestParam(name ="pageSize",defaultValue = "3", required=false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"member","","");
		ArrayList<MemberVO> vos = adminService.getMemList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);		
		
		return "admin/member/adMemList";
	}
	
	// 등록된 매장 리스트 보기
	@RequestMapping(value="/adRestaurantList", method = RequestMethod.GET)
	public String adRestaurantListGet(Model model,
		@RequestParam(name ="pag" , defaultValue = "1", required=false) int pag,
		@RequestParam(name ="pageSize",defaultValue = "5", required=false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"member","","");
		ArrayList<RestaurantVO> rVos = adminService.getRestaurantList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("rVos", rVos);
		model.addAttribute("pageVO", pageVO);	
		
		return "admin/member/adRestaurantList";
	}
	
	// 식당 정보 등록
	@RequestMapping(value="/adRestaurantCreate", method = RequestMethod.GET)
	public String adRestaurantCreateGet() {
		
		return "admin/food/adRestaurantCreate";
	}
	
	// 식당 정보 등록폼
	@RequestMapping(value="/adRestaurantCreate", method = RequestMethod.POST)
	public String adRestaurantCreatePost(MultipartHttpServletRequest file, RestaurantVO vo) {
		adminService.setRestaurantCreate(vo,file);
		
		String[] hashTags = vo.getHashTag().split("#");
		for(int i=1; i<hashTags.length; i++) {
			adminService.setHashTagInput(hashTags[i].trim());
		}
		
		
		return "redirect:/msg/adRestaurantCreateOk";
	}
	
	// 음식종류 등록 뷰
	@RequestMapping(value="/adFoodCreate", method = RequestMethod.GET)
	public String adFoodCreateGet() {
		
		return "admin/food/adFoodCreate";
	}
	
	// 음식종류 등록처리
	@RequestMapping(value="/adFoodCreate", method = RequestMethod.POST)
	public String adFoodCreatePost(RestaurantVO vo) {
		adminService.setFoodCreate(vo);
		return "redirect:/msg/adFoodCreateOk";
	}
	
	// 식당 판매 음식 등록 뷰
	@RequestMapping(value="/adFoodSaleCreate", method = RequestMethod.GET)
	public String adFoodSaleCreateGet(Model model) {
		String[] sVos = adminService.getRestaurantCreate();	//식당명
		String[] fVos = adminService.getFoodCreate();	//음식 카테고리
		String[] fVos2 = adminService.getFoodPrice();	//음식 가격
		
		model.addAttribute("sVos",sVos);
		model.addAttribute("fVos",fVos);
		model.addAttribute("fVos2",fVos2);
		
		return "admin/food/adFoodSaleCreate";
	}
	
	// 식당 판매 음식 등록처리
	@RequestMapping(value="/adFoodSaleCreate", method = RequestMethod.POST)
	public String adFoodSaleCreatePost(RestaurantVO vo) {
		adminService.setFoodSaleCreate(vo);
		return "redirect:/msg/adFoodSaleCreateOk";
	}
	
	// 식당 위치 등록 처리1
	@RequestMapping(value="/adAddressName", method = RequestMethod.GET)
	public String adLocationCreateGet() {
		
		return "admin/address/adAddressName";
	}
	
	// 식당 위치 등록 처리1-2
	@ResponseBody
	@RequestMapping(value="/adAddressName", method = RequestMethod.POST)
	public String adAddressNamePost(KakaoAddressVO vo) {
		KakaoAddressVO searchVo = adminService.getAddressName(vo.getAddress());
		if(searchVo != null) return "0";
		adminService.setAddressName(vo);
		
		return "1";
	}
	
	// 식당 위치 등록 처리 2
	@RequestMapping(value="/adAddressName2", method=RequestMethod.GET)
	public String adAddressName2Get(Model model,
			@RequestParam(name="address", defaultValue = "사창사거리", required = false)  String address) {
		List<KakaoAddressVO> vos = adminService.getAddressNameList();
		KakaoAddressVO vo = adminService.getAddressName(address);
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		model.addAttribute("address", address);
		
		return "admin/address/adAddressName2";
	}
	
	// 식당 위치 등록 처리(지점명 DB에서 삭제하기)
	@ResponseBody
	@RequestMapping(value = "/adAddressDelete", method = RequestMethod.POST)
	public String adAddressDeletePost(String address) {
		adminService.adAddressDelete(address);
		return "";
	}
	
	// 전국 지명 키워드로 검색
	@RequestMapping(value = "/adAddressName3", method = RequestMethod.GET)
	public String adAddressName33Get(Model model, String address) {
		if(address == null) address="사창사거리";
		model.addAttribute("address",address);
		return "admin/address/adAddressName3";
	}
	//해시태그 등록
	@RequestMapping(value = "/adHashTagCreate", method = RequestMethod.GET)
	public String adHashTagCreateGet() {
		return "admin/food/adHashTagCreate";
	}
	
	//등록된 식당(DB에서 삭제하기)
	@ResponseBody
	@RequestMapping(value = "/restaurantDelete", method = RequestMethod.POST)
	public void restaurantDelete(@RequestParam(value = "idx") int idx) {
		adminService.setRestaurantDelete(idx);
	}
	
	// QR코드 생성하기 폼(URL 등록폼)
	@RequestMapping(value="/qrCode", method=RequestMethod.GET)
	public String qrCodeGet(HttpSession session, Model model) {
		return "admin/qrCode/qrCode";
	}
	
	// QR코드 생성하기 처리부분
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value="/qrCreate", method=RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String barCreatePost(HttpServletRequest request, HttpSession session, QrCodeVO vo) {
			String uploadPath = request.getRealPath("/resources/data/qrCode/");
			String qrCodeName = adminService.qrCreate(uploadPath , vo);	// qr코드가 저장될 서버경로와 qr코드 찍었을때 이동할 url을 서비스객체로 넘겨서 qr코드를 생성하게 한다.

			return qrCodeName;
	}
	
	//최근 방문자수 차트로 표시하기
	@RequestMapping(value="/googleChart2Recently", method=RequestMethod.GET)
	public String googleChart2RecentlyGet(Model model) {
		//System.out.println("part : " + part);
		List<ChartVO> vos = null;
		vos = adminService.getRecentlyVisitCount();
		// vos로 차트에서 처리가 잘 안되는것 같아서 다시 배열로 담아서 처리해본다.
		String[] visitDates = new String[7];
		int[] visitDays = new int[7];	// line차트는 x축과 y축이 모두 숫가자 와야하기에 날짜중에서 '일'만 담기로 한다.(정수타입으로)
		int[] visitCounts = new int[7];
		for(int i=0; i<7; i++) {
			visitDates[i] = vos.get(i).getVisitDate();
			visitDays[i] = Integer.parseInt(vos.get(i).getVisitDate().toString().substring(8));
			visitCounts[i] = vos.get(i).getVisitCount();
		}
		
		model.addAttribute("title", "최근 7일간 방문횟수");
		model.addAttribute("subTitle", "최근 7일동안 방문한 해당일자 방문자 총수를 표시합니다.");
		model.addAttribute("visitCount", "방문횟수");
		model.addAttribute("legend", "일일 방문 총횟수");
		model.addAttribute("visitDates", visitDates);
		model.addAttribute("visitDays", visitDays);
		model.addAttribute("visitCounts", visitCounts);
		
		return "admin/googleChart/barVChartVisitCount";
	}
	
}
