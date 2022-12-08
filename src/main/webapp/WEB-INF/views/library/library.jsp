<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>자료실</title>
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
.boardList th,
.boardList td {
    padding: 0px;
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
.section-wrapper {
    min-height: 850px;
}
</style>
</head>

<body>
<%@include file="../include/header.jspf" %>
<section class="white section-wrapper">
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <%@include file="../include/sidebar.jspf" %>
                <div class="col-md-9">
                    <div class="post-heading mb">
                        <h3>자료실</h3>
                    </div>
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                       <div class="well">
                                             <table class="boardList">
                                                 <tr>
                                                     <th style="width: 65%;">제목</th>
                                                     <th style="width: 15%;">작성자</th>
                                                     <th style="width: 10%;">작성일자</th>
                                                     <th style="width: 10%;">조회수</th>
                                                 </tr>
                                                 <c:forEach var="notice" items="${fullNoticeList}">
                                                 <tr>
                                                     <td><h4><span>[전체공지]</span>
                                                     <a class="noticeTitle" href="/fullNotice/readPost?postNum=${notice.postNum}">
                                                      ${notice.title}</a>
                                                     <c:if test="${notice.commentCount > 0}">( ${notice.commentCount} )</c:if></h4></td>
                                                     <td>${notice.writer}</td>
                                                     <td><fmt:formatDate pattern="yyyy.MM.dd" value="${notice.regDate}"/></td>
                                                     <td>${notice.views}</td>
                                                 </tr>
                                                 </c:forEach>
                                                 <c:forEach var="notice" items="${selfNoticeList}">
                                                 <tr>
                                                     <td><h4><span>[공지사항]</span>
                                                     <a class="noticeTitle" href="javascript:checkMemberLevelBeforeRead(${notice.postNum});">
                                                      ${notice.title}</a>
                                                     <c:if test="${notice.commentCount > 0}">( ${notice.commentCount} )</c:if></h4></td>
                                                     <td>${notice.writer}</td>
                                                     <td><fmt:formatDate pattern="yyyy.MM.dd" value="${notice.regDate}"/></td>
                                                     <td>${notice.views}</td>
                                                 </tr>
                                                 </c:forEach>
                                                 <c:forEach var="post" items="${postList}">
                                                 <tr>
                                                     <td><h4><a class="postTitle" href="javascript:checkMemberLevelBeforeRead(${post.postNum});">${post.title}</a>
                                                     <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                                                     <td>${post.writer}</td>
                                                     <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                                                     <td>${post.views}</td>
                                                 </tr>
                                                 </c:forEach>
                                             </table>
                                             <c:if test="${empty postList}">
                                              <h3>검색 결과가 없습니다</h3>
                                             </c:if>
                                             <c:if test="${empty postList}"><tr><td>관련 글이 없습니다...</td></tr></c:if>
                                       </div>
                                </div>
                                <div class="post-navigation">
                                    <c:if test="${page.prevPageSetPoint >= 1}">
                                        <a class="pull-left btn btn-theme"
                                        href="/library/list?recentPage=${page.prevPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        이전</a>
                                    </c:if>
                                    <c:forEach var="countPage" begin="${page.pageBeginPoint}" end="${page.pageEndPoint}">
                                        <a class="pull-center btn btn-theme"
                                        href="/library/list?recentPage=${countPage}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        ${countPage}</a>
                                    </c:forEach>
                                    <c:if test="${page.nextPageSetPoint <= page.totalPage}">
                                        <a class="pull-right btn btn-theme"
                                        href="/library/list?recentPage=${page.nextPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
                                        다음</a>
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <form action="/library/list">
                                        <select name="searchType">
                                            <option value="titleAndContent" <c:if test="${page.searchType == 'titleAndContent'}">selected</c:if> >제목+내용</option>
                                            <option value="title" <c:if test="${page.searchType == 'title'}">selected</c:if> >제목</option>
                                            <option value="content" <c:if test="${page.searchType == 'content'}">selected</c:if> >내용</option>
                                        </select>
                                        <input name="keyword" value=${page.keyword}>
                                        <button class="pull btn btn-theme">검색</button>
                                        <c:if test="${page.keyword != ''}">
                                            <button type="button" class="pull btn btn-theme" onclick="location.href='/library/list'">취소</button>
                                        </c:if>
                                    </form>
                                </div>
                                <c:if test="${member.grade == 3}">
                                    <a href="/library/writePost" class="pull-right btn btn-theme">글쓰기</a>
                                </c:if>
                            </div><!--/#comments-list-->
                        </div><!--/#comments-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="../include/footer.jspf" %>
<script>
    function checkMemberLevelBeforeRead(postNum) {
        if(${member == null || member.grade < 2}) {
            alert("해당 글 열람은 관리자 승인이 필요합니다.");
            return false;
        }
        location.href = "/library/readPost?postNum=" + postNum;
    }
</script>
</body>
</html>
