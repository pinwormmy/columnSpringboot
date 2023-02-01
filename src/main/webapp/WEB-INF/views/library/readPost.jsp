<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${post.title} - 자료실</title>
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
    margin: 10px 0;
    float: right;
}
.col-xs-12 p {
    color: black;
    padding: 15px;
}
.col-md-9 {
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
                    <div class="info-row">
                        <span>첨부파일</span>
                        <c:if test="${empty fileList}">: 첨부파일이 없습니다.</c:if>
                        <c:forEach var="file" items="${fileList }">
                            <br>
                            <a class="downlink" id="${file.fileNum}" href="${file.originalFileName }">${file.originalFileName }</a>
                        </c:forEach>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 mb wow fadeInUp">
                            ${post.content}
                        </div>
                        <div id="comments" class="col-xs-12">
                            <c:if test="${post.commentCount > 0 || member.grade > 1}">
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
                                    <button type="button" class="btn btn-theme" style="margin-left: 15px;" onclick="addComment();">댓글 달기</button>
                                </div><!--/#comment-form-->
                            </c:if>
                        </div><!--/#comments-->
                        <div class="post-navigation col-xs-12"">
                            <a class="pull-left basic-button-white" href="/library/list">글 목록</a>
                            <c:if test="${member.id == post.writer || member.grade == 3}">
                                <a class="pull-right basic-button-white" href="/library/modifyPost?postNum=${post.postNum}">글 수정</a>
                                <a class="pull-right basic-button-white" href="/library/deletePost?postNum=${post.postNum}">글 삭제</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../include/footer.jspf" %>

<script>

//alert("js test 21");
let commentContent = document.getElementById("commentContent");
showCommentList();

function addComment() {
    if(commentContent.value == "") {
        alert("댓글 내용을 작성해주세요~", commentContent.value);
        return false;
    }
    fetch("/library/addComment", {
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
    fetch("/library/commentPageSetting", {
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
    fetch("/library/showCommentList", {
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
    fetch("/library/deleteComment?commentNum=" + commentNum, {method:"DELETE"})
    .then(data => {
        updateCommentCount(${post.postNum});
        showCommentList();
    })
    .catch(error => alert("댓글 삭제 오류"));
}

function updateCommentCount(postNum) {
    fetch("/library/updateCommentCount?postNum=" + postNum, {method:"PUT"})
        .then(data => console.log("댓글 업데이트"))
        .catch(error => alert("댓글수 갱신 오류"));
}

$(document).ready(function() {
    $(".downlink").click(function(e){
        e.preventDefault();
        // alert("a태그 href방지 확인");
        var fileName = $(this).attr("href");
        window.location = "fileDownload?fileName=" + fileName;
    });
});

</script>

</body>
</html>