<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jspf" %>

<h1>🛠 회원 정보 수정</h1>

<form action="/updateMember" method="post">
    <input type="hidden" name="id" value="${member.id}">
    <label for="nickName">닉네임:</label><br>
    <input type="text" id="nickName" name="nickName" value="${member.nickName}"><br>
    <label for="realName">실명:</label><br>
    <input type="text" id="realName" name="realName" value="${member.realName}"><br>
    <label for="email">이메일:</label><br>
    <input type="text" id="email" name="email" value="${member.email}"><br>
    <label for="phone">연락처:</label><br>
    <input type="text" id="phone" name="phone" value="${member.phone}"><br>
    <label for="grade">회원 등급:</label><br>
    <input type="text" id="grade" name="grade" value="${member.grade}"><br>
    <input type="submit" value="수정하기">
    <button type="button" onclick="location.href='/adminPage'">취소</button>
</form>

<%@ include file="/WEB-INF/views/include/footer.jspf" %>

</body>
</html>
