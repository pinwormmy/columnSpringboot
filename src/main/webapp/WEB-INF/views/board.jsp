<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 페이지~~@@</title>

<style>

.boardList {
    width: 100%;
    background-color: #fff;
    border-collapse: collapse;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
    border-radius: 5px;
    overflow: hidden;
}
.boardList caption {
    font-size: 20px;
    margin-bottom: 30px;
}
.boardList tr {
    border-bottom: 1px solid #eee;
}
.boardList tr:last-child {
    border: none;
}
.boardList tr:nth-child(odd) {
    background-color: #ddd;
}
.boardList th,
.boardList td {
    padding: 12px;
    text-align: center;
}
.boardList tr th {
    background-color: seagreen;
    color: #fff;
}
.boardList tr th:first-child {
    border-radius: 5px 0 0 0;
}
.boardList tr th:last-child {
    border-radius: 0 5px 0 0;
}
.postTitle {
    color: black;
}
@media (min-width: 1150px) {
    .sidebar {
        color: white;
        background: #202020;
        position: absolute;
        left: 0;
        width: 15%;
        min-width: 160px;
        height: 70%;
        padding: 1%;
    }
    .leftbar-ul li {
        margin : 5%;
    }
}

@media (max-width: 1150px) {
    .sidebar {
        color: white;
        background: #202020;;
        position: flex;
        width: 100%;
        height: 5%;
        padding: 1%;
    }
    .leftbar-ul li {
        margin : 1%;
    }
}

.leftbar-ul {
    border-top: solid 1px ivory;
    list-style-type: none;
}
.leftbar-ul li {
    border-bottom: solid 1px ivory;
}
.leftbar-ul li a{
    color : white;
    font-size: 16px;
    font-weight: 500px;
}

</style>
</head>
<body>

<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>게시판</h1>
                        <p class="lead white">수리 모드에서는 사진과 메시지, 계정 등 개인 데이터에 접근할 수 없고 기본으로 설치된 애플리케이션만 이용할 수 있다.
                        스마트폰 설정에서 '배터리 및 디바이스 케어' 메뉴를 선택한 뒤 '수리 모드' 탭을 실행하면 스스로 시스템 재부팅을 하면서 수리 모드가 켜진다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="sidebar">
    <nav>
        <h2>게시판 메뉴</h2>
        <ul class="leftbar-ul">
            <li><a href="/board">공지사항</a></li>
            <li><a href="/board">전용게시판1</a></li>
            <li><a href="/board">전용게시판2</a></li>
            <li><a href="/board">자유게시판</a></li>
        </ul>
    </nav>
</div>

<section class="white section-wrapper">
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                       <div class="well">
                                             <table class="boardList">
                                                    <tr>
                                                        <th>제목</th>
                                                        <th>작성자</th>
                                                        <th>작성일자</th>
                                                    </tr>
                                                    <c:forEach var="post" items="${postList}">
                                                    <tr>
                                                        <td><h4><a class="postTitle" href="/readPost?postNum=${post.postNum}">${post.title}</a>
                                                        <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                        <td>${post.writer}</td>
                                                        <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                                    </tr>
                                                    </c:forEach>
                                             </table>
                                             <c:if test="${empty postList}">관련 글이 없습니다.</c:if>
                                       </div>
                                </div>
                                <div class="post-navigation">
                                    <c:if test="${page.prevPageSetPoint >= 1}">
                                        <a class="pull-left btn btn-theme"
                                        href="/board?recentPage=${page.prevPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        이전</a>
                                    </c:if>
                                    <c:forEach var="countPage" begin="${page.pageBeginPoint}" end="${page.pageEndPoint}">
                                        <a class="pull-center btn btn-theme"
                                        href="/board?recentPage=${countPage}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        ${countPage}</a>
                                    </c:forEach>
                                    <c:if test="${page.nextPageSetPoint <= page.totalPage}">
                                        <a class="pull-right btn btn-theme"
                                        href="/board?recentPage=${page.nextPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        다음</a>
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <form action="/board">
                                        <select name="searchType">
                                            <option value="titleAndContent" <c:if test="${page.searchType == 'titleAndContent'}">selected</c:if> >제목+내용</option>
                                            <option value="title" <c:if test="${page.searchType == 'title'}">selected</c:if> >제목</option>
                                            <option value="content" <c:if test="${page.searchType == 'content'}">selected</c:if> >내용</option>
                                        </select>
                                        <input name="keyword" value=${page.keyword}>
                                        <button class="pull btn btn-theme">검색</button>
                                        <c:if test="${page.keyword != ''}">
                                            <button type="button" class="pull btn btn-theme" onclick="location.href='/board'">취소</button>
                                        </c:if>
                                    </form>
                                </div>
                                <a href="/writePost" class="pull-right btn btn-theme">글쓰기</a>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="./include/footer.jspf" %>
</body>
</html>