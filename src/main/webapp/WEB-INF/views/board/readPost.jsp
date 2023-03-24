<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${post.title} - 승인연재게시판</title>

<style>
.postTitle {
    color: black;
}
.post-title {
    padding: 0.5rem 0.75rem;
    font-size: 20px;
    font-weight: 400;
    border-top: 1px solid;
    border-bottom: 1px solid;
    border-color: #bbb;
    background-color: #E8F8F5;
}
.info-row {
    padding: 0.35rem 0.75rem 0.3rem;
    border-bottom: 1px solid;
    border-color: #bbb;
    font-size: 18px;
    font-weight: 300;
    overflow: hidden;
}
.post-info {
    display: inline-block;
    float: right;
}
.single-section-title {
    padding: 5px 5px;
    font-size: 20px;
    font-weight: 300;
    border-top: 1px solid;
    border-bottom: 1px solid;
    border-color: #bbb;
    background-color: #E8F8F5;
}
.col-xs-12 p {
    color: black;
    padding: 15px;
}
.col-lg-7 {
    padding: 15px;
}
.basic-button {
    color: white;
    background-color: Turquoise;
    font-size: 14px;
    padding: 6px 12px;
    border: none;
    border-radius: 10px;
    font-weight: 300;
    margin: 5px;
}
.basic-button-white {
    color: Turquoise;
    background-color: white;
    border: 1px solid Turquoise;
    font-size: 14px;
    padding: 6px 12px;
    border-radius: 10px;
    font-weight: 300;
    margin: 5px;
}
.views-log-table {
  margin-top: 10px;
  font-size: 14px;
  width: 100%;
  border-collapse: collapse;
}

.views-log-table thead th {
  background-color: #E8F8F5;
  font-weight: bold;
  text-align: center;
  padding: 10px;
  border: 1px solid #bbb;
}

.views-log-table tbody td {
  text-align: center;
  padding: 10px;
  border: 1px solid #bbb;
}
</style>
</head>
<body>
<%@include file="../include/header.jspf" %>
<section class="white section-wrapper">
    <div class="section-inner">
        <div class="container" style="width: 1600px;">
            <div class="row">
                <%@include file="../include/sidebar.jspf" %>
                <div class="col-lg-7">
                    <div class="title-row">
                        <div class="post-title">${post.title}</div>
                    </div>
                    <div class="info-row">
                        <span class="writer-info">작성자: ${post.writer}</span>
                        <span class="post-info">작성일 ${post.regDate}</span>
                        <span style="float: right; margin-right: 10px;">조회수 ${post.views}</span>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 mb wow fadeInUp">
                            ${post.content}
                        </div>
                        <div id="comments" class="col-xs-12">
                            <c:if test="${post.commentCount > 0 && member.grade > 1}">
                                <div class="mb">
                                    <h3 class="single-section-title">Comments</h3>
                                </div>
                            </c:if>
                            <div id="comments-list" class="gap"></div>
                            <div id="comments-page" class="gap"></div>
                            <c:if test="${member != null}">
                                <div id="comment-form" class="gap">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            작성자 : ${member.nickName}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <textarea rows="3" class="form-control" name="commentContent" id="commentContent" placeholder="댓글을 작성합니다"></textarea>
                                        </div>
                                        <div class="col-sm-12">
                                            <button type="button" class="pull-right basic-button" style="margin-left: 15px;" onclick="addComment();">🔖댓글 달기</button>
                                        </div>
                                    </div>
                                </div><!--/#comment-form-->
                            </c:if>
                        </div><!--/#comments-->
                        <div class="post-navigation col-xs-12">
                            <a class="pull-left basic-button-white" href="/board/list">📝글 목록</a>
                            <c:if test="${member.id == post.writer || member.grade == 3}">
                                <a class="pull-right basic-button-white" href="/board/deletePost?postNum=${post.postNum}">🗑️글 삭제</a>
                                <a class="pull-right basic-button-white" href="/board/modifyPost?postNum=${post.postNum}">✏️글 수정</a>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="side-banner">
                        <c:if test="${member.grade != 3}">
                            <img src="/img/right_banner_ex1.jpg" width="100%">
                        </c:if>
                        <c:if test="${member.grade == 3}">
                            <table class="views-log-table">
                              <thead>
                                <tr>
                                  <th style="width: 33%;">아이디</th>
                                  <th style="width: 33%;">IP 주소</th>
                                  <th style="width: 33%;">조회 시간</th>
                                </tr>
                              </thead>
                              <tbody>
                                <h4>관리자 기능 - 게시글 접속내역 확인</h4>
                                <c:forEach var="viewDetail" items="${viewsDetails}">
                                  <tr>
                                    <td>${viewDetail.realName}</td>
                                    <td>${viewDetail.ip}</td>
                                    <td><fmt:formatDate value="${viewDetail.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                  </tr>
                                </c:forEach>
                              </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

//alert("js test 21");
let commentContent = document.getElementById("commentContent");
showCommentList();

function addComment() {
    if(commentContent.value == "") {
        alert("댓글 내용을 작성해주세요~", commentContent.value);
        return false;
    }
    fetch("/board/addComment", {
        method: 'POST',
        headers: {"Content-Type" : "application/json"},
        body: JSON.stringify({
            postNum : ${post.postNum},
            id : "${member.id}",
            content : commentContent.value,
        })
    })
    .then((data) => {
        console.log(data);
        updateCommentCount(${post.postNum});
        showCommentList();
    });
    commentContent.value = "";
}

function showCommentList(commentPage) {
    pageSettingAndLoadComment(commentPage);
}

function pageSettingAndLoadComment(commentPage) {
    fetch("/board/commentPageSetting", {
            method: 'POST',
            headers: {"Content-Type" : "application/json"},
            body: JSON.stringify({
                recentPage : commentPage,
                postNum : ${post.postNum}
            })
        })
    .then((response) => response.json())
    .then((data) => {
        console.log(data);
        loadCommentFetch(data);
        let commentPageDivTag = document.getElementById("comments-page");
        commentPageDivTag.innerHTML = "";
        let commentPageHtml = "";

        if(data.prevPageSetPoint >= 1) {
            commentPageHtml +="<a href='javascript:pageSettingAndLoadComment(" + data.prevPageSetPoint + ")'>◁</a>";
        }
        if(data.totalPage > 1) {
            for(let i=data.pageBeginPoint; i<=data.pageEndPoint; i++) {
                if(i == data.recentPage) {
                    commentPageHtml += " " + i + " ";
                }else {
                    commentPageHtml += "<a href='javascript:pageSettingAndLoadComment(" + i + ")'>" + i + " </a>";
                }
            }
        }
        if(data.nextPageSetPoint <= data.totalPage) {
            commentPageHtml +="<a href='javascript:pageSettingAndLoadComment(" + data.nextPageSetPoint + ")'>▷</a>";
        }
        commentPageDivTag.innerHTML += commentPageHtml;
    });
}

function loadCommentFetch(pageDTO) {
    console.log("댓글불러오기 펫치 시작전");
    fetch("/board/showCommentList", {
        method: "POST",
        headers: {"Content-Type" : "application/json"},
        body: JSON.stringify(pageDTO),
    })
    .then((response) => response.json())
    .then((data) => showCommentWithHtml(data));
}

function showCommentWithHtml(CommentDTOList) {
    let commentDivTag = document.getElementById("comments-list");
    commentDivTag.innerHTML = "";
    let commentListHtml = "";
    commentDivTag.innerHTML += commentHtmlWithString(commentListHtml, CommentDTOList);
    console.log("댓글 코맨트 소스 작업  반영 확인");
}

function commentHtmlWithString(commentListHtml, CommentDTOList) {
    console.log("댓글 코맨트 소스 반복문 준비 확인");
    for(let comment of CommentDTOList) {
        commentListHtml += "<div class='media'><div class='media-body'><div class='well' style='margin: 0; padding: 10px;'><div class='media-heading'>";
        commentListHtml += "<strong>" + comment.memberDTO.nickName + "</strong> &nbsp; <small>";
        commentListHtml = displayDeleteButton(commentListHtml, comment);
        commentListHtml += comment.regDate + "</small></div><p style='margin: 0; padding: 0;'>" + comment.content + "</p></div></div></div>";
    }
    return commentListHtml;
}

function displayDeleteButton(commentListHtml, commentDTO) {
    if( ("${member.id}" == commentDTO.id) || ("${member.grade}" == 3) ) {
        commentListHtml += "<button class='pull-right basic-button-white' onclick='deleteComment(";
        commentListHtml += commentDTO.commentNum + ");'>🗑️삭제</button>";
    }
    return commentListHtml;
}

function deleteComment(commentNum) {
    fetch("/board/deleteComment?commentNum=" + commentNum, {method:"DELETE"})
    .then(data => {
        updateCommentCount(${post.postNum});
        showCommentList();
    })
    .catch(error => alert("댓글 삭제 오류"));
}

function updateCommentCount(postNum) {
    fetch("/board/updateCommentCount?postNum=" + postNum, {method:"PUT"})
        .then(data => console.log("댓글 업데이트"))
        .catch(error => alert("댓글수 갱신 오류"));
}

</script>

<%@include file="../include/footer.jspf" %>
</body>
</html>