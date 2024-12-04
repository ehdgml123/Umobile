<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
<link href="${path}/resources/csss/subindex.css" rel="stylesheet"/> 
<link href="${path}/resources/csss/reviewPage.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="../includes/header.jsp"%>
<div id="login-warp">
    <div class="sub-conts login util-width login-info">
        <div class="page-tit">
            <h1>리뷰</h1>
        </div>
        <div class="rq-form">
            <div class="main-txt-group">
                <h2 class="main-txt">리뷰를 작성해주세요</h2>
            </div>
            <form action="/review/create" method="post">
                <input type="hidden" name="vno" value="${vno}">
                <input type="hidden" name="uno" value="${uno}">
                <div id="divid" class="box-input">
                    <div class="input-wrap">
                        <input id="title" type="text" name="title" placeholder="리뷰 제목을 입력해주세요" class="input-default is-delete" title="리뷰 제목">
                    </div>
                    <div class="input-wrap">
                        <textarea id="content" name="content" placeholder="리뷰를 작성해주세요" class="input-default is-delete" title="리뷰 내용"></textarea>
                    </div>
                </div>
                <button class="btns wid md-ripples ripples-light" type="submit">리뷰 작성 완료</button>
            </form>
        </div>
    </div>
</div>
<%@ include file="../includes/subfooter.jsp"%>       
</body>
</html>
