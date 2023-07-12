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
                                            <form action="${pageContext.request.contextPath}/resetPassword" method="post">
                                                <input type="hidden" name="token" value="${token}"/>
                                                <table>
                                                    <tr>
                                                        <td>새로운 비밀번호 :</td>
                                                        <td><input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호를 입력하세요"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>비밀번호 확인 :</td>
                                                        <td><input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요"></td>
                                                    </tr>
                                                </table>
                                                <div style="margin-top: 20px;">
                                                    <input type="submit" class="btn btn-theme" value="비밀번호 변경">
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

function checkPasswordMatch() {
    const newPassword = resetPasswordForm.newPassword.value;
    const confirmPassword = resetPasswordForm.confirmPassword.value;

    if (newPassword !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다!");
        resetPasswordForm.confirmPassword.focus();
        return false;
    }

    resetPasswordForm.submit();
}

resetPasswordForm.onsubmit = function(event) {
    event.preventDefault();
    checkPasswordMatch();
};
</script>

<%@include file="./include/footer.jspf" %>
</body>
</html>
