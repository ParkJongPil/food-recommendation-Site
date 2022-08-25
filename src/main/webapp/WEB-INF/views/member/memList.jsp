<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memList.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container" style="margin-top: 170px;">
	  <h2 class="text-center">전체 회원 리스트</h2>
	  <br/>
	  <table class="table table-hover text-center">
	    <tr class="title">
	    	<th>번호</th>
	    	<th>아이디</th>
	    	<th>이메일</th>
	    	<th>닉네임</th>
	    	<th>성명</th>
	    	<th>성별</th>
	    </tr>
	    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	    	<tr>
	    	  <td>${curScrStartNo}</td>
	    	  <td>${vo.mid}</td>
	    	  <td>${vo.email}</td>
	    	  <td>${vo.nickName}</td>
	    	  <td>${vo.name}</td>
	    	  <td>${vo.gender}</td>
	    	</tr>
	    	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
	    </c:forEach>
	    <tr><td colspan="5"></td></tr>
	  </table>
	</div>
	<!-- 블록 페이징 처리 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}">
		    <li class="page-item"><a href="memList?pag=1" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		    <li class="page-item"><a href="memList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">	
		      <li class="page-item active"><a href="memList?pag=${i}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href='memList?pag=${i}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="memList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		    <li class="page-item"><a href="memList?pag=${pageVO.totPage}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
	  </ul>
	</div>
	<!-- 블록 페이징 처리 끝 -->
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>