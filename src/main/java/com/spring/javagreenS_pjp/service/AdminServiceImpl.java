package com.spring.javagreenS_pjp.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javagreenS_pjp.dao.AdminDAO;
import com.spring.javagreenS_pjp.vo.ChartVO;
import com.spring.javagreenS_pjp.vo.KakaoAddressVO;
import com.spring.javagreenS_pjp.vo.MemberVO;
import com.spring.javagreenS_pjp.vo.QrCodeVO;
import com.spring.javagreenS_pjp.vo.RestaurantVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	
	@Override
	public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize) {
		return adminDAO.getMemList(startIndexNo, pageSize);
	}

	@Override
	public void adMemLevelChange(int idx, int level) {
		adminDAO.adMemLevelChange(idx,level);
	}

	@Override
	public void setRestaurantCreate(RestaurantVO vo, MultipartHttpServletRequest mfile) {
		try {
			List<MultipartFile> fileList = mfile.getFiles("file");
			String oFileNames = "";
			String sFileNames= "";
			int fileSizes =0;
			
			for(MultipartFile file : fileList) {
				System.out.println("mfile2:"+file);
				String oFileName = "noimage.jpg";
				String sFileName = "noimage.jpg";
				if(file.getOriginalFilename() != null) {
					oFileName = file.getOriginalFilename();
					sFileName = saveFileName(oFileName);		//????????? ????????? ???????????? ??????

				}

				writeFile(file,sFileName); 					// ????????? ?????? ??????????????????
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
			
			System.out.println("vo" +vo);
			adminDAO.setRestaurantCreate(vo);		// DB??? ??????
		} 		catch (Exception e) {
				e.printStackTrace();
		}
	}
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes();
				
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/foodImages/");
				
				FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
				fos.write(data);
				fos.close();
	}

	// ???????????? ???????????? ????????? ???????????? ?????? ?????? ????????? ?????? 
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName	+= cal.get(Calendar.YEAR);
		fileName	+= cal.get(Calendar.MONTH);
		fileName	+= cal.get(Calendar.DATE);
		fileName	+= cal.get(Calendar.HOUR);
		fileName	+= cal.get(Calendar.MINUTE);
		fileName	+= cal.get(Calendar.SECOND);
		fileName	+= cal.get(Calendar.MILLISECOND);
		fileName	+= "_" + oFileName;
		return fileName;
	}

	@Override
	public void setFoodCreate(RestaurantVO vo) {
		adminDAO.setFoodCreate(vo);
	}

	@Override
	public void setFoodSaleCreate(RestaurantVO vo) {
		adminDAO.setFoodSaleCreate(vo);
	}

	@Override
	public String[] getRestaurantCreate() {
		return adminDAO.getRestaurantCreate();
	}

	@Override
	public String[] getFoodCreate() {
		return adminDAO.getFoodCreate();
	}

	@Override
	public void setAddressName(KakaoAddressVO vo) {
		adminDAO.setAddressName(vo);
	}

	@Override
	public KakaoAddressVO getAddressName(String address) {
		return adminDAO.getAddressName(address);
	}

	@Override
	public List<KakaoAddressVO> getAddressNameList() {
		return adminDAO.getAddressNameList();
	}

	@Override
	public void adAddressDelete(String address) {
		adminDAO.adAddressDelete(address);
	}

	@Override
	public String[] getFoodPrice() {
		return adminDAO.getFoodPrice();
	}

	@Override
	public ArrayList<RestaurantVO> getRestaurantList(int startIndexNo, int pageSize) {
		return adminDAO.getRestaurantList(startIndexNo, pageSize);
	}

	@Override
	public void setRestaurantDelete(int idx) {
		adminDAO.setRestaurantDelete(idx);
	}

	@Override
	public void setHashTagInput(String hashTag) {
		adminDAO.setHashTagInput(hashTag);
	}

	@Override
	public String qrCreate(String uploadPath, QrCodeVO vo) {
		
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0,4);
		String qrCodeName = "";
		
	  qrCodeName = vo.getRestaurantName();
	  try {
	      File file = new File(uploadPath);		// qr?????? ???????????? ????????? ???????????? ??????
	      if(!file.exists()) {
	          file.mkdirs();
	      }
	      String codeurl = new String(vo.getMoveUrl().getBytes("UTF-8"), "ISO-8859-1");	// qr?????? ????????? ????????? url ??????
	      //int qrcodeColor = 0xFF2e4e96;			// qr?????? ????????? ?????????(?????????)
	      int qrcodeColor = 0xFF000000;			// qr?????? ????????? ?????????(?????????) - ?????? 6????????? ???????????????
	      int backgroundColor = 0xFFFFFFFF;	// qr?????? ???????????????
	      
	      QRCodeWriter qrCodeWriter = new QRCodeWriter();
	      BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE,200, 200);
	      
	      MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor);
	      BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
	      
	      ImageIO.write(bufferedImage, "png", new File(uploadPath + qrCodeName + ".png"));		// ImageIO??? ????????? ????????? ????????????
	      
	      // qr?????? ????????? ????????? DB??? ????????????
	      vo.setQrCode(qrCodeName);
	      System.out.println("qrCodeName : " + qrCodeName);
	      adminDAO.qrCreate(vo);
	  } catch (Exception e) {
	      e.printStackTrace();
	  }
	  return qrCodeName;
	}

	@Override
	public List<ChartVO> getRecentlyVisitCount() {
		return adminDAO.getRecentlyVisitCount();
	}

}
