<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mainSearch.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<style>
	body{
		color:black;
	}
	h2{
		margin-left: 10%;
		margin-top: 3%;
	}
</style>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
	<div class="container" >
	    <div>
	      <h3><b style="color:orange">${searchString}</b> 맛집 인기 검색순위</h3>
		  <a href="${ctp}/restaurantFilter" style="color: #9b9b9b; background:transparent; border:0px; margin-left:66%"><i class="fa-solid fa-sliders fa-2x"> 필터</i></a>
	    </div>
		<div>
			<c:forEach var="vo" items="${searchVos}">
				<div>
				  <img src="${ctp}/data/foodImages/${vo.FSName}" width="250px"/>
				  <h2>음식점 명 : <font color="orange">${vo.restaurantName}</font></h2>
				</div>
			</c:forEach>
		</div>
  </div>
<p><br/></p>
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}">
	    <li class="page-item"><a href="mainSearch?pag=1&searchString=${searchString}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	    <li class="page-item"><a href="mainSearch?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&searchString=${searchString}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">	
	      <li class="page-item active"><a href="mainSearch?pag=${i}&searchString=${searchString}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='mainSearch?pag=${i}&searchString=${searchString}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="mainSearch?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchString=${searchString}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="mainSearch?pag=${pageVO.totPage}&searchString=${searchString}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록 페이징 처리 끝 -->
 <input type="hidden" name="pag" value="${pageVO.pag}"/>
 <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>