<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 게시물읽기~~@@</title>

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

<header id="headerwrap" class="quarterscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>${post.title}</h1>
                        <span class="white meta">Posted by <a href="#">${post.writer} </a>on 2022.07.30</span>
                        <span style="float: right; color: white;">조회수 ${post.views}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<section class="white section-wrapper">
    <%@include file="../include/boardSidebar.jspf" %>
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="row">
                        <div class="col-xs-12 mb wow fadeInUp">
                            ${post.content}
                        </div>
                        <div id="comments" class="col-xs-12">
                            <c:if test="${post.commentCount > 0 || member.memberLevel > 1}">
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
                                    </div>
                                    <button type="button" class="btn btn-theme" onclick="addComment();">댓글 달기</button>
                                </div><!--/#comment-form-->
                            </c:if>
                            <div class="post-navigation">
                                <a class="pull-left btn btn-theme" href="/board/list">글 목록</a>
                                <c:if test="${member.id == post.writer || member.memberLevel == 3}">
                                    <a class="pull-right btn btn-theme" href="/board/modifyPost?postNum=${post.postNum}">글 수정</a>
                                    <a class="pull-right btn btn-theme" href="/board/deletePost?postNum=${post.postNum}">글 삭제</a>
                                </c:if>
                            </div>
                        </div><!--/#comments-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

alert("js test 21");
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
        document.getElementById("comments").scrollIntoView(true);
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
        commentListHtml += "<div class='media'><div class='media-body'><div class='well'><div class='media-heading'>";
        commentListHtml += "<strong>" + comment.memberDTO.nickName + "</strong> &nbsp; <small>";
        commentListHtml += comment.regDate + "</small></div><p>" + comment.content + "</p>";
        commentListHtml = displayDeleteButton(commentListHtml, comment) + "</div></div></div>";
    }
    return commentListHtml;
}

function displayDeleteButton(commentListHtml, commentDTO) {
    if( ("${member.id}" == commentDTO.id) || ("${member.memberLevel}" == 3) ) {
        commentListHtml += "<button class='pull-right btn btn-theme' onclick='deleteComment(";
        commentListHtml += commentDTO.commentNum + ");'>삭제</button>";
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