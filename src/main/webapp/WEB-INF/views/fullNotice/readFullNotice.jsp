<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>공개형 컬럼 읽기</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
</head>
<body>
<%@include file="../include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
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
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="row">
                        <div class="col-xs-12 mb wow fadeInUp">
                            ${post.content}
                        </div>
                        <div id="comments" class="col-xs-12">
                            <div class="mb">
                                <h3 class="single-section-title">Comments</h3>
                            </div>
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
                                <button type="button" class="btn btn-theme" onclick="addComment();">댓글 달기</button>
                            </div><!--/#comment-form-->
                            </c:if>
                            <c:if test="${member == null}">
                            <div id="comment-form" class="gap">
                                <h4  class="main-title">로그인하면 댓글을 작성할 수 있습니다.</h3>
                            </div>
                            </c:if>
                            <div class="post-navigation">
                                <a class="pull-left btn btn-theme" href="/fullNotice/list">글 목록</a>
                                <c:if test="${member.id == post.writer || member.memberLevel == 3}">
                                    <a class="pull-right btn btn-theme" href="/fullNotice/modifyPost?postNum=${post.postNum}">글 수정</a>
                                    <a class="pull-right btn btn-theme" href="/fullNotice/deletePost?postNum=${post.postNum}">글 삭제</a>
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

//alert("js test 15");
let commentContent = document.getElementById("commentContent");
showCommentList(${post.postNum});

function addComment(){
    if(commentContent.value == "") {
        alert("댓글 내용을 작성해주세요~", commentContent.value);
        return false;
    }
    fetch("/fullNotice/addComment", {
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
    fetch("/fullNotice/showCommentList?postNum=" + postNum)
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
    fetch("/fullNotice/deleteComment?commentNum=" + commentNum, {method:"DELETE"})
    .then(data => {
        updateCommentCount(${post.postNum});
        showCommentList(${post.postNum});
    })
    .catch(error => alert("댓글 삭제 오류"));
}

function updateCommentCount(postNum) {
    fetch("/fullNotice/updateCommentCount?postNum=" + postNum, {method:"PUT"})
        .then(data => console.log("댓글 업데이트"))
        .catch(error => alert("댓글수 갱신 오류"));
}

</script>

<%@include file="../include/footer.jspf" %>
</body>
</html>