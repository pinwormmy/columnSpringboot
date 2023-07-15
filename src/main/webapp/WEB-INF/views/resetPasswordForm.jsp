<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>비밀번호 재설정</title>
</head>
<body>
<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>비밀번호 재설정</h1>
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
                                                <strong>비밀번호를 재설정하세요.</strong>
                                            </div>
                                            <hr>
                                            <form id="resetPassword" action="${pageContext.request.contextPath}/reset-password" method="post">
                                                <input type="hidden" name="token" value="${token}"/>
                                                <table>
                                                    <tr>
                                                        <td>새로운 비밀번호 :</td>
                                                        <td><input type="password" id="password" name="password" placeholder="새로운 비밀번호를 입력하세요"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>비밀번호 확인 :</td>
                                                        <td><input type="password" id="password2" name="password2" placeholder="비밀번호를 다시 입력하세요"></td>
                                                    </tr>
                                                </table>
                                                <div style="margin-top: 20px;">
                                                    <input type="submit" class="btn btn-theme" value="비밀번호 변경">
                                                    <button type="button" onclick="location.href='/login'">취소</button>
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
const resetPasswordForm = document.getElementById("resetPassword");

<c:if test="${not empty message}">
    alert("${message}");
    history.back();
</c:if>

function checkPasswordMatch() {
    let isPassword = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$/;

    if (resetPasswordForm.password.value == "") {
        alert("비밀번호를 입력하세요!!");
        resetPasswordForm.password.focus();
        return false;
    }
    if (resetPasswordForm.password2.value == "") {
        alert("비밀번호 확인도 입력하세요!!");
        resetPasswordForm.password2.focus();
        return false;
    }
    if (resetPasswordForm.password.value != resetPasswordForm.password2.value) {
        alert("비밀번호 재입력까지 일치해야합니다.");
        resetPasswordForm.password.focus();
        return false;
    }
    if(!isPassword.test(resetPasswordForm.password.value)){
        alert("비밀번호 양식 확인해주세요");
        resetPasswordForm.password.focus();
        return false;
    }

    resetPasswordForm.submit();
}

resetPasswordForm.onsubmit = function(event) {
    if (!checkPasswordMatch()) {
        event.preventDefault();
    }
};

</script>

<%@include file="./include/footer.jspf" %>
</body>
</html>
