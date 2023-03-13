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
    cursor:pointer;
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
.tooltip {
    font-size: 14px;
    color: grey;
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
                <input type="text" name="id" id="inputId" placeholder="아이디"><br>
                <span id="idCheckText" class="tooltip">ID 중복확인이 필요합니다.</span>
            </div>
            <div>
                <input type="password" name="pw" id="pw" placeholder="4~16 자리 영문+숫자 조합">
            </div>
            <div>
                <input type="password" name="pw2" id="pw2" placeholder="비밀번호 재입력">
            </div>
            <div>
                <input type="text" name="realName" placeholder="이름">
            </div>
            <div>
                <input type="text" name="nickName" placeholder="별명">
            </div>
            <div>
                <input type="email" id="email" name="email" placeholder="이메일"><br>
                <span id="emailCheckText" class="tooltip">이메일 중복확인이 필요합니다.</span><br>
                <button id="sendVerificationNumberButton" class="basicButton" style="background-color: #AED6F1;">인증번호 받기</button><br>
                <input id="inputEmailVerificationNumber" placeholder="이메일 인증번호 입력"><br>
            </div>
            <div>
                <input type="text" name="phone" placeholder="연락처"><br><br>
            </div>

            <button type="button" class="basicButton" onclick="checkSignupForm();">가입하기</button><br>
            <button type="button" class="basicButton" style="background-color: yellowgreen;"
            onclick="location.href='/login'">이미 가입한 회원이면 로그인하기</button><br>
            <button type="button" class="basicButton" style="background-color:#9FE2BF;"
            onclick="location.href='/'">처음 화면으로</button>
        </form>
    </div>
</div>

<script type="text/javascript">

	let submitSignUpForm = document.getElementById("submitSignUp");
    let isEmailVerificationNumberValid = false;
    let isUniqueIdValid = false;
    let isEmailValid = false;

    const inputId = document.getElementById("inputId");
    const idCheckText = document.getElementById("idCheckText");
    const emailCheckText = document.getElementById("emailCheckText");
    const sendVerificationNumberButton = document.getElementById('sendVerificationNumberButton');
    const inputEmail = document.getElementById('email');
    const inputEmailVerificationNumber = document.getElementById('inputEmailVerificationNumber');
    const emailVerificationResultText = document.getElementById('emailCheckText');

    const isIdValid = (inputId) => {
      const idPattern = /^[a-z]+[a-z0-9]{3,19}$/g;
      return idPattern.test(inputId);
    };

    const checkUniqueId = (inputId) => {
      fetch("<%=request.getContextPath()%>/checkUniqueId?mId=" + inputId)
        .then(response => response.json())
        .then(data => {
          if (data === 0) {
            idCheckText.innerHTML = "해당 ID 사용가능합니다.";
            isUniqueIdValid = true;
          } else {
            idCheckText.innerHTML = "사용할 수 없는 ID입니다.";
            isUniqueIdValid = false;
          }
        })
        .catch(error => {
          alert("(아이디중복검사)서버 요청 실패...", error);
        });
    };

    const validateEmailVerificationNumber = (inputValue) => {
      const verificationNumberPattern = /^\d{8}$/;
      isEmailVerificationNumberValid = verificationNumberPattern.test(inputValue);
    };

    const validateEmail = (inputEmail) => {
      const emailPattern = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
      isEmailValid = emailPattern.test(inputEmail);
    };

    // focusout 이벤트 리스너 추가
    inputId.addEventListener("focusout", function () {
      const inputIdValue = inputId.value;
      if (inputIdValue === "") {
        idCheckText.innerHTML = "ID를 입력해주세요.";
        isUniqueIdValid = false;
        return false;
      }
      if (!isIdValid(inputIdValue)) {
        idCheckText.innerHTML = "ID는 영문자로 시작하는, 4~20자 영어 혹은 숫자이어야 합니다.";
        isUniqueIdValid = false;
        return false;
      }
      checkUniqueId(inputIdValue);
    });

    inputEmailVerificationNumber.addEventListener("input", function () {
        const inputValue = inputEmailVerificationNumber.value;
        validateEmailVerificationNumber(inputValue);
    });

    // 이메일 입력 필드 변경 이벤트
    inputEmail.addEventListener("change", function () {
        const inputEmail = submitSignUpForm.elements.email.value;
        validateEmail(inputEmail);

        if (isEmailValid && isEmailVerificationNumberValid && isUniqueIdValid) {
            submitSignUpForm.elements.submit.disabled = false;
        } else {
            submitSignUpForm.elements.submit.disabled = true;
        }
    });

    sendVerificationNumberButton.addEventListener('click', () => {
        const email = inputEmail.value;
        if (email === '') {
            emailCheckText.innerHTML = '이메일을 입력해주세요.';
            return;
        }

        // 인증 메일 전송 API 호출
        fetch('/sendVerificationMail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email })
        })
        .then(response => {
            if (response.ok) {
                emailCheckText.innerHTML = '인증번호를 입력해주세요.';
            } else {
                emailCheckText.innerHTML = '인증번호 전송에 실패하였습니다. 다시 시도해주세요.';
            }
        })
        .catch(error => {
            emailCheckText.innerHTML = '서버 요청 실패... 다시 시도해주세요.';
        });
    });

    inputEmailVerificationNumber.addEventListener('input', () => {
        const inputText = inputEmailVerificationNumber.value;
        const length = inputText.length;

        if (length === 8) {
            emailVerificationResultText.innerHTML = '인증번호 확인이 완료되었습니다.';
        }
    });

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