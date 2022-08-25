<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>restaurantTopList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

	<style>
		body{
			color:black;
		}
		h2{
			margin-left: 10%;
			margin-top: 3%;
		}
		.tag{
			color: #6a6a6a;
	    border: 1px solid #cbcbcb;
	    border-radius: 50px;
	    background-color: #fff;
	    margin: 15px 3px 0 3px;
	    padding: 0 15px;
	    font-size: 0.938rem;
	    line-height: 38px;
	    text-align:center;
	    width: 85px;
	    height: 38px;
	    display:inline-grid;
	    align-content: center;
	    
		a:hover {
	    color: black;
	    text-decoration:none;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container" style="margin-left:25%; margin-top:7%;" >
  	<h3 style="color:#ff792a"><b>${searchString}</b> 믿고 보는 맛집 리스트</h3>
		<table class="table table-borderless" style="width:100%;">
			<tr>
				<td>
					<div style="width:100%; cursor:pointer;">
						<a class="tag" href="${ctp}/restaurantTopList?hashTag=#전체" style="background-color:#red; border:1px solid #cbcbcb; width:100px; height:30px; border-radius: 50px;">
							#전체
						</a> &nbsp;
						<c:forEach var="vo" items="${hashVos}">
							<a class="tag" href="${ctp}/restaurantTopList?hashTag=${vo.hashTag}" style="background-color:#fff; border:1px solid #cbcbcb; width:130px; height:30px; border-radius: 50px;">#${vo.hashTag}</a> &nbsp;
						</c:forEach>
						<p><br/></p>
						<c:forEach var="vo" items="${restaurantVos}">
							<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
							<div class="w3-left" style="width:50%; margin-left:42px; height:300px; background-color:#ffffff; display:flex; flex-direction:column;">
									<a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}">
										<img src="${ctp}/data/foodImages/${bgImage[0]}"  style="width:600px; height:290px; z-index:1; filter: brightness(0.5); margin-right:-20%;"/>
									</a>
									<img src="${ctp}/data/qrCode/${vo.restaurantName}.png" style="width:100px; z-index:3; margin-top:-100px" />
									<div style="color:black; text-align:center; margin-top:-17%; z-index:2; font-size: medium; margin-left: 11%; width:100%;">
										<span class="title" style="font-size:28px; color:#ffffff; over-flow:hidden; text-align:center;">${vo.restaurantName}</span>
								  	<c:if test="${vo.restaurantContent != null}">
											<p style="font-size:21px; color:#ffffff;" id="show2">${fn:substring(vo.restaurantContent,0,25)}</p>
										</c:if>
										<c:if test="${vo.restaurantContent == null}">
											<p style="font-size:21px; color:#ffffff; width:104%;" id="show2"></p>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
			</table>	
  	</div>
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