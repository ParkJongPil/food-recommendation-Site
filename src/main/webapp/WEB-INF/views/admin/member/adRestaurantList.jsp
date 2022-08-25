<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adRestaurantList.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

<script>
	'use strict';
	function restaurantDelete(idx) {	//등록된 음식점 삭제하기
		let ans = confirm("선택한 식당을 삭제하시겠습니까?");
		if(ans) {
			$.ajax({
				type: 'post',
				url: '${ctp}/admin/restaurantDelete',
				data:{
					idx:idx
				},
				success:function() {
					location.reload();
				}						
			});
		}
	}
</script>

</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">식당 리스트</h2>
  <br/>
  <table class="table table-hover text-center">
    <tr class="title">
    	<th>번호</th>
    	<th>식당명</th>
    	<th>식당 카테고리</th>
    	<th>식당 주소</th>
    	<th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${rVos}" varStatus="st">
    	<tr>
    	  <td>${curScrStartNo}</td>
    	  <td><a href="${ctp}/restaurantInfor?idx=${vo.idx}&restaurantName=${vo.restaurantName}" style="color:blue;"><b>${vo.restaurantName}</b></a></td>
    	  <td>${vo.foodCategory}</td>
    	  <td>${vo.restaurantAddress}</td>
    	  <td>
	    	  <i class="fa-solid fa-trash-can">
	    	  	<input type="button" value="삭제" class="btn btn-normal"onclick="restaurantDelete(${vo.idx})">
	    	  </i>
    	  </td>
    	  <td>
    	</tr>
    	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
    </c:forEach>
    <tr><td colspan="3"></td></tr>
  </table>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="block">
  <ul class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}">
	    <li class="page-item"><a href="adRestaurantList?pag=1" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	    <li class="page-item"><a href="adRestaurantList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">	
	      <li class="page-item active"><a href="adRestaurantList?pag=${i}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href="adRestaurantList?pag=${i}" class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="adRestaurantList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="adRestaurantList?pag=${pageVO.totPage}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록 페이징 처리 끝 -->
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>