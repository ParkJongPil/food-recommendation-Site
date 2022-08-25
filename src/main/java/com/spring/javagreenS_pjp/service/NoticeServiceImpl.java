package com.spring.javagreenS_pjp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjp.dao.NoticeDAO;
import com.spring.javagreenS_pjp.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;

	@Override
	public void setNoticeInput(NoticeVO vo) {	//공지사항 작성하기
		noticeDAO.setNoticeInput(vo);
	}

	@Override
	public List<NoticeVO> getNoticeList() {	//공지사항 리스트 보여주기
		return noticeDAO.getNoticeList();
	}

	@Override
	public NoticeVO getNUpdate(int idx) { //공지사항 팝업 만들기
		return noticeDAO.getNUpdate(idx);
	}

	@Override
	public List<NoticeVO> getNotifyPopup() {	//메인 페이지에 공지사항 팝업 띄어주기
		return noticeDAO.getNotifyPopup();
	}

	@Override
	public NoticeVO getNoUpdate(int idx) {	//공지사항 수정 페이지 보여주기
		return noticeDAO.getNoUpdate(idx);
	}

	@Override
	public void setNoUpdateOk(NoticeVO vo) {	// 공지사항 수정하기
		 noticeDAO.setNoUpdateOk(vo);
	}

	@Override
	public void setDelete(int idx) {	//공지사항 삭제하기
		noticeDAO.setDelete(idx);
	}
}
