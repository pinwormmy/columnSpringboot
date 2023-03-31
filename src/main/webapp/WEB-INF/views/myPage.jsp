<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>마이 페이지</title>
<style>
.my-page {
    margin: 30px;
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

<div class="my-page">
    <h1>👤나의 정보</h1>
</div>

<section class="user-dashboard page-wrapper" style="padding: 0;">
    <hr class="color-hr">
	<div class="container">
		<div class="row">
			<div class="col-md-12" style="width: 97%; padding: 0;">
				<div class="dashboard-wrapper user-dashboard" style="margin: 30px 0 30px 0;">
					<div class="media">
						<div class="media-body">
							<h1 class="media-heading">환영합니다. ${member.nickName}님!</h1>
							<hr>
							<div class="member-info" style="font-size: 20px; line-height: 50px;">
                                <span>ID : ${member.id}</span><br>
                                <span>실명 : ${member.realName}</span><br>
                                <span>별명 : ${member.nickName}</span><br>
                                <span>연락처 : ${member.phone}</span><br>
                                <span>이메일 : ${member.email}</span><br>
                                <hr>
							</div>
						</div>
					</div>
                    <c:if test="${member.grade == 3}">
                        <div>
                            <a href="admin" class="btn btn-turquoise">관리자 모드</a>
                        </div>
                    </c:if>
                    <div>
                        <a href="editProfile" class="btn btn-turquoise">회원 정보 변경</a>
                    </div>
                    <hr>
					<div class="total-order me-20">
					</div>
					<hr>
					<div class="total-order mt-20">
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/views/include/footer.jspf" %>

<script>

    //alert("js test 00");

    function comingSoon() {
        alert("업데이트 예정입니다.");
    }

</script>


</body>
</html>
