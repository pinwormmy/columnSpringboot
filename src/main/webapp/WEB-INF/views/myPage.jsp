<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>P E T M A L L</title>
<style>
.my-page {
    margin: 30px;
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
							<h1 class="media-heading">환영합니다. ${member.id}님!</h1>
							<hr>
							<div class="member-info" style="font-size: 20px; line-height: 50px;">
                                <span>고객명 : ${member.name}</span><br>
                                <span>연락처 : ${member.phone}</span><br>
                                <span>이메일 : ${member.email}</span><br>
                                <span>주소 : ${member.address}</span><br>
                                <hr>
							</div>
						</div>
					</div>
					<div class="total-order me-20">
					    <h3>💳결제 수단 등록</h3>
					    <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>유형</th>
                                        <th>이름</th>
                                        <th>등록일자</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><a href="#!">#1</a></td>
                                        <td>신용카드</td>
                                        <td>국민 카드 - 궁민이 아니신가 카드</td>
                                        <td>Mar 25, 2022</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
					</div>
					<hr>
					<div class="total-order mt-20">
						<h3>📦주문 내역</h3>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>주문번호</th>
										<th>상품명</th>
										<th>주문일자</th>
										<th>상품수</th>
										<th>가격</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><a href="#!">#252125</a></td>
										<td>털 깎인 미도리가 찾는 푹신이불</td>
										<td>Oct 12, 2022</td>
										<td>1</td>
										<td>27300원</td>
									</tr>
									<tr>
                                        <td><a href="#!">#21156</a></td>
                                        <td>팩맨 개구리를 위한 사또밥</td>
                                        <td>Oct 10, 2022</td>
                                        <td>1</td>
                                        <td>5500원</td>
                                    </tr>
								</tbody>
							</table>
						</div>
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

