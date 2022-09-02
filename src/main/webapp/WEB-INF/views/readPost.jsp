<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 게시물읽기~~@@</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
</head>
<body>
<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
	                    <div class="post-heading mb">
	                        <h1>${post.title}</h1>
	                        <span class="white meta">Posted by <a href="#">${post.writer} </a>on 2022.07.30</span>
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
							<div id="author-box" class="col-xs-12 mb100 wow fadeInUp">
								<div class="row">
									<div class="col-xs-3">
										<img class="img-responsive comment-avatar" src="/img/team/team1.jpg" alt="title">
									</div>
									<div class="col-xs-9">
										<h4>About <strong>The Author</strong></h4>
										<p>Am if number no up period regard sudden better. Decisively surrounded all admiration and not you. Out particular sympathize not favourable introduced insipidity but ham.</p>
									</div>
								</div>
							</div>

		                    <div id="comments" class="col-xs-12">
		                        <div class="mb">
                                    <h3 class="single-section-title">Comments</h3>
                                </div>
		                        <div id="comments-list" class="gap">
		                        </div><!--/#comments-list-->

                                <c:if test="${member != null}">
		                        <div id="comment-form" class="gap">
		                            <h3  class="main-title">댓글을 남겨주세요</h3>
		                            <hr>
		                                <div class="form-group">
		                                    <div class="col-sm-6">
		                                        작성자 : ${member.nickName}
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <div class="col-sm-12">
		                                        <textarea rows="8" class="form-control" name="commentContent" id="commentContent" placeholder="댓글내용"></textarea>
		                                    </div>
		                                </div>
		                                <button type="button" class="btn btn-theme" onclick="addComment();">댓글 달기</button>
		                        </div><!--/#comment-form-->
		                        </c:if>

		                        <div class="post-navigation">
		                            <a class="pull-left btn btn-theme" href="/board">글 목록</a>
		                            <a class="pull-right btn btn-theme" href="/modifyPost?postNum=${post.postNum}">글 수정</a>
		                            <a class="pull-right btn btn-theme" href="/deletePost?postNum=${post.postNum}">글 삭제</a>
		                            <!-- <a class="pull-right btn btn-theme" href="#">Newer Posts</a> -->
		                        </div>
		                    </div><!--/#comments-->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>

alert("js test 09");

let commentContent = document.getElementById("commentContent");

showCommentList(${post.postNum});

function addComment(){
    fetch("/addComment", {
        method: 'POST',
        headers: {
            "Content-Type" : "application/json",
        },
        body: JSON.stringify({
            postNum : ${post.postNum},
            writer : "${member.nickName}",
            content : commentContent.value,
        })
    })
    .then((data) => {
        console.log(data);
        showCommentList(${post.postNum});
    });
    commentContent.value = "";
}

function showCommentList(postNum){

    fetch("/showCommentList?postNum=" + postNum)
    .then((response) => response.json())
    .then((data) => {
        console.log(data);
        document.getElementById("comments-list").innerHTML = "";
        let commentListHtml = "";
        for(let comment of data) {
            console.log(comment.writer, comment.content, comment.regDate);
            commentListHtml += "<div class='media'><div class='media-body'><div class='well'><div class='media-heading'>";
            commentListHtml += "<strong>" + comment.writer + "</strong> &nbsp; <small>";
            commentListHtml += comment.regDate + "</small></div><p>";
            commentListHtml += comment.content + "</p><a class='pull-right btn btn-theme' href='#'>Reply</a>" + "</div></div></div>"
        }
        document.getElementById("comments-list").innerHTML += commentListHtml;
    });
}

</script>

<%@include file="./include/footer.jspf" %>
</body>
</html>