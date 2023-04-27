<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지</title>
<style>
.admin-page {
    width: 1600px;
    margin: auto;
}

.btn-turquoise {
    background-color: #40E0D0;
    color: #fff;
    border: none;
    margin: 10px;
}

.btn-turquoise:hover {
    background-color: #3CB7B8;
    color: #fff;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jspf" %>

<div class="admin-page">
    <h1>🛠 관리자 페이지</h1>
</div>

<!-- 여기에 관리자 기능들을 추가하세요. -->

<%@ include file="/WEB-INF/views/include/footer.jspf" %>

</body>
</html>
