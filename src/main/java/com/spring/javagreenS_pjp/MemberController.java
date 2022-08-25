package com.spring.javagreenS_pjp;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjp.pagination.PageProcess;
import com.spring.javagreenS_pjp.pagination.PageVO;
import com.spring.javagreenS_pjp.service.MemberService;
import com.spring.javagreenS_pjp.vo.MailVO;
import com.spring.javagreenS_pjp.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	// 회원 로그인
	@RequestMapping(value = "/memLogin", method = RequestMethod.GET)
	public String memLoginGet(HttpServletRequest request) {
		// 로그인폼 호출시 기존에 저장된 쿠키가 있다면 불러와서 mid에 담아서 넘겨준다.
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		
		return "member/memLogin";
	}
		
	// 로그인 인증처리
	@RequestMapping(value = "/memLogin", method = RequestMethod.POST)
	public String memLoginPost(
			Model model,
			// RedirectAttributes redirect,
			HttpServletRequest request, HttpServletResponse response,
			String mid,
			String pwd,
			@RequestParam(name="idCheck", defaultValue = "", required = false) String idCheck,
			HttpSession session) {
		
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			// 회원 인증처리된경우에 수행할 내용들을 기술한다.(session에 저장할자료 처리, 쿠키값처리...)
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "운영자";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			//session.setAttribute("sLastDate", vo.getLastDate());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 정함(단위:초)
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);		// 기존에 저장된 현재 mid값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			// 오늘 총 사용자의 방문횟수를 누적한다.(오늘날짜로 첫 방문은 1이되고, 그렇지 않으면 기존의 오늘 날짜에 +1 시킨다.)
			String visitDate = memberService.getTodayVisitDate();
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(!strToday.equals(visitDate)) {
				memberService.setTodayVisitCountInsert();
			}
			else {
				memberService.setTodayVisitCountUpdate(strToday);
			}
			
			model.addAttribute("mid", mid);
			//redirect.addAttribute("mid", mid);	// RedirectAttributes객체가 선언된 상태에서 model로 값을 넘길때는 값이 넘어가지 않는다.
			return "redirect:/msg/memLoginOk";
		}
			else {
				return "redirect:/msg/memLoginNo";
			}
		}
		
	//로그인 인증처리2(카카오로그인 인증처리)
	// 카카오에서 인증처리가 되었다면 이곳은 그대로 로그인처리 시켜준다.
	// 만약 이곳에 가입되어 있지 않다면, 카카오에서 넘어온 정보(여기선, 닉네임과 이메일)로 자동 회원가입시켜준다.
	@RequestMapping(value = "/memKakaoLogin", method = RequestMethod.GET)
	public String memKakaoLoginGet(
			Model model,
			HttpSession session) {
		String email = (String) session.getAttribute("sEmail");
		System.out.println("email : " + email);
		
		MemberVO vo = memberService.getMemEmailCheck(email);
		
		if(vo != null && vo.getUserDel().equals("NO")) {
			// 회원 인증처리된경우에 수행할 내용들을 기술한다.(session에 저장할 자료 처리, 쿠키값처리)
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "운영자";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			// 현재 로그인한 회원의 방문횟수(오늘방문횟수) 누적하기(최종 접속일/방문포인트 처리) - service객체에서 처리하자....
			memberService.setMemberVisitProcess(vo);
			
			// 오늘 총 사용자의 방문횟수를 누적한다.(오늘날짜로 첫 방문은 1이되고, 그렇지 않으면 기존의 오늘 날짜에 +1 시킨다.)
			String visitDate = memberService.getTodayVisitDate();
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(!strToday.equals(visitDate)) {		// 오늘 사이트에 최초방문자 일때는 visit테이블에 오늘날짜 등록한다.
				memberService.setTodayVisitCountInsert();
			}
			else {		// 오늘 사이트에 최초방문자가 아닐때는 일때는 visit테이블 오늘날짜에 업데이트한다.
				memberService.setTodayVisitCountUpdate(strToday);
			}
			
			model.addAttribute("mid", vo.getMid());
			//redirect.addAttribute("mid", mid);	// RedirectAttributes객체가 선언된 상태에서 model로 값을 넘길때는 값이 넘어가지 않는다.
			return "redirect:/msg/memLoginOk";
		}
		else if(vo != null && !vo.getUserDel().equals("NO")) {  // 탈퇴한 회원이라면 로그인 취소처리함.
			return "redirect:/msg/memLoginNo";
		}
		else {	// 회원 가입되어 있지 않은 회원이라면 자동회원가입처리(닉네임과 이메일만으로 가입처리)한다. 아이디는 이메일앞쪽을 지정해준다.
			String mid = email.substring(0,email.indexOf("@"));
			String nickName = (String) session.getAttribute("sNickName");
			// 비밀번호 암호화 처리
			String pwd = (passwordEncoder.encode("0000"));
			
			// 자동 회원 가입시켜준다.
			memberService.setKakaoMemberInputOk(mid,pwd,nickName,email);
			
			// 다시 로그인 인증으로 보낸다.
			model.addAttribute("email", email);
			return "redirect:/member/memKakaoLogin";
		}
	}
	
	// 로그아웃 처리
	@RequestMapping(value = "/memLogout", method = RequestMethod.GET)
	public String memLogout(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		model.addAttribute("mid", mid);
		return "redirect:/msg/memLogout";
	}
		
	// 로그인 성공시에 memberMain.jsp로 이동하기
	@RequestMapping(value = "/memMain", method = RequestMethod.GET)
	public String memMain(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "member/memMain";
	}
	// 회원 정보 전체 보기(정회원 이상만 볼수 있다.)
	@RequestMapping(value = "/memList", method = RequestMethod.GET)
	public String memberListGet(Model model,
		  @RequestParam(name="pag", defaultValue="1", required= false) int pag,
		  @RequestParam(name="pageSize", defaultValue="3", required= false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"member","","");
		ArrayList<MemberVO> vos = memberService.getMemList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "member/memList";
	}
	//회원 정보 변경 처리전 비밀번호 확인
	@RequestMapping(value = "/memPwdCheck", method = RequestMethod.GET)
	public String memPwdCheckGet() {
		return	"member/memPwdCheck";
	}
	
	// 회원 정보 변경처리를 위한 비밀번호 확인처리하기
	@RequestMapping(value = "/memPwdCheck", method = RequestMethod.POST)
	public String memPwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo", vo);
			return "member/memUpdate";
		}
		else {
			return "redirect:/msg/memPwdCheckNo";
		}
	}
	
	// 회원정보 수정 처리하기
	@RequestMapping(value = "/memUpdateOk", method = RequestMethod.POST)
	public String memUpdateOkPost(MultipartFile fName, MemberVO vo, HttpSession session) {
		// 닉네임 체크
		String nickName = (String) session.getAttribute("sNickName");
		if(memberService.getNickNameCheck(vo.getNickName()) != null && !nickName.equals(vo.getNickName())) {
			return "redirect:/msg/memNickCheckNo2";
		}
		
		// 비밀번호 암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.(회원 가입처리)
		int res = memberService.setMemUpdateOk(fName, vo);
		
		if(res == 1) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/msg/memUpdateOk";
		}
		else return "redirect:/msg/memUpdateNo";
	}
	
	// 회원 탈퇴 처리
	@RequestMapping(value = "/memDeleteOk", method = RequestMethod.GET)
	public String memDeleteOkGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		memberService.setMemDeleteOk(mid);
		
		session.invalidate();
		model.addAttribute("mid",mid);
		
		return "redirect:/msg/memDeleteOk";
	}
	// 회원가입
	@RequestMapping(value = "/memJoin", method = RequestMethod.GET)
	public String memJoinGet() {
		return "member/memJoin";
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/memJoin", method = RequestMethod.POST)
	public String memJoinPost(MultipartFile fName, MemberVO vo) {
		
		// 아이디 체크
		if(memberService.getMemIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/memIdCheckNo";
		}
		// 닉네임 체크
		if(memberService.getNickNameCheck(vo.getNickName()) != null) {
			return "redirect:/msg/memNickCheckNo";
		}
		// 비밀번호 암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.(회원 가입처리)
		int res = memberService.setMemInputOk(fName, vo);
		
		if(res == 1) return "redirect:/msg/memInputOk";
		else return "redirect:/msg/memInputNo";
	}	
	
	// 회원 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/memIdCheck" , method = RequestMethod.POST)
	public String memIdCheckPost(String mid) {
		String res ="0";
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null) 	res ="1";
			
		return res;
	}
	
	// 회원 닉네임 체크
	@ResponseBody
	@RequestMapping(value = "/nickNameCheck",method = RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		String res ="0";
		MemberVO vo  = memberService.getNickNameCheck(nickName);
		if(vo != null) res= "1";
		
		return res;
	}
	
	// BCryptPasswordEncoder 암호화 방식연습
	@RequestMapping(value = "/securityCheck", method = RequestMethod.GET)
	public String securityCheckGet() {
		return "security/security";
	}
	
	@ResponseBody
	@RequestMapping(value = "/securityCheck", method = RequestMethod.POST)
	public String securityCheckPost(String pwd) {
		String encPwd = "";
		
		encPwd = passwordEncoder.encode(pwd);
		
		pwd = "Encoding : " + encPwd + " / Source Password : " + pwd;
		
		return pwd;
	}
		
	// UUID 입력폼
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "uuid/uuidFrom";
	}
	
	// UUID 처리하기
	@ResponseBody
	@RequestMapping(value = "/uuid/uuidProcess", method = RequestMethod.POST)
	public String uuidProcessPost() {
		UUID uid = UUID.randomUUID();
		return uid.toString();
	}
	
	// 파일 업로드폼
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.GET)
	public String fileUploadGet() {
		return "fileUpload/fileUpload";
	}
	
	// 파일 업로드 처리하기
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName) {
		int res = memberService.fileUpload(fName);
		if(res == 1) {
			return "redirect:/msg/fileUploadOk";
		}
		else {
			return "redirect:/msg/fileUploadNo";
		}
	}
	// 아이디/비밀번호 찾기를 위한 '임시비밀번호 발급'해 주기(폼 띄우기)
	@RequestMapping(value = "/memIdPwdSearch", method = RequestMethod.GET)
	public String memIdPwdSearchGet() {
			return "member/memIdPwdSearch";
	}
		
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/memIdSearchOk", method = RequestMethod.POST) 
	public String memIdSearchOkPost(String email) {
	 MemberVO vo = memberService.getMemIdSearchOk(email);
	 if(vo != null) {
		 return vo.getMid();
	}	
	 return "";
	}
	 
	// 비밀번호 찾기 위한 '임시비밀번호 발급'해주기(처리)
	@RequestMapping(value = "/memIdPwdSearchOk", method = RequestMethod.GET)
	public String memIdPwdSearchOkGet(String mid, String toMail) {
		MemberVO vo = memberService.getMemIdEmailCheck(mid, toMail);
		if(vo != null) {
			// 회원정보가 맞으면 임시비밀번호를 만든다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			
			// 발급받은 임시비밀번호를 DB에 저장한다.
			memberService.setPwdChange(mid, passwordEncoder.encode(pwd));
				
			// 임시비밀번호를 메일로 전송한다.
			String content = pwd;
			//return "redirect:/member/mailSend";
			String res = mailSend(toMail, pwd);
			
			if(res.equals("1")) return "redirect:/msg/memIdPwdSearchOk";
			else return "redirect:/msg/memIdPwdSearchNo";
		}
		else {
			return "redirect:/msg/memIdPwdSearchNo";
		}
	}
	// 임시 비밀번호 메일로 발송하기
		public String mailSend(String toMail, String pwd) {
			try {
				String title = "신규 비밀번호가 발급되었습니다.";
				String content = pwd;
				
				// 메세지를 변환시켜서 보관함(messageHelper)에 저장하여 준비한다.
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				// 메일보관함에 회원이 보낸온 메세지를 모두 저장시켜둔다.
				messageHelper.setTo(toMail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				// 메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
				content = "<hr>신규 비밀번호는 : <font color='red'><b>" + content + "</b></font>";
				content += "<br><hr>아래 주소로 다시 로그인 하셔서 비밀번호를 변경하시기 바랍니다.<hr><br>";
				content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
				content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javagreenS_pjp'>javagreenJ사이트</a></p>";
				content += "<hr>";
				messageHelper.setText(content, true);
				
				// 본문에 기재된 그림파일의 경로를 따로 표시 시켜준다.
				FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_pjp\\src\\main\\webapp\\resources\\images\\javagreenS_pjp_main.jpg");
//				FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_pjp\\src\\main\\webapp\\resources\\images\\javagreenS_pjp_main.jpg");
				messageHelper.addInline("main.jpg", file);
				
				// 메일 전송하기
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			
			return "1";
		}
		
		
		// 메일폼 호출
		@RequestMapping(value = "mail/mailForm", method = RequestMethod.GET)
		public String mailFormGet() {
			return "mail/mailForm";
		}
		
		// 임시 비밀번호로 메일 발송하기
		@RequestMapping(value = "mail/mailForm", method = RequestMethod.POST)
		public String mailFormPost(MailVO vo) {
			try {
				String toMail = vo.getToMail();
				String title = vo.getTitle();
				String content = vo.getContent();
				
				// 메세지를 변환시켜서 보관함(messageHelper)에 저장하여 준비한다.
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				// 메일보관함에 회원이 보낸온 메세지를 모두 저장시켜둔다.
				messageHelper.setTo(toMail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				// 메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
				content = content.replace("\n", "<br>");
				content += "<br><hr><h3>길동이가 보냅니다.</h3><hr><br>";
				content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
				content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javagreenS_pjp'>javagreenJ사이트</a></p>";
				content += "<hr>";
				messageHelper.setText(content, true);
				
				// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다.
				FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_pjp\\src\\main\\webapp\\resources\\images\\javagreenS_pjp_main.jpg");
//			FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_pjp\\src\\main\\webapp\\resources\\images\\javagreenS_pjp_main.jpg");
				messageHelper.addInline("main.jpg", file);
				
				// 메일 전송하기
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			
			return "redirect:/msg/mailSendOk";
		}	
}
