package com.spring.javagreenS_pjp.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjp.common.ProjectSupport;
import com.spring.javagreenS_pjp.dao.MemberDAO;
import com.spring.javagreenS_pjp.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemIdCheck(String mid) {
		return memberDAO.getMemIdCheck(mid);
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemInputOk(MultipartFile fName, MemberVO vo) {
		// 사진작업 처리후 DB에 저장
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				ProjectSupport ps = new ProjectSupport();
				ps.writeFile(fName, saveFileName,"member");
				vo.setPhoto(saveFileName);
			}
			memberDAO.setMemInputOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int fileUpload(MultipartFile fName) {
		int res = 0;
		try {
			UUID uid = UUID.randomUUID();
			String oFileName = fName.getOriginalFilename();
			String saveFileName = uid + "_" + oFileName;
			
			writeFile(fName, saveFileName);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/test/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public MemberVO getMemIdEmailCheck(String mid, String toMail) {
		return memberDAO.getMemIdEmailCheck(mid, toMail);
	}

	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDAO.setPwdChange(mid, pwd);
	}

	@Override
	public MemberVO getMemIdSearchOk(String email) {
		return memberDAO.getMemIdSearchOk(email);
	}

	@Override
	public int setMemUpdateOk(MultipartFile fName, MemberVO vo) {
		int res = 0; 
		try {
			String oFileName = fName.getOriginalFilename();
			if(!oFileName.equals("")) {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				ProjectSupport ps = new ProjectSupport();
				ps.writeFile(fName, saveFileName,"member");
				
				//기존 존재하는 파일 삭제하기
				if(!vo.getPhoto().equals("noimage.jpg")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String uploadPath = "";
			  uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");
			  File file = new File(uploadPath + vo.getPhoto());
			  file.delete();
			}
				 //기존 파일을 지우고, 새로 업로드된 파일명을 set시킨다.
				  vo.setPhoto(saveFileName);
			}
				
			memberDAO.setMemUpdateOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize) {
		return memberDAO.getMemList(startIndexNo, pageSize);
	}
	@Override
	public int totRecCnt() {
		return memberDAO.totRecCnt();
	}

	@Override
	public void setMemDeleteOk(String mid) {
		memberDAO.setMemDeleteOk(mid);		
	}

	@Override
	public String getTodayVisitDate() {
		return memberDAO.getTodayVisitDate();
	}

	@Override
	public void setTodayVisitCountInsert() {
		memberDAO.setTodayVisitCountInsert();
	}

	@Override
	public void setTodayVisitCountUpdate(String strToday) {
		memberDAO.setTodayVisitCountUpdate(strToday);

	}

	@Override
	public MemberVO getMemEmailCheck(String email) {
		return memberDAO.getMemEmailCheck(email);
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
			memberDAO.setMemberVisitProcess(vo.getMid());
	}

	@Override
	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email) {
			memberDAO.setKakaoMemberInputOk(mid, pwd, nickName, email);
	}

}
