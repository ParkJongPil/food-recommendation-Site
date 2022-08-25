package com.spring.javagreenS_pjp.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjp.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemIdCheck(@Param("mid") String mid);

	public MemberVO getNickNameCheck(@Param("nickName") String nickName);

	public void setMemInputOk(@Param("vo") MemberVO vo);

	public MemberVO getMemIdEmailCheck(@Param("mid") String mid, @Param("toMail") String toMail);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public MemberVO getMemIdSearchOk(@Param("email") String email);

	public int setMemUpdateOk(@Param("fName") MultipartFile fName, @Param("vo") MemberVO vo);

	public void setMemUpdateOk(@Param("vo") MemberVO vo);

	public ArrayList<MemberVO> getMemList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt();

	public void setMemDeleteOk(@Param("mid") String mid);

	public String getTodayVisitDate();

	public void setTodayVisitCountInsert();

	public void setTodayVisitCountUpdate(@Param("strToday") String strToday);

	public MemberVO getMemEmailCheck(@Param("email") String email);

	public void setMemberVisitProcess(@Param("mid") String mid);

	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);


}
