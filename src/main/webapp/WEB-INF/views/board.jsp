<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 페이지~~</title>

<style>
.body-wrap {
    min-height: 100%;
    position: relative;
}
.body-content {
    padding-bottom: 100px;
}
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
        bottom: 0;
        width: 15%;
        height: 80%;
        min-width: 160px;
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
<div class="body-wrap">

<%@include file="./include/header.jspf" %>

<div class="body-content">
<header id="headerwrap" class="quarterscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>연재게시판(승인형)</h1>
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
            <li><a href="/board">승인연재게시판</a></li>
            <li><a href="/openColumn/list">공개연재게시판</a></li>
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
                                                        <th>작성일자</th>
                                                        <th>조회수</th>
                                                    </tr>
                                                    <c:forEach var="post" items="${postList}">
                                                    <tr>
                                                        <td><h4><a class="postTitle" href="javascript:checkMemberLevelBeforeRead(${post.postNum});">${post.title}</a>
                                                        <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                        <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                                        <td>${post.views}</td>
                                                    </tr>
                                                    </c:forEach>
                                             </table>
                                             <c:if test="${empty postList}"><tr><td>관련 글이 없습니다...</td></tr></c:if>
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
                                <c:if test="${member.memberLevel == 3}">
                                    <a href="/writePost" class="pull-right btn btn-theme">글쓰기</a>
                                </c:if>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</div>
<%@include file="./include/footer.jspf" %>

</div>

<script>

    function checkMemberLevelBeforeRead(postNum) {
        if(${member == null || member.memberLevel < 2}) {
            alert("해당 글 열람은 관리자 승인이 필요합니다.");
            return false;
        }
        location.href = "/readPost?postNum=" + postNum;
    }

</script>

</body>
</html>