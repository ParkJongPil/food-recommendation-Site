<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memNickCheck</title>
<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
    function sendCheck() {
    	opener.window.document.myForm.nickName.value = '${nickName}';
    	opener.window.document.myForm.name.focus();
    	window.close();
    }
    
    // 중복 아이디를 다시 체크하기
    function nickCheck() {
    	let nickName = childForm.nickName.value;
    	
    	if(nickName == "") {
    		alert("닉네임을 입력하세요!");
    		childForm.nickName.focus();
    	}
    	else {
    		childForm.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>닉네임 체크폼</h3>
  <c:if test="${res == 1}">
    <h4><font color="blue">${nickName}</font> 닉네임은 사용 가능합니다.</h4>
    <p><input type="button" value="창닫기" onclick="sendCheck()"/></p>
  </c:if>
  <c:if test="${res != 1}">
    <h4><font color="blue">${nickName}</font> 닉네임은 이미 사용중인 닉네임 입니다.</h4>
    <form name="childForm" method="post" action="${ctp}/member/memNickCheck">
      <p>
	      <input type="text" name="nickName"/>
	    	<input type="button" value="닉네임검색" onclick="nickCheck()"/>
    	</p>
    </form>
  </c:if>
</div>
</body>
</html>