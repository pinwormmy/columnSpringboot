<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>글 수정</title>
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
                <%@include file="../include/sidebar.jspf" %>
                <div class="col-md-9">
                    <div class="row">
                        <div class="post-heading mb">
                            <h1>자료실 글 수정하기</h1>
                        </div>
                        <div class="col-xs-12 mb wow fadeInUp">
                            <form action="/library/submitModifyPost" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="writer" value="${post.writer}">
                                <input type="hidden" name="postNum" value="${post.postNum}">
                                제목 <input type="text" name="title" size="55" value="${post.title}" required>
                                <input type="checkbox" name="notice" id="noticeChecked" value="1" onclick="checkboxForNotice();"
                                <c:if test="${post.notice == 1}">checked</c:if> />공지로 등록<br>
                                <input type="hidden" name="notice" id="noticeUnchecked" value="0" />
                                <textarea name="content" id="content">${post.content}</textarea><br>
                                <div id="addFileForm">
                                    <c:forEach var="file" items="${fileList}">
                                        ${file.originalFileName} <br>
                                    </c:forEach>
                                </div>
                                <input type="button" value="첨부파일 추가" onClick="addFile();">
                                <input type="button" value="파일첨부 취소" onclick="cancelFile();">
                                <br>
                                <button class="pull-left btn btn-theme">수정하기</button>
                                <button type="button" class="pull-left btn btn-theme" onclick="location.href='/library/readPost?postNum=${post.postNum}'">취소</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="../include/footer.jspf" %>

<script type="text/javascript">

    CKEDITOR.replace('content', {filebrowserUploadUrl:'/imageUpload'});
    let noticeChecked = document.getElementById("noticeChecked");
    let noticeUnchecked = document.getElementById("noticeUnchecked");

    function checkboxForNotice() {
        if(noticeChecked.checked) { noticeUnchecked.disabled = true; }
        else { noticeUnchecked.disabled = false; }
    }

    var cnt = 1;
    function addFile(){
        $("#addFileForm").append("<br>" + "<input type='file' name='file" + cnt + "' required />");
        cnt++;
    }
    function cancelFile() {
        $("#addFileForm").empty();
        deleteFileList();
        cnt = 0;
    }

    function deleteFileList() {
        // 제이쿼리ajax로 구현해보기
        console.log("제이쿼리로 파일삭제 시도 :::");
        $.ajax({
            method : 'DELETE',
            url : '/library/deleteFileList',
            data : { postNum : ${post.postNum} }
        }).done(function(result){
            console.log(result);
        });
    }

</script>

</body>
</html>