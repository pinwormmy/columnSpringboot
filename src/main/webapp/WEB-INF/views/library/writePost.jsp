<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>자료실 글쓰기</title>
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
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
</head>
<body>
<%@include file="../include/header.jspf" %>
<section class="white section-wrapper">
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <%@ include file="/WEB-INF/views/include/sidebar.jspf" %>
                <div class="col-md-9">
                    <div class="row">
                        <div class="post-heading mb">
                            <h1>자료실 글 작성하기</h1>
                        </div>
                        <form action="/library/submitPost" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="writer" value="${member.id}">
                            제목 <input type="text" name="title" size="60" required>
                            <input type="checkbox" name="notice" value="1">공지로 등록<br>
                            <textarea name="content" id="content"></textarea><br>
                            <div id="addFileForm"></div>
                            <input type="button" value="첨부파일 추가" onClick="addFile();">
                            <input type="button" value="파일첨부 취소" onclick="cancelFile();">
                            <br>
                            <button class="pull-left btn btn-theme">게시하기</button>
                            <button type="button" class="pull-left btn btn-theme" onclick="location.href='/library/list'">취소</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="../include/footer.jspf" %>

<script type="text/javascript">

    CKEDITOR.replace('content', {filebrowserUploadUrl:'/imageUpload'});

    var cnt = 1;
    function addFile(){
        $("#addFileForm").append("<br>" + "<input type='file' name='file" + cnt + "' required />");
        cnt++;
    }
    function cancelFile() {
        $("#addFileForm").empty();
        cnt = 0;
    }

</script>

</body>
</html>