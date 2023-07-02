<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 찾기</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
</style>
</head>
<body>
<div class="findMenu">
    <div class="findTitle">
        <h2>비밀번호 찾기</h2>
    </div>
    <form action="/findPassword" method="post">
        <div class="inputEmail">
            <input type="text" name="email" id="email" placeholder="이메일">
        </div>
        <button id="findButton">찾기</button><br>
        <button type="button" onclick="location.href='/login'">취소</button>
    </form>
</div>

<script>
    <c:if test="${not empty message}">
        alert("${message}");
    </c:if>
</script>

</body>
</html>
