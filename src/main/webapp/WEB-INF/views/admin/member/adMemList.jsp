<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adList.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

	<script>
		'use strict';
			function levelChange() {
				alert("등급변경 버튼을 클릭하시면 선택된 등급으로 변환됩니다.");
			}
	</script>
	<style>
	.btn-secondary {
	    color: #fff;
	    background-color: #ff792a;
	    border-color: rgb(0 0 0 / 8%);
	    }
	</style>
</head>
<body>
	<p><br/></p>
	<div class="container">
	  <h2 class="text-center">회원 리스트</h2>
	  <br/>
	  <table class="table table-hover text-center">
	    <tr class="title">
	    	<th>번호</th>
	    	<th>아이디</th>
	    	<th>이메일</th>
	    	<th>성명</th>
	    	<th>닉네임</th>
	    	<th>성별</th>
	    	<th>등급</th>
	    	<th>회원 상태</th>
	    </tr>
	    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	    	<tr>
	    	  <td>${curScrStartNo}</td>
	    	  <td>${vo.mid}</td>
	    	  <td>${vo.email}</td>
	    	  <td>${vo.name}</td>
	    	  <td>${vo.nickName}</td>
	    	  <td>${vo.gender}</td>
	    	  <td>
		    	<form name="levelForm" method="post" action="${ctp}/admin/adMemLevelChange">	
						<select name="level" onchange="levelChange()">
							<option value="0" <c:if test="${vo.level == 0}">selected</c:if>>관리자</option>
							<option value="1" <c:if test="${vo.level == 1}">selected</c:if>>운영자</option>
							<option value="2" <c:if test="${vo.level == 2}">selected</c:if>>정회원</option>
							<option value="3" <c:if test="${vo.level == 3}">selected</c:if>>준회원</option>
						</select>
						<input type="submit" value="등급변경" class="btn2 btn-secondary btn-sm"/>
						<input type="hidden" name="idx"  value="${vo.idx}"/> 
						<input type="hidden" name="mid" id="mid" value="${vo.mid}"/>
					</form>
	    	  <td>
	    	  	<c:if test="${vo.userDel =='OK'}"><font color="red">탈퇴신청</font></c:if>
	    	  	<c:if test="${vo.userDel != 'OK'}"><b style="color:blue;">활동중</b></c:if>
	    	  </td>
	    	</tr>
	    	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
	    </c:forEach>
	    <tr><td colspan="5"></td></tr>
	  </table>
	</div>
	<!-- 블록 페이징 처리 시작 -->
	<div class="block">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}">
		    <li class="page-item"><a href="adMemList?pag=1" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		    <li class="page-item"><a href="adMemList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">	
		      <li class="page-item active"><a href="adMemList?pag=${i}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href="adMemList?pag=${i}" class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="adMemList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		    <li class="page-item"><a href="adMemList?pag=${pageVO.totPage}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
	  </ul>
	</div>
	<!-- 블록 페이징 처리 끝 -->
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>