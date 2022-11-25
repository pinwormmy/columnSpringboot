<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>S L C</title>
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
    padding: 2px;
    text-align: center;
}
.boardList tr th {
    background-color: #CCFF33;
    color: black;
    padding: 10px;
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
<section class="post-section">
	<div class="container">
		<div class="row">
			<%@ include file="/WEB-INF/views/include/sidebar.jspf" %>
			<div class="col-md-9">
			    <div class="post-heading mb">
                    <h1>회원연재게시판</h1>
                </div>
				<div class="row">
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
                    <c:if test="${member.grade == 3}">
                        <a href="/board/writePost" class="pull-right btn btn-theme">글쓰기</a>
                    </c:if>
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

			</div>
		</div>
	</div>
</section>
</div>



<%@ include file="/WEB-INF/views/include/footer.jspf" %>



</body>
<script>
    function checkMemberLevelBeforeRead(postNum) {
        if(${member == null || member.grade < 2}) {
            alert("해당 글 열람은 관리자 승인이 필요합니다.");
            return false;
        }
        location.href = "/board/readPost?postNum=" + postNum;
    }
</script>

</html>
