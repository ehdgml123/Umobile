<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/csss/memberlogin.css" rel="stylesheet" />
<link href="${path}/resources/csss/subindex.css" rel="stylesheet" />
</head>
<body>

	<!-- 로그인 작업완료 -->
	<%@ include file="../includes/header.jsp"%>

	<div id="login-warp">
		<div class="sub-conts login util-width login-info">

			<div class="page-tit">
				<h1>로그인</h1>
			</div>

			<div class="rq-form">

				<div class="main-txt-group">
					<h2 class="main-txt">가입한 아이디와 비밀번호를 확인해주세요.</h2>
				</div>

				<form action="login" method="post" onsubmit="return checkStuff()">
					<div id="divid" class="box-input">
						<div class="input-wrap">
							<input id="email" type="text" name="username"
								placeholder="이메일(아이디)를 입력해주세요" class="input-default is-delete"
								title="email">
						</div>
						<div class="input-wrap">
							<input id="password" type="password" name="password"
								placeholder="비밀번호 를 입력하세요" class="input-default is-delete"
								title="password">
						</div>
					</div>
					<button class="btns wid md-ripples ripples-light" type="submit"
						onclick="">로그인</button>
				</form>
<a href="https://kauth.kakao.com/oauth/authorize?client_id=29a88f9c94b409047dcee5163c7e4d8c&redirect_uri=http://localhost:8282/user/login/oauth2/code/kakao&response_type=code&prompt=login">
  <img src="${pageContext.request.contextPath}/resources/img/kakao_login_large_wide.png" alt="카카오 로그인">
</a>
			</div>
		</div>
	</div>
	<%@ include file="../includes/subfooter.jsp"%>

	<c:if test="${not empty loginMessage}">
		<script>
			alert('${loginMessage}');
		</script>
	</c:if>



</body>
</html>
