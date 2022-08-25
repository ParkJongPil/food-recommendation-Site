package com.spring.javagreenS_pjp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_pjp.service.NoticeService;
import com.spring.javagreenS_pjp.vo.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	//	공지사항 리스트 보여주기
	@RequestMapping(value = "/noList", method = RequestMethod.GET)
	public String noListGet(Model model) {
		List<NoticeVO> nVos = noticeService.getNoticeList();	//공지사항에 등록된 리스트 보여주기
		
		model.addAttribute("nVos",nVos);
		
		return "notice/noList";
	}
	
	//	공지사항 글 작성으로 이동하기
	@RequestMapping(value = "/noInput", method = RequestMethod.GET)
	public String noInputGet(Model model) {
		
		return "notice/noInput";
	}
	
	//	공지사항 작성하기
	@RequestMapping(value = "/noInput", method = RequestMethod.POST)
	public String noInputPost(NoticeVO vo) {
		noticeService.setNoticeInput(vo);
		
		return "redirect:/msg/noInputOk";
	}
	
	// 공지사항 페이지로 이동
	@RequestMapping(value="/noUpdate", method=RequestMethod.GET)
	public String nUpdateGet(int idx, Model model) {
		NoticeVO vo = noticeService.getNoUpdate(idx);
		model.addAttribute("vo", vo);
		
		return "admin/notice/noUpdate";
	}
	
	// 공지사항 수정하기
	@RequestMapping(value="/noUpdate", method=RequestMethod.POST)
	public String nUpdatePost(NoticeVO vo) {
		noticeService.setNoUpdateOk(vo);
		
		return "redirect:/msg/noUpdateOk";
	}
	
	// 공지사항 삭제하기
	@ResponseBody
	@RequestMapping(value="/nDelete", method=RequestMethod.GET)
	public String nDeleteGet(int idx) {
		noticeService.setDelete(idx);
		
		return "1";
	}
	
	// 공지사항 팝업을 호출하는 메소드
	@RequestMapping(value="/popup", method=RequestMethod.GET)
	public String popupGet(int idx, Model model) {
		NoticeVO vo = noticeService.getNUpdate(idx);  // idx로 검색된 공지사항의 정보를 가져온다.(가져온 정보는 무조건 popupSw가 'Y'로 되어 있다)
		model.addAttribute("vo", vo);
		return "notice/popup";
	}
	
}
