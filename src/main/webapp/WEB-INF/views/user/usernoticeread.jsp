<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/csss/memberlogin.css" rel="stylesheet" />
<link href="${path}/resources/csss/subindex.css" rel="stylesheet" />
<link href="${path}/resources/csss/usernoticeread.css" rel="stylesheet" />
</head>
<body>
	<%@ include file="../includes/header.jsp"%>
	<div id="noticeRead">
		<div class="sub-conts customer-list">
			<div class="page-tit">
				<h1>공지사항</h1>
			</div>

			<div class="box-board">
				<div class="list-wrap-1 type-ul">
					<dl class="list-view">
						<dt class="date-right">
							<strong class="view-tit">${notice.title}</strong>
							<td><fmt:formatDate value="${notice.regdate}"
									pattern="yyyy-MM-dd" /></td>
						</dt>
						<dd>
							<div class="view-txt">${notice.content}</div>
						</dd>
					</dl>
				</div>
				<div class="box-paging">
					<button class="btns-e line" type="button"
						onclick="location.href='/user/notice'">목록</button>
				</div>
			</div>
		</div>
	</div>

	<%-- <%@ include file="../includes/subfooter.jsp"%> --%>
</body>
</html>