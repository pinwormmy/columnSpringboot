<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>
<style>
    body {
        margin: 0;
        padding: 0;
    }
    .container {
        margin: 0 auto;
        padding: 20px;
    }
    form {
        display: flex;
        flex-direction: column;
    }
    label, input {
        margin-bottom: 10px;
    }
    input, button {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    button, input[type="submit"] {
        background-color: #A3E4D7;
        color: white;
        cursor: pointer;
    }
    button:hover, input[type="submit"]:hover {
        background-color: #48C9B0;
    }
</style>
</head>
<body>

<%@ include file="/WEB-INF/views/include/header.jspf" %>
<div class="container" style="width:33%;">
    <h1>🛠 회원 정보 수정</h1>
    <form action="/submitModifyMemberByAdmin" method="post">
        <label for="id">ID:</label>
        <input type="text" id="id" name="id" value="${member.id}" readonly title="해당 항목은 수정할 수 없습니다">
        <label for="nickName">닉네임:</label>
        <input type="text" id="nickName" name="nickName" value="${member.nickName}">
        <label for="realName">실명:</label>
        <input type="text" id="realName" name="realName" value="${member.realName}">
        <label for="email">이메일:</label>
        <input type="text" id="email" name="email" value="${member.email}"
        readonly title="해당 항목은 수정할 수 없습니다">
        <label for="phone">연락처:</label>
        <input type="text" id="phone" name="phone" value="${member.phone}">
        <label for="grade">회원 등급:</label>
        <input type="text" id="grade" name="grade" value="${member.grade}">
        <input type="submit" value="수정하기">
        <button type="button" onclick="location.href='/adminPage'">취소</button>
    </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jspf" %>

</body>
</html>
