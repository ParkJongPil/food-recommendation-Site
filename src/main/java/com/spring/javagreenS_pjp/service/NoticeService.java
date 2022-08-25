package com.spring.javagreenS_pjp.service;

import java.util.List;

import com.spring.javagreenS_pjp.vo.NoticeVO;

public interface NoticeService {

	public void setNoticeInput(NoticeVO vo);

	public List<NoticeVO> getNoticeList();

	public NoticeVO getNUpdate(int idx);

	public List<NoticeVO> getNotifyPopup();

	public NoticeVO getNoUpdate(int idx);

	public void setNoUpdateOk(NoticeVO vo);

	public void setDelete(int idx);



		
	
	
}
