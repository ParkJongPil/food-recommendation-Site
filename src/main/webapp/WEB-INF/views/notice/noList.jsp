<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>noList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
    'use strict';
		function arrowToggle(idx) {
    	$('.b'+idx).slideToggle(500);
    }
		function nDelCheck(idx) {
			var ans = confirm("해당 공지사항을 삭제하시겠습니까?");
			if(!ans) return false;
			var query ={idx :idx};
	
			$.ajax({
				type:"get",
				url:"${ctp}/notice/nDelete",
				data: query,
				success:function(data) {
					if(data ==1) {
						alert('삭제 완료!!');
						$("#noticeContent").load("${ctp}/notice/noList #noticeContent");
					}
					else {
						alert('삭제 실패');
					}
				},
				error:function() {
					alert('서버 오류(삭제 실패)~'); 
				}
			}); 
		}
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container" class="p-3">
		<div id="noticeContent">
			<h1 style="text-align:center; font-size: 1.8rem; color: #ff792a; margin-bottom: 30px; line-height: 2rem;">공지사항 리스트</h1>
			<c:forEach var="vo" items="${nVos}" varStatus="st">
				<div class="a${st.index}" >
					<div style="width:100%; float: left;  margin-top: 3%; padding-top: 2%;">
						<span style = "font-size:18px">${vo.noticeTitle}</span><br/>
						<span style="color: blue; font-size: 0.7rem;">${fn:substring(vo.NDate,0,10)}</span>
						<div style="float:right">
							<img src="${ctp}/images/arrow.png" style="margin-bottom:20px" onclick="arrowToggle(${st.index})"/>
						</div>
					</div>
					<c:if test="${sMid=='admin'}">
						<button type="button" value="작성" class="btn btn-danger" style="color: #fff; background-color: #ff792a; border-color: rgb(0 0 0 / 8%);"onclick="location.href='${ctp}/notice/noInput';">작성</button>
					</c:if>
					<c:if test="${sMid=='admin'}">
						<button type="button" value="수정" class="btn btn-danger" style="color: #fff; background-color: #ff792a; border-color: rgb(0 0 0 / 8%);"onclick="location.href='${ctp}/notice/noUpdate?idx=${vo.idx}';">수정</button>
					</c:if>
					<c:if test="${sMid=='admin'}">
						<button type="button" value="삭제" class="btn btn-danger" style="color: #fff; background-color: #ff792a; border-color: rgb(0 0 0 / 8%);"onclick="nDelCheck('${vo.idx}')">삭제</button>
					</c:if>
				</div>
				<div class="b${st.index}" style="display:none;">
					<p>${vo.noticeContent}</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<p><br/></p>
</body>
</html>