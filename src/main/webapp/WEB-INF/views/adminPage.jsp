<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지</title>
<style>
.admin-page {
    width: 1600px;
    margin: auto;
}

.btn-turquoise {
    background-color: #40E0D0;
    color: #fff;
    border: none;
    margin: 10px;
}

.btn-turquoise:hover {
    background-color: #3CB7B8;
    color: #fff;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jspf" %>

<div class="admin-page">
    <h1>🛠 관리자 페이지</h1>
</div>

<!-- 회원 목록 테이블 -->
<div class="container">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>닉네임</th>
                <th>실명</th>
                <th>이메일</th>
                <th>연락처</th>
                <th>회원 등급</th>
                <th>가입일자</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${memberList}" var="member">
                <tr>
                    <td>${member.id}</td>
                    <td>${member.nickName}</td>
                    <td>${member.realName}</td>
                    <td>${member.email}</td>
                    <td>${member.phone}</td>
                    <td>${member.grade}</td>
                    <td>${member.regDate}</td>
                    <td>
                        <button class="btn btn-turquoise">수정</button>
                        <button class="btn btn-danger">탈퇴</button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty memberList}"><td colspan="8">회원 목록이 없습니다....(조회오류 확인 필요)</td></c:if>
        </tbody>
    </table>
</div>
<%@ include file="/WEB-INF/views/include/footer.jspf" %>

</body>
</html>
