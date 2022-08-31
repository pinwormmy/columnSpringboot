<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 로그인</title>
</head>
<body>
<%@include file="./include/header.jspf" %>

<!-- Header -->
<header id="headerwrap" class="fullscreen">
    <div class="vertical-center">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <form class="form white-text" action="/submitLogin" method="post">
                        <div class="form-group">
                            <input type="text" class="outlined subscribe-input fullwidth-me form-control input-lg mb" name="id" placeholder="ID"><br>
                            <input type="checkbox" name="saveId" /><span>아이디 저장</span>
                        </div>

                        <div class="form-group mt30">
                            <input type="password" class="outlined subscribe-input fullwidth-me form-control input-lg" name="pw" placeholder="비밀번호">
                        </div>
                        <div class="form-group">
                            <button class="pull-left btn btn-theme btn-white mt30">로그인</button>
                            <button type="button" class="pull-right btn btn-theme btn-white mt30" onclick="location.href='/signUp'">회원가입</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</header>

<%@include file="./include/footer.jspf" %>
</body>
</html>