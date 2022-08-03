<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="./include/header.jspf" %>

<header id="headerwrap" class="halfscreen">
		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
	                    <div class="post-heading mb">
	                        <h1>글 작성하기</h1>
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
                                <form action="/submitPost" method="post">
                                    <input type="hidden" name="writer" value="admin">
                                    제목 <input type="text" name="title" size="70" required> <br>
                                    <textarea name="content" id="content"></textarea><br>
                                    <button class="pull-left btn btn-theme">게시하기</button>
                                    <button type="button" class="pull-left btn btn-theme" onclick="location.href='/board'">취소</button>
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
