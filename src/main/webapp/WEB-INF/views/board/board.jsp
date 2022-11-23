<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>S L C</title>
<style>
.page-navigation {
    text-align: center;
}
.checkbox-list {
    padding: 10px;
}
.checkbox-list label {
    font-weight: 400;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jspf" %>
<div class="body-wrap">
<section class="products section">
	<div class="container">
		<div class="row">
			<%@ include file="/WEB-INF/views/include/sidebar.jspf" %>
			<div class="col-md-9">
			    <hr><br>
				<div class="row">
				    <table class="boardList">
                        <tr>
                            <th>제목</th>
                            <th>작성일자</th>
                            <th>조회수</th>
                        </tr>
                        <c:if test="${empty postList}">
                            <h3>검색 결과가 없습니다</h3>
                        </c:if>
                        <c:forEach var="notice" items="${fullNoticeList}">
                        <tr>
                            <td><h4><div align="left">[전체공지]</div>
                            <a class="noticeTitle" href="/fullNotice/readPost?postNum=${notice.postNum}">
                             ${notice.title}</a>
                            <c:if test="${notice.commentCount > 0}">( ${notice.commentCount} )</c:if></h4></td>
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${notice.regDate}"/></td>
                            <td>${notice.views}</td>
                        </tr>
                        </c:forEach>
                        <c:forEach var="notice" items="${selfNoticeList}">
                        <tr>
                            <td><h4><div align="left">[공지사항]</div>
                            <a class="noticeTitle" href="javascript:checkMemberLevelBeforeRead(${notice.postNum});">
                             ${notice.title}</a>
                            <c:if test="${notice.commentCount > 0}">( ${notice.commentCount} )</c:if></h4></td>
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${notice.regDate}"/></td>
                            <td>${notice.views}</td>
                        </tr>
                        </c:forEach>
                        <c:forEach var="post" items="${postList}">
                        <tr>
                            <td><h4><a class="postTitle" href="javascript:checkMemberLevelBeforeRead(${post.postNum});">${post.title}</a>
                            <c:if test="${post.commentCount > 0}">( ${post.commentCount} )</c:if></h4></td>
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/></td>
                            <td>${post.views}</td>
                        </tr>
                        </c:forEach>
                 </table>
                </div>
			</div>
		</div>
	</div>
</section>
</div>

<hr>

<div class="post-navigation">
    <c:if test="${page.prevPageSetPoint >= 1}">
        <a class="pull-left btn btn-theme"
        href="/board/list?recentPage=${page.prevPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
        이전</a>
    </c:if>
    <c:forEach var="countPage" begin="${page.pageBeginPoint}" end="${page.pageEndPoint}">
        <a class="pull-center btn btn-theme"
        href="/board/list?recentPage=${countPage}&searchType=${page.searchType}&keyword=${page.keyword}">
        ${countPage}</a>
    </c:forEach>
    <c:if test="${page.nextPageSetPoint <= page.totalPage}">
        <a class="pull-right btn btn-theme"
        href="/board/list?recentPage=${page.nextPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">
        다음</a>
    </c:if>
</div>
<div class="form-group">
    <form action="/board/list">
        <select name="searchType">
            <option value="titleAndContent" <c:if test="${page.searchType == 'titleAndContent'}">selected</c:if> >제목+내용</option>
            <option value="title" <c:if test="${page.searchType == 'title'}">selected</c:if> >제목</option>
            <option value="content" <c:if test="${page.searchType == 'content'}">selected</c:if> >내용</option>
        </select>
        <input name="keyword" value=${page.keyword}>
        <button class="pull btn btn-theme">검색</button>
        <c:if test="${page.keyword != ''}">
            <button type="button" class="pull btn btn-theme" onclick="location.href='/board/list'">취소</button>
        </c:if>
    </form>
</div>
<c:if test="${member.grade == 3}">
    <a href="/board/writePost" class="pull-right btn btn-theme">글쓰기</a>
</c:if>
<%@include file="../include/footer.jspf" %>

<script>
    function checkMemberLevelBeforeRead(postNum) {
        if(${member == null || member.grade < 2}) {
            alert("해당 글 열람은 관리자 승인이 필요합니다.");
            return false;
        }
        location.href = "/board/readPost?postNum=" + postNum;
    }
</script>

</body>
</html>
