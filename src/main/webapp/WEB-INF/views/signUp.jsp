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
                    <h3>회원가입</h3>
                    <form class="form white-text" action="/submitSignUp" id="submitSignUpForm" method="post">
                        <div class="form-group">
                            <input type="text" class="outlined subscribe-input fullwidth-me form-control input-lg mb" name="id" id="id" placeholder="ID">
                            <div id="isUniqueId">ID 중복확인이 필요합니다</div>
                        </div>
                        <div class="form-group mt30">
                            <input type="password" class="outlined subscribe-input fullwidth-me form-control input-lg" name="pw" placeholder="비밀번호">
                        </div>
                        <div class="form-group mt30">
                            <input type="password" class="outlined subscribe-input fullwidth-me form-control input-lg" name="pw2" placeholder="비밀번호 확인">
                        </div>
                        <div class="form-group mt30">
                            <input type="text" class="outlined subscribe-input fullwidth-me form-control input-lg" name="nickName" placeholder="닉네임">
                        </div>
                        <div class="form-group mt30">
                            <input type="email" class="outlined subscribe-input fullwidth-me form-control input-lg" name="email" placeholder="이메일">
                        </div>
                        <div class="form-group">
                            <button type="button" class="pull-left btn btn-theme btn-white mt30" onclick="checkSignupForm();">가입하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header>

<script>

    alert("js test02");

    let submitSignUpForm = document.getElementById("submitSignUpForm");
	let checkUniqueId = false;
	let checkUniqueNickname = false;

	function checkSignupForm() {

		let isId = /^[a-z]+[a-z0-9]{3,19}$/g;
		let isPassword = /\S{4,}/;
		let isEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

		if (submitSignUpForm.id.value == "") {
			alert("ID를 입력하세요!!");
			submitSignUpForm.id.focus();
			return false;
		}
		if(!isId.test(submitSignUpForm.id.value)){
			alert("ID는 영문자로 시작하는, 4~20자 영어 혹은 숫자이어야 합니다;");
			submitSignUpForm.id.focus();
			return false;
		}
		if(checkUniqueId == false){
			alert("중복되지 않은 ID를 입력하세요!!");
			submitSignUpForm.id.focus();
			return false;
		}
		if (submitSignUpForm.pw.value == "") {
			alert("비밀번호를 입력하세요!!");
			submitSignUpForm.pw.focus();
			return false;
		}
		if(!isPassword.test(submitSignUpForm.pw.value)){
			alert("비밀번호는 4자리 이상이어야 합니다;");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.pw2.value == "") {
			alert("비밀번호 확인도 입력하세요!!");
			submitSignUpForm.pw2.focus();
			return false;
		}
		if (submitSignUpForm.pw.value != submitSignUpForm.pw2.value) {
			alert("비밀번호 재입력까지 일치해야합니다.");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.nickName.value == "") {
            alert("닉네임을 입력하세요!!");
            submitSignUpForm.nickName.focus();
            return false;
        }
		alert("가입 완료. 환영합니다!");
		submitSignUpForm.submit();
	}

	$('#id').focusout(function(){
		let id = $('#id').val();

		if(id == ""){
			$("#isUniqueId").html('');
			isUniqueId= false;
			return false;
		}
		$.ajax({
			url : "/isUniqueId",
			type : "get",
			data : 'id=' + $('#id').val(),
			datatype : 'json',
			success : function(result){
				if(result == 0){
					$("#isUniqueId").html('해당 ID 사용가능합니다.');
					checkUniqueId = true;
				}else{
					$("#isUniqueId").html('사용할 수 없는 ID입니다.');
					checkUniqueId = false;
				}
			},
			error : function(a, b, c){
				alert("(아이디중복검사)서버 요청 실패...", a, b, c);
			}
		})
	});

</script>
<%@include file="./include/footer.jspf" %>
</body>
</html>