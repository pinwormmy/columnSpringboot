<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${post.title} - 동영상 게시판</title>

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
.boardList tr:nth-child(odd) {
    background-color: #ddd;
}
.boardList th,
.boardList td {
    padding: 12px;
    text-align: center;
}
.boardList tr th {
    background-color: #CCFF33;
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
.post-title {
    padding: 0.5rem 0.75rem;
    font-size: 20px;
    font-weight: 300;
    border-bottom: 1px solid;
    border-color: #bbb;
    background-color: #eee;
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
    padding: 0.5rem 0.75rem;
    font-size: 20px;
    font-weight: 300;
    border-top: 1px solid;
    border-bottom: 1px solid;
    border-color: #bbb;
    background-color: #eee;
}
.btn-theme {
    margin: 10px;
    float: right;
}
.col-xs-12 p {
    color: black;
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
                    <div class="title-row">
                        <div class="post-title">${post.title}</div>
                    </div>
                    <div class="info-row">
                        <span class="writer-info">작성자: ${post.writer}</span>
                        <span class="post-info">작성일 ${post.regDate}</span>
                        <span style="float: right; margin-right: 10px;">조회수 ${post.views}</span>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb100">
                            ${post.url}
                        </div>
                        <div class="col-xs-12 mb wow fadeInUp">
                            ${post.content}
                        </div>
                        <div id="comments" class="col-xs-12">
                            <c:if test="${post.commentCount > 0 || member.grade > 1}">
                                <div class="mb">
                                    <h3 class="single-section-title">Comments</h3>
                                </div>
                            </c:if>
                            <div id="comments-list" class="gap">
                            </div><!--/#comments-list-->
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
                                    </div>
                                    <button type="button" class="btn btn-theme" style="margin-left: 15px;" onclick="addComment();">댓글 달기</button>
                                </div><!--/#comment-form-->
                            </c:if>
                        </div><!--/#comments-->
                        <div class="post-navigation">
                            <a class="pull-left btn btn-theme" href="/video/list">글 목록</a>
                            <c:if test="${member.id == post.writer || member.grade == 3}">
                                <a class="pull-right btn btn-theme" href="/video/modifyPost?postNum=${post.postNum}">글 수정</a>
                                <a class="pull-right btn btn-theme" href="/video/deletePost?postNum=${post.postNum}">글 삭제</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

//alert("js test 15");
let commentContent = document.getElementById("commentContent");
showCommentList(${post.postNum});

function addComment(){
    if(commentContent.value == "") {
        alert("댓글 내용을 작성해주세요~", commentContent.value);
        return false;
    }
    fetch("/video/addComment", {
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
        showCommentList(${post.postNum});
    });
    commentContent.value = "";
}

function showCommentList(postNum){
    fetch("/video/showCommentList?postNum=" + postNum)
    .then((response) => response.json())
    .then((data) => showCommentWithHtml(data));
}

function showCommentWithHtml(CommentDTOList) {
    let commentDivTag = document.getElementById("comments-list");
    commentDivTag.innerHTML = "";
    let commentListHtml = "";
    commentDivTag.innerHTML += commentHtmlWithString(commentListHtml, CommentDTOList);
}

function commentHtmlWithString(commentListHtml, CommentDTOList) {
    for(let comment of CommentDTOList) {
        commentListHtml += "<div class='media'><div class='media-body'><div class='well'><div class='media-heading'>";
        commentListHtml += "<strong>" + comment.memberDTO.nickName + "</strong> &nbsp; <small>";
        commentListHtml += comment.regDate + "</small></div><p>" + comment.content;
        commentListHtml = displayDeleteButton(commentListHtml, comment) + "</p></div></div></div>";
    }
    return commentListHtml;
}

function displayDeleteButton(commentListHtml, commentDTO) {
    if( ("${member.id}" == commentDTO.id) || ("${member.grade}" == 3) ) {
        commentListHtml += "<button class='pull-right btn btn-theme' onclick='deleteComment(";
        commentListHtml += commentDTO.commentNum + ");'>삭제</button>";
    }
    return commentListHtml;
}

function deleteComment(commentNum) {
    fetch("/video/deleteComment?commentNum=" + commentNum, {method:"DELETE"})
    .then(data => {
        updateCommentCount(${post.postNum});
        showCommentList(${post.postNum});
    })
    .catch(error => alert("댓글 삭제 오류"));
}

function updateCommentCount(postNum) {
    fetch("/video/updateCommentCount?postNum=" + postNum, {method:"PUT"})
        .then(data => console.log("댓글 업데이트"))
        .catch(error => alert("댓글수 갱신 오류"));
}

</script>

<%@include file="../include/footer.jspf" %>
</body>
</html>