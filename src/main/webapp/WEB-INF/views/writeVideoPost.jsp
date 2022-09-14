<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 영상글쓰기~~@@</title>
</head>
<body>
<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="quarterscreen">
		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
	                    <div class="post-heading mb">
	                        <h1>영상글 작성하기</h1>
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
							<div class="col-xs-12 mb wow fadeInUp">
                                <form action="/submitVideoPost" method="post">
                                    제목 <input type="text" name="title" size="70" required> <br>
                                    영상주소 <br>
                                    <textarea name="videoUrl" cols="100" rows="3"></textarea>
                                    <button class="pull-left btn btn-theme">게시하기</button>
                                    <button type="button" class="pull-left btn btn-theme" onclick="location.href='/videoBoard'">취소</button>
                                </form>
							</div>

                            <div class="post-navigation">
                                <a class="pull-left btn btn-theme" href="#">Older Posts</a>
                                <a class="pull-right btn btn-theme" href="#">Newer Posts</a>
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