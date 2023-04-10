<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
html {
    height: 100%;
}
body {
    position: relative;
    width: 100%;
    height: 100%;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 16px;
}
#id, #pw {
    width: 300px;
    height: 50px;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 16px;
    border: 0;
    margin: 2px;
    border-radius: 10px;
    outline: none;
    padding-left: 10px;
    background-color: rgb(233, 233, 233);
}
input#saveIdBox {
    width: 20px;
    height: 20px;
    border: 0;
    margin-top: 10px;
    border-radius: 20px;
    padding-left: 10px;
    background-color: Turquoise;
    border:1px solid Turquoise;
}
input#saveIdBox:checked {
    color:#fff;
    background-color:Turquoise;
    border-color:#000;
}
#loginButton {
    width: 310px;
    height: 50px;
    border: 0px;
    border-radius: 10px;
    margin: 2px;
    color: white;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 18px;
    background-color: Turquoise;
    cursor:pointer;
}
.homeButton {
    width: 310px;
    height: 50px;
    border: 0px;
    border-radius: 10px;
    margin: 2px;
    color: white;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 18px;
    background-color: Greenyellow;
    cursor:pointer;
}
.loginApi {
    margin: 3px;
}
.loginMenu {
    position: absolute;
    top: 50%;
    left: 50%;
    margin:-300px 0 0 -150px
}
.signUpMenu {
    margin-bottom: 12%;
}
.loginTitle {
    font-size: 24px;
}
.subMenu {
    font-size: 14px;
    color: grey;
        display:inline-block;
        text-align: right;
}
a {
    color: grey;
    text-decoration: none;
}
</style>
</head>
<body>
<div class="loginMenu">
    <div class="signUpMenu">
        <div class="loginTitle">
            <h2>로그인</h2>
        </div>
        <form action="/submitLogin" method="post">
            <div class="inputId">
                <input type="text" name="id" id="id" placeholder="아이디">
            </div>
            <div>
                <input type="password" name="pw" id="pw" placeholder="4~16 자리 영문+숫자 조합">
            </div>
            <button id="loginButton">로그인하기</button><br>
            <button type="button" class="homeButton" onclick="location.href='/'">처음으로</button>
        </form>
        <div class="subMenu">
            <div id="right-menu" ><a href="javascript:comingSoon();">ID/PW 찾기</a> |
            <a id="signUp" href="/signUp">회원가입</a></div>
        </div>
    </div>
</div>

<script>
    function comingSoon() {
        alert("업데이트 예정입니다.");
    }
</script>

</body>
</html>

