<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memIdPwdSearch.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <script>
  	'use strict';
  	
  	$(document).ready(function(){
  		$(".titleTab").click(function(){
  			$("#demo").html('');
  		});
  		
  		$("#idTab").click(function(){
  			$("#idEmail").val('');
  		});
  		
  		$("#pwdTab").click(function(){
  			$("#passwordSearch").show();
  			$("#pwdMid").val('');
  			$("#pwdEmail").val('');
  		});
  		
  		$("#noticeTab").click(function(){
  			$("#passwordSearch").hide();
  		});
  	});  	
  	
  	// 아이디 검색하기
    function idSearch() {
    	let email = $("#idEmail").val();
    	
    	if(email == "") {
    		alert("이메일 주소를 입력하세요");
    		$("#idEmail").focus();
    		return false;
    	}
    	
    	$.ajax({
    		type   : "post",
 	 		url    : "${ctp}/member/memIdSearchOk", 
 			data   : {email : email},
    		success: function(data) {
    			if(data == "") {
    				alert("등록된 자료가 없습니다.");
    				document.getElementById('demo').innerHTML="";
    			}
    			else {
    				alert("아이디를 찾았습니다.");
    				document.getElementById('demo').innerHTML="찾으시는 아이디는 <font color='blue'><b>"+data+"</b></font> 입니다.";

    			}
    		},
    		error : function() {
    			alert("전송오류~~");
    		}
    	});
    }
    
  	// 비밀번호 검색하기
    function pwdSearch() {
    	let mid = $("#pwdMid").val();
    	let email = $("#pwdEmail").val();
    	
    	if(mid == "") {
    		alert("아이디를 입력하세요");
    		$("#pwdMid").focus();
    		return false;
    	}
    	else if(email == "") {
    		alert("이메일 주소를 입력하세요");
    		$("#pwdEmail").focus();
    		return false;
    	}
    	
    	else {
    		location.href="${ctp}/member/memIdPwdSearchOk?mid="+mid+"&toMail="+email;	
    	  }
    	}
    
  	// 신규비밀번호 등록
  	function pwdInputCheck() {
  		let mid = $("#pwdMid").val();
  		let newPwd1 = $("#newPwd1").val();
  		let newPwd2 = $("#newPwd2").val();
  		
  		if(newPwd1.trim() == "") {
  			alert("신규 비밀번호를 입력하세요");
  			$("#newPwd1").focus();
  			return false;
  		}
  		else if(newPwd2.trim() == "") {
  			alert("신규 비밀번호 확인란를 입력하세요");
  			$("#newPwd2").focus();
  			return false;
  		}
  		else if(newPwd1 != newPwd2) {
  			alert("신규비밀번호가 틀립니다. 확인하세요.");
  			$("#newPwd2").focus();
  			return false;
  		}
  		
  		$.ajax({
    		type   : "post",
    		url    : "${ctp}/member/memPwdUpdate",
    		data   : {
    			mid  : mid,
    			pwd: newPwd1
    		},
    		success: function(data) {
    			if(data == "1") {
    				alert("신규비밀번호가 등록되었습니다.");
    				location.href = "${ctp}/member/memLogin";
    			}
    			else {
    				alert("신규비밀번호 등록 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송오류~~");
    		}
    	});
  	} 
  </script>
	<style>
	.btn-info {
    color: #fff;
    background-color: #ff792a;
    border-color: #ff792a;
	}
	.btn-primary {
	    color: #fff;
	    background-color: #adb5bd;
	    border-color: #adb5bd;
	}
	a {
    color: #ff792a;
    text-decoration: none;
    background-color: transparent;
	}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container w3-border" style="margin-top:100px;">
		<form action="${ctp}/member/memIdSearchOk" method="post">
		  <h2>아이디 / 비밀번호 찾기</h2>
		  <br/><br/>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li class="nav-item">
		      <a class="nav-link active titleTab" data-toggle="tab" href="#idSearch" id="idTab">아이디찾기</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link titleTab" data-toggle="tab" href="#passwordSearch" id="pwdTab">비밀번호찾기</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link titleTab" href="memLogin.mem">돌아가기</a>
		    </li>
		  </ul>
		
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div id="idSearch" class="container tab-pane active"><br/>
		      <h4>아이디찾기</h4>
		        <div>회원가입시에 등록하셨던 <font color="#ff792a"><b>이메일 주소</b></font> 를 입력해주세요.</div>
		        <div class="input-group">
		        	<input type="text" name="email" id="idEmail" class="form-control m-1">
		        	<div>
		        		<input type="button" value="아이디찾기" onclick="idSearch()" class="btn btn-primary input-group-append m-1"/>
		        	</div>
		        </div> 
		    </div>
		    <div id="passwordSearch" class="container tab-pane fade"><br/>
		      <h4>비밀번호찾기</h4>
		      	<div>회원가입시에 등록하셨던 <font color="#ff792a"><b>아이디 / 이메일 주소</b></font> 를 입력해주세요.</div>
		        <div><input type="text" name="mid" id="pwdMid" placeholder="아이디를 입력하세요" class="form-control m-1"></div>
		        <div><input type="text" name="email" id="pwdEmail" placeholder="이메일 주소를 입력하세요" class="form-control m-1"></div>
		        <div><input type="button" value="비밀번호찾기" id="passwordBtn" onclick="pwdSearch()" class="btn btn-primary form-control m-1"/></div>
		    </div>
		  </div>
		  <hr/>
		  <div id="demo" class="container"></div>
		  <div class="container"><input type="button" value="로그인창으로 이동" onclick="location.href='${ctp}/member/memLogin';" class="btn2 btn-info form-control"/></div>
		</form>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>