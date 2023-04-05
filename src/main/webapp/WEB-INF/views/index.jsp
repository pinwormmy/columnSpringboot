<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>컬럼형 사이트</title>
<style>
body {
    height: 100%;
}
.boardList {
    width: 100%;
    background-color: #fff;
    border-collapse: collapse;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
    border-radius: 5px;
    overflow: hidden;
    margin: 10px 0 10px 0;
}
.boardList caption {
    font-size: 12px;
    margin-bottom: 30px;
}
.boardList tr {
    border-bottom: 1px solid #eee;
}
.boardList tr:last-child {
    border: none;
}
.boardList th,
.boardList td {
    padding: 5px;
    text-align: center;
}
.boardList tr th {
    background-color: #EDFFFF;
    color: black;
}
.boardList tr th:first-child {
    border-radius: 5px 0 0 0;
}
.boardList tr th:last-child {
    border-radius: 0 5px 0 0;
}
.postTitle {
    color: black;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 15%;
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
    font-size: 12px;
    font-weight: 500px;
}
.page-navigation {
    text-align: center;
}
.checkbox-list {
    padding: 10px;
}
.checkbox-list label {
    font-weight: 400;
}
span {
    font-size: 16px;
    font-weight: 300;
    border-bottom: 2px solid Turquoise;
}
.main-banner {
    margin: 10px;
    text-align: center;
}
.sidebar-menu {
  margin-top: 20px;
}

.leftbar-ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.leftbar-ul li {
  border-bottom: 1px solid #ccc;
  padding: 10px 0;
}

.leftbar-ul li:last-child {
  border-bottom: none;
}

.leftbar-ul li a {
  color: #333;
  display: flex;
  align-items: center;
  text-decoration: none;
  padding: 5px 10px;
}

.leftbar-ul li a i {
  font-size: 12px;
  margin-right: 10px;
}

.leftbar-ul li a:hover {
  background-color: #eee;
}

</style>
</head>
<body>
<%@include file="./include/header.jspf" %>
    <div class="section-inner">
        <div class="container" style="width: 1600px;">
            <div class="main-banner">
                <img src="/img/main_banner.jpg">
            </div>
            <div class="row">
                <%@include file="./include/sidebar.jspf" %>
                <div class="col-lg-4">
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                    <span><a href="/openColumn/list">자유게시판</a></span>
                                     <table class="boardList">
                                            <c:forEach var="post" items="${opencolumnList}">
                                            <tr>
                                                <td>
                                                <a class="postTitle" href="/openColumn/readPost?postNum=${post.postNum}">${post.title}</a>
                                                <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                            </tr>
                                            </c:forEach>
                                     </table>
                                     <c:if test="${empty opencolumnList}"><tr><td>현재 등록된 글이 없습니다.</td></tr></c:if>
                                </div>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>

                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                    <span><a href="/video/list">동영상 게시판</a></span>
                                     <table class="boardList">
                                            <c:forEach var="post" items="${videoList}">
                                            <tr>
                                                <td>
                                                <a class="postTitle" href="/video/readPost?postNum=${post.postNum}">${post.title}</a>
                                                <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></td>
                                                <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                            </tr>
                                            </c:forEach>
                                     </table>
                                     <c:if test="${empty videoList}"><tr><td>현재 등록된 글이 없습니다.</td></tr></c:if>
                                </div>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                    <span><a href="/board/list">회원게시판</a></span>
                                     <table class="boardList">
                                            <c:forEach var="post" items="${boardList}">
                                            <tr>
                                                <td>
                                                <a class="postTitle" href="/board/readPost?postNum=${post.postNum}">${post.title}</a>
                                                <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                            </tr>
                                            </c:forEach>
                                     </table>
                                     <c:if test="${empty boardList}"><tr><td>현재 등록된 글이 없습니다.</td></tr></c:if>
                                </div>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                    <span><a href="/library/list">자료실</a></span>
                                     <table class="boardList">
                                            <c:forEach var="post" items="${libraryList}">
                                                <tr>
                                                    <td>
                                                    <a class="postTitle" href="/library/readPost?postNum=${post.postNum}">${post.title}</a>
                                                    <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                    <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                                </tr>
                                            </c:forEach>
                                     </table>
                                     <c:if test="${empty libraryList}"><tr><td>현재 등록된 글이 없습니다.</td></tr></c:if>
                                </div>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                </div>

                <div class="col-lg-2">
                    <div class="side-banner">
                        <img src="/img/left_banner_ex1.jpg" width="100%">
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<%@include file="./include/footer.jspf" %>
</body>
</html>



