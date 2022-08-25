<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>noInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    function fCheck() {
    	var noticeTitle = myForm.noticeTitle.value;
    	var noticeContent = myForm.noticeContent.value;
    	
    	if(noticeTitle == "") {
    		alert("공지사항 제목을 입력하세요");
    		myForm.noticeTitle.focus();
    	}
    	else if(noticeContent == "") {
    		alert("공지사항 내용을 입력하세요");
    		myForm.noticeContent.focus();
    	}
    	else {
	    	if(document.getElementById("popupSw").checked == true) {
	    		document.myForm.popupSw.value = "Y";
	    	}
	    	else {
	    		document.myForm.popupSw.value = "N";
	    	}
	    	myForm.submit();
    		}
    	}
   
  </script>
  <style>
  .btn-secondary {
    color: #fff;
    background-color: #ff792a;
    border-color: rgb(0 0 0 / 8%);
  </style>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>공지사항 수정</h2>
  <form name="myForm" method="post" class="was-validated">
    <div class="form-group">
      <label for="noticeTitle">제목 : </label>
      <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" value="${vo.noticeTitle}" required autofocus/>
      <div class="invalid-feedback">공지사항 제목을 입력하세요.</div>
    </div>
    <div class="form-group">
      <label for="noticeContent">공지사항 : </label>
      <textarea rows="5" class="form-control" id="noticeContent" name="noticeContent" required>${vo.noticeContent}</textarea>
      <div class="invalid-feedback">공지사항 내용을 입력하세요.</div>
    </div>
    <div class="form-group">
      초기화면 공지여부 : &nbsp; &nbsp;
      <input type="checkbox" id="popupSw" name="popupSw" <c:if test="${vo.popupSw == 'Y'}">checked</c:if>/>초기화면에 팝업창을 띄웁니다.
    </div>
    <br/>
    <div>
      <button type="button" class="btn btn-secondary" onclick="fCheck()">수정</button> &nbsp;
      <button type="reset" class="btn btn-secondary">취소</button> &nbsp;
      <button type="button" class="btn btn-secondary" onclick="javascript:location.href='${ctp}/notice/noList';">돌아가기</button>
    </div>
    <input type="hidden" name="idx" value="${vo.idx}"/>
  </form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>