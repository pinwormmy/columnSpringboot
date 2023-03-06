<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>글 수정하기~~@@</title>
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
</style>
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
</head>
<body>
<%@include file="../include/header.jspf" %>

<header id="headerwrap" class="quarterscreen">
		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">

	                </div>
	            </div>
	        </div>
		</div>
	</header>

	<section class="white section-wrapper">

		<div class="section-inner">
			<div class="container">
				<div class="row">
				    <%@include file="../include/sidebar.jspf" %>
					<div class="col-md-9">
						<div class="row">
						    <div class="post-heading mb">
                                <h1>글 수정하기</h1>
                            </div>
							<div class="col-xs-12 mb wow fadeInUp">
                                <form action="/fullNotice/submitModifyPost" method="post">
                                    <input type="hidden" name="writer" value="${post.writer}">
                                    <input type="hidden" name="postNum" value="${post.postNum}">
                                    제목 <input type="text" name="title" size="55" value="${post.title}" required>
                                    <textarea name="content" id="content">${post.content}</textarea><br>

                                    <script type="text/javascript">
                                        CKEDITOR.replace('content', {filebrowserUploadUrl:'/imageUpload'});
                                    </script>

                                    <button class="pull-left btn btn-theme">수정하기</button>
                                    <button type="button" class="pull-left btn btn-theme" onclick="location.href='/fullNotice/readFullNotice?postNum=${post.postNum}'">취소</button>
                                </form>

							</div>

                            <div class="post-navigation">
                                <a class="pull-left btn btn-theme" href="#">Older Posts</a>
                                <a class="pull-right btn btn-theme" href="#">Newer Posts</a>
                            </div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@include file="../include/footer.jspf" %>

</body>
</html>