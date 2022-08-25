package com.spring.javagreenS_pjp.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjp.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemIdCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInputOk(MultipartFile fName, MemberVO vo);

	public int fileUpload(MultipartFile fName);

	public MemberVO getMemIdEmailCheck(String mid, String toMail);

	public void setPwdChange(String mid, String pwd);

	public MemberVO getMemIdSearchOk(String email);

	public int setMemUpdateOk(MultipartFile fName, MemberVO vo);

	public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize);
	
	public int totRecCnt();

	public void setMemDeleteOk(String mid);

	public String getTodayVisitDate();

	public void setTodayVisitCountInsert();

	public void setTodayVisitCountUpdate(String strToday);

	public MemberVO getMemEmailCheck(String email);

	public void setMemberVisitProcess(MemberVO vo);

	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email);

}
