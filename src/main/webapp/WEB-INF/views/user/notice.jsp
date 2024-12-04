<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link href="${path}/resources/csss/index.css" rel="stylesheet" />
    <link href="${path}/resources/csss/mainnotice.css" rel="stylesheet" />
    <style>
        /* 페이징 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination li a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: #007bff;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .pagination li a:hover {
            background-color: #007bff;
            color: #fff;
        }

        .pagination li.active a {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
            pointer-events: none;
        }

        .pagination li.disabled a {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>

    <section class="notice">
        <div class="page-title">
            <div class="container">
                <h3>공지사항</h3>
            </div>
        </div>

        <!-- 검색 폼 -->
        <div id="board-search">
            <div class="container">
                <div class="search-window">
                    <form action="${path}/user/notice/search" method="get">
                        <div class="search-wrap">
                            <label for="search" class="blind">공지사항 내용 검색</label>
                            <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${keyword}">
                            <button type="submit" class="btn btn-dark">검색</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 공지사항 목록 -->
        <div id="board-list">
            <div class="container">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty noticeList}">
                                <c:forEach var="notice" items="${noticeList}">
                                    <tr>
                                        <th scope="row">${notice.nno}</th>
                                        <td>
                                            <a href="${path}/user/notice/${notice.nno}">${notice.title}</a>
                                        </td>
                                        <td>${notice.writer}</td>
                                        <td><fmt:formatDate value="${notice.regdate}"
													pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4">등록된 공지사항이 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 페이징 UI -->
        <div id="pagination">
            <div class="container">
                <ul class="pagination">
                    <!-- 이전 버튼 -->
                    <li class="${currentPage == 1 ? 'disabled' : ''}">
                        <a href="${path}/user/notice/search?keyword=${keyword}&page=${currentPage - 1}">&laquo;</a>
                    </li>

                    <!-- 페이지 번호 -->
                    <c:forEach var="pageNum" begin="1" end="${totalPages}">
                        <li class="${currentPage == pageNum ? 'active' : ''}">
                            <a href="${path}/user/notice/search?keyword=${keyword}&page=${pageNum}">${pageNum}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 버튼 -->
                    <li class="${currentPage == totalPages ? 'disabled' : ''}">
                        <a href="${path}/user/notice/search?keyword=${keyword}&page=${currentPage + 1}">&raquo;</a>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <%@ include file="../includes/subfooter.jsp" %>
</body>
</html>
