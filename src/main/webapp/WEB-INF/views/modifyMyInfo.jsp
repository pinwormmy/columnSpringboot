<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원정보 수정</title>
</head>
<body>
<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>회원정보 수정</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<section class="white section-wrapper">
    <div class="section-inner">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="row">
                        <div id="comments" class="col-xs-12">
                            <div id="comments-list" class="gap">
                                <div class="media">
                                    <div class="media-body">
                                        <div class="well">
                                            <div class="media-heading">
                                                <strong>${member.nickName}님의 회원정보수정</strong>
                                            </div>
                                            <hr>
                                            <form action="/submitModifyMyInfo" id="modifyMyInfo" method="post">
                                                <div>
                                                    <p>ID : ${member.id}</p>
                                                    <input type="hidden" name="id" value="${member.id}">
                                                    <p>별명 : <input type="text" name="nickName" value="${member.nickName}"></p>
                                                    <p>비밀번호 : <input type="password" name="pw" placeholder="비밀번호를 입력하세요" value="${member.pw}"></p>
                                                    <p>비밀번호확인 : <input type="password" name="pw2" placeholder="비밀번호를 다시 입력하세요" value="${member.pw}"></p>
                                                    <p>이메일 : <input type="email" name="email" value="${member.email}"></p>
                                                    <button type="button" id="emailAuthBtn" class="btn btn-theme">이메일 인증</button>
                                                    <p>인증 코드 : <input type="text" name="authCode" id="authCode" placeholder="이메일로 받은 인증 코드를 입력하세요"></p>
                                                    <button type="button" id="checkAuthCodeBtn" class="btn btn-theme">인증 확인</button>
                                                    <button type="button" class="pull-left btn btn-theme" onclick="checkSignupForm();">수정하기</button>
                                                    <button type="button" class="pull-left btn btn-theme" onclick="location.href='/myPage'">취소</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

    // alert("js test02");

    let modifyMyInfoForm = document.getElementById("modifyMyInfo");
	let checkUniqueId = false;
	let checkUniqueNickname = false;
	let isEmailAuthed = false;

	let generatedVerificationNumber = null;
    let verificationNumberValid = false;
    let isEmailValid = false;
    let isUniqueEmailValid = false;

    const emailCheckText = document.getElementById("emailCheckText");
    const sendVerificationNumberButton = document.getElementById('sendVerificationNumberButton');
    const inputEmail = document.getElementById('email');
    const inputEmailVerificationNumber = document.getElementById('inputEmailVerificationNumber');

	document.getElementById("emailAuthBtn").addEventListener("click", sendAuthEmail);
    document.getElementById("checkAuthCodeBtn").addEventListener("click", checkAuthCode);

    const validateEmailVerificationNumber = (inputValue) => {
      const verificationNumberPattern = /^\d{8}$/;
      return verificationNumberPattern.test(inputValue);
    };

    const validateEmail = (inputEmail) => {
      const emailPattern = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
      return emailPattern.test(inputEmail);
    };

    // 이메일 인증번호 전송 버튼 클릭 이벤트
    sendVerificationNumberButton.addEventListener('click', () => {
        const email = inputEmail.value;
        if (email === '') {
            alert("이메일을 입력해주세요.");
            return false;
        }

        fetch('/sendVerificationMail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: userEmail
            })
        })
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                throw new Error('서버에서 문제가 발생했습니다.');
            }
        })
        .then(data => {
            if (data.success) {
                generatedVerificationNumber = data.verificationNumber;
                alert("인증번호가 이메일로 발송되었습니다. 확인해주세요.");
            } else {
                alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
            }
        })
        .catch(error => {
            console.error("Error: ", error);
        });
    }

	inputEmailVerificationNumber.addEventListener('input', () => {
        const inputText = inputEmailVerificationNumber.value;
        const length = inputText.length;
        if (length === 8) {
            if (generatedVerificationNumber && generatedVerificationNumber === inputText) {
                alert("인증번호 확인이 완료되었습니다.");
                emailCheckText.innerHTML = '인증번호 확인이 완료되었습니다.';
                verificationNumberValid = true;
            } else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
                verificationNumberValid = false;
            }
        }
    });

	function sendAuthEmail() {
        let email = modifyMyInfoForm.email.value;
        if (email === "") {
            alert("이메일을 입력하세요!");
            modifyMyInfoForm.email.focus();
            return;
        }

        // 이메일 전송하는 서버 통신 코드 작성
        alert("이메일로 인증 코드가 전송되었습니다.");
    }

    function checkAuthCode() {
        let authCode = document.getElementById("authCode").value;
        if (authCode === "") {
            alert("인증 코드를 입력하세요!");
            document.getElementById("authCode").focus();
            return;
        }

        // 인증 코드 확인하는 서버 통신 코드 작성

        // 서버에서 전송한 결과가 일치하면, 아래 코드 실행
        isEmailAuthed = true;
        alert("이메일 인증이 완료되었습니다.");
    }

    function checkSignupForm() {
        let isPassword = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$/;

        if (isUniqueIdValid == false) {
            alert("올바른 ID를 입력하세요!!");
            submitSignUpForm.id.focus();
            return false;
        }

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
        if (!isPassword.test(submitSignUpForm.pw.value)) {
            alert("비밀번호 양식 확인해주세요");
            submitSignUpForm.pw.focus();
            return false;
        }
        if (submitSignUpForm.name.value == "") {
            alert("이름을 입력하세요!!");
            submitSignUpForm.name.focus();
            return false;
        }
        if (submitSignUpForm.nickName.value == "") {
            alert("별명을 입력하세요!!");
            submitSignUpForm.nickName.focus();
            return false;
        }
        if (submitSignUpForm.phone.value == "") {
            alert("연락처를 입력하세요!!");
            submitSignUpForm.phone.focus();
            return false;
        }
        if (isUniqueEmailValid == false) {
            alert("올바른 이메일을 입력하세요!!");
            submitSignUpForm.email.focus();
            return false;
        }
        if (verificationNumberValid == false) {
            alert("이메일 인증을 완료해주세요!!");
            submitSignUpForm.email.focus();
            return false;
        }

        submitSignUpForm.submit();
    }

</script>

<%@include file="./include/footer.jspf" %>
</body>
</html>