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
                        <h1>회원정보수정</h1>
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
                                                    <p>비밀번호 : <input type="password" name="pw" value="${member.pw}"></p>
                                                    <p>비밀번호확인 : <input type="password" name="pw2" value="${member.pw}"></p>
                                                    <p>이메일 : <input type="email" name="email" value="${member.email}"></p>
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

	function checkSignupForm() {

		let isPassword = /\S{4,}/;

		if (modifyMyInfoForm.pw.value == "") {
			alert("비밀번호를 입력하세요!!");
			modifyMyInfoForm.pw.focus();
			return false;
		}
		if(!isPassword.test(modifyMyInfoForm.pw.value)){
			alert("비밀번호는 4자리 이상이어야 합니다;");
			modifyMyInfoForm.pw.focus();
			return false;
		}
		if (modifyMyInfoForm.pw2.value == "") {
			alert("비밀번호 확인도 입력하세요!!");
			modifyMyInfoForm.pw2.focus();
			return false;
		}
		if (modifyMyInfoForm.pw.value != modifyMyInfoForm.pw2.value) {
			alert("비밀번호 재입력까지 일치해야합니다.");
			modifyMyInfoForm.pw.focus();
			return false;
		}
		if (modifyMyInfoForm.nickName.value == "") {
            alert("닉네임을 입력하세요!!");
            modifyMyInfoForm.nickName.focus();
            return false;
        }
		alert("수정되었습니다.");
		modifyMyInfoForm.submit();
	}

</script>

<%@include file="./include/footer.jspf" %>
</body>
</html>