<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 로그인</title>
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
                                            <div>
                                                <p>ID : ${member.id}</p>
                                                <p>별명 : <input type="text" name="nickName" value="${member.nickName}"></p>
                                                <p>비밀번호 : <input type="password" name="pw" value="${member.pw}"></p>
                                                <p>비밀번호확인 : <input type="password" name="pw2" value="${member.pw}"></p>
                                                <p>이메일 : <input type="email" name="email" value="${member.email}"></p>
                                                <button type="button">수정하기</button>
                                                <button type="button">취소</button>
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
    </div>
</section>

<%@include file="./include/footer.jspf" %>
</body>
</html>