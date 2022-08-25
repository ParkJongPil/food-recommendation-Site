package com.spring.javagreenS_pjp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjp.vo.NoticeVO;

public interface NoticeDAO {

	public void setNoticeInput(@Param("vo") NoticeVO vo);

	public List<NoticeVO> getNoticeList();

	public NoticeVO getNUpdate(@Param("idx") int idx);

	public List<NoticeVO> getNotifyPopup();

	public NoticeVO getNoUpdate(@Param("idx") int idx);

	public void setNoUpdateOk(@Param("vo") NoticeVO vo);

	public void setDelete(@Param("idx") int idx);


}
