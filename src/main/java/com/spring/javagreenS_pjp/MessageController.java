package com.spring.javagreenS_pjp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="name", defaultValue = "", required=false) String name,
			@RequestParam(value="mid", defaultValue = "", required=false) String mid,
			@RequestParam(value="restaurantName", defaultValue = "", required=false) String restaurantName,
			@RequestParam(value="idx", defaultValue = "0", required=false) int idx) {
		
		if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다. 다시 한번 체크하세요.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memNickCheckNo")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다. 다시 한번 체크하세요.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memNickCheckNo2")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다. 다시 한번 체크하세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg", "회원가입 되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memInputNo")) {
			model.addAttribute("msg", "회원가입 실패~~");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memKakaoLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다. 초기 비밀번호는 0000입니다.");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~~");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일 업로드 실패~~");
			model.addAttribute("url", "fileUpload/fileUpload");
		}
		else if(msgFlag.equals("memIdPwdSearchOk")) {
			model.addAttribute("msg", "신규 비밀번호가 이메일로 전송되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memIdSearchNo")) {
			model.addAttribute("msg", "입력하신 이메일을 확인해 주세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memIdPwdSearchNo")) {
			model.addAttribute("msg", "입력하신 정보를 확인해 주세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 확인하세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정 되었습니다..");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정 실패~~");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg", mid + "회원님! 탈퇴 되셨습니다. 1개월 동안 같은 아이디로 다시 가입하실 수 없습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("adMemLevelChangeOk")) {
			model.addAttribute("msg", "등급이 변경 되었습니다.");
			model.addAttribute("url", "admin/adMemList");
		}
		else if(msgFlag.equals("adMemLevelChangeNo")) {
			model.addAttribute("msg", "등급 변경 실패~~");
			model.addAttribute("url", "admin/member/adMemList");
		}
		else if(msgFlag.equals("adRestaurantCreateOk")) {
			model.addAttribute("msg", "식당이 등록되었습니다.");
			model.addAttribute("url", "admin/adRestaurantCreate");
		}
		else if(msgFlag.equals("adRestaurantCreateNo")) {
			model.addAttribute("msg", "식당 등록 실패~~");
			model.addAttribute("url", "admin/adRestaurantCreate");
		}
		else if(msgFlag.equals("adFoodCreateOk")) {
			model.addAttribute("msg", "음식 종류가 등록되었습니다.");
			model.addAttribute("url", "admin/adFoodCreate");
		}
		else if(msgFlag.equals("adFoodCreateNo")) {
			model.addAttribute("msg", "음식 종류 등록 실패~~");
			model.addAttribute("url", "admin/adFoodCreate");
		}
		else if(msgFlag.equals("adFoodSaleCreateOk")) {
			model.addAttribute("msg", "식당 정보 등록이 완료되었습니다.");
			model.addAttribute("url", "admin/adFoodSaleCreate");
		}
		else if(msgFlag.equals("adFoodSaleCreateNo")) {
			model.addAttribute("msg", "식당 정보 등록 실패~~");
			model.addAttribute("url", "admin/adFoodSaleCreate");
		}
		else if(msgFlag.equals("adLocationCreateOk")) {
			model.addAttribute("msg", "식당 위치 등록 성공");
			model.addAttribute("url", "admin/adFoodSaleCreate");
		}
		else if(msgFlag.equals("adLocationCreateNo")) {
			model.addAttribute("msg", "식당 위치 등록 실패~~");
			model.addAttribute("url", "admin/adFoodSaleCreate");
		}
		else if(msgFlag.equals("recentListDeleteOk")) {
			model.addAttribute("msg", "최근 식당 리스트가 삭제 되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("recentListDeleteNo")) {
			model.addAttribute("msg", "최근 식당 리스트 삭제 실패~~");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("msg", "리뷰가 등록되었습니다.");
			model.addAttribute("url", "restaurantInfor?idx="+idx+"&restaurantName="+restaurantName);
		}
		else if(msgFlag.equals("noInputOk")) {
			model.addAttribute("msg", "공지사항이 등록되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("loginCheck")) {
			model.addAttribute("msg", "로그인 후 이용하세요!");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("noUpdateOk")) {
			model.addAttribute("msg", "공지사항이 수정 되었습니다.");
			model.addAttribute("url", "notice/noList");
		}
		else if(msgFlag.equals("qrSearchNo")) {
			model.addAttribute("msg", "있는 매장입니다.");
			model.addAttribute("url", "/");
		}
		return "include/message";
	}
}
