<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
input {
    width: 400px;
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
.basicButton {
    width: 410px;
    height: 50px;
    border: 0px;
    border-radius: 10px;
    margin: 2px;
    color: white;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 18px;
    background-color: Turquoise;
}
.loginApi {
    margin: 3px;
}
.loginMenu {
    position: absolute;
    top: 50%;
    left: 50%;
    margin:-400px 0 0 -200px
}
.signUpMenu {
    margin-bottom: 10%;
}
.loginTitle {
    font-size: 24px;
}

</style>
</head>
<body>
<div class="loginMenu">
    <div class="signUpMenu">
        <div class="loginTitle">
            <h2>회원가입</h2>
        </div>
        <form action="/submitSignUp" name="submitSignUp" id="submitSignUp" method="post">
            <div class="inputId">
                <input type="text" name="id" id="id" placeholder="아이디">
            </div>
            <div>
                <input type="password" name="pw" id="pw" placeholder="4~16 자리 영문+숫자 조합">
            </div>
            <div>
                <input type="password" name="pw2" id="pw2" placeholder="비밀번호 재입력">
            </div>
            <div>
                <input type="text" name="name" placeholder="이름">
            </div>
            <div>
                <input type="email" name="email"placeholder="이메일">
            </div>
            <div>
                <input type="text" name="phone" placeholder="연락처(-포함)">
            </div>
            <div>
                <input type="text" name="address" placeholder="전체 주소 입력">
            </div>

            <button type="button" class="basicButton" onclick="checkSignupForm();" style='cursor:pointer;'>가입하기</button><br>
            <button type="button" class="basicButton" style="background-color: yellowgreen; cursor:pointer;"
            onclick="location.href='/login'">이미 가입한 회원이면 로그인하기</button><br>
            <button type="button" class="basicButton" style="background-color:#9FE2BF; cursor:pointer;"
            onclick="location.href='/'">처음 화면으로</button>
        </form>
    </div>
</div>

<script type="text/javascript">

	let submitSignUpForm = document.getElementById("submitSignUp");

	function checkSignupForm() {
		let isPassword = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$/;

		if (submitSignUpForm.pw.value == "") {
			alert("비밀번호를 입력하세요!!");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.pw2.value == "") {
			alert("비밀번호 확인도 입력하세요!!");
			submitSignUpForm.pw2.focus();
			return false;
		}
		if (submitSignUpForm.pw.value != pw2.value) {
			alert("비밀번호 재입력까지 일치해야합니다.");
			submitSignUpForm.pw.focus();
			return false;
		}
		if(!isPassword.test(submitSignUpForm.pw.value)){
			alert("비밀번호 양식 확인해주세요");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.name.value == "") {
			alert("이름을 입력하세요!!");
			submitSignUpForm.name.focus();
			return false;
		}
		submitSignUpForm.submit();
	}

</script>

</body>
</html>