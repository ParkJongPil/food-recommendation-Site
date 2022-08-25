<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    	
    	if(noticeTitle.trim() == "") {
    		alert("공지사항 제목을 입력하세요");
    		myForm.noticeTitle.focus();
    	}
/*      	else if(noticeContent.trim() == "") {
    		alert("글내용을 입력하세요");
    		myForm.noticeContent.focus();
    	}  */
    	else {
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
  <form name="myForm" method="post">
	  <table class="table table-borderless">
	    <tr>
	      <td><h2>공지사항 글쓰기</h2></td>
	    </tr>
	  </table>
	  <table class="table">
	    <tr>
	      <th>글 제목</th>
	      <td><input type="text" name="noticeTitle" placeholder="제목을 입력하세요" class="form-control" autofocus required /></td>
	    </tr>
	    <tr>
	      <th>글 내용</th>
	      <td><textarea rows="6" name="noticeContent" id="CKEDITOR" class="form-control" required></textarea></td>
	      <script>
	      	CKEDITOR.replace("noticeContent",{
	      		height:500,
	      		filebrowserUploadUrl : "${ctp}/imageUpload",
	      		uploadUrl : "${ctp}/imageUpload"
	      	});
	      </script>
	    </tr>
	    <tr>
	      <td colspan="2" class="text-center">
	        <input type="button" value="작성하기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="reset" value="다시 입력" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noList';" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
  </form>
</div>
<br/>
</body>
</html>