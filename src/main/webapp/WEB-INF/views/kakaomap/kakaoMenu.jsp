<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div>
  <p>
    <a href="${ctp}/study/kakaoEx1" class="btn btn-success">마커표시/DB저장</a>&nbsp;
    <a href="${ctp}/study/kakaoEx2" class="btn btn-secondary">DB에저장된지명검색/삭제</a>&nbsp;
    <a href="${ctp}/study/kakaoEx3" class="btn btn-info">지명검색</a>&nbsp;
    <a href="${ctp}/study/kakaoEx4" class="btn btn-primary">카테고리별 장소검색(DB)</a>&nbsp;
  </p>
</div>