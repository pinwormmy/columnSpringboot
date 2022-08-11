<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="./include/header.jspf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header id="headerwrap" class="halfscreen">

		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
	                    <div class="post-heading mb">
	                        <h1>영상 컬럼</h1>
	                        <p class="lead white">주로 한식당에서 소량으로 유통하던 나라에서도 최근엔 현지 유통체인들이 앞다퉈 한국 라면을 취급하고 있다.</p>
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
		                        <c:if test="${empty videoList}">작성된 글이 없습니다. 글쓰기 버튼을 누르면 작성할 수 있습니다~!</c:if>
		                        <div id="comments-list" class="gap">
		                            <c:forEach var="video" items="${videoList}">
                                        <div class="media">
                                             <div class="media-body">
                                                   <div class="well">
                                                       <div class="media-heading">
                                                           <h2>${video.title}</h2>${video.regDate}<br>
                                                           ${video.videoUrl}
                                                       </div>
                                                   </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div><!--/#comments-list-->
		                        <div class="post-navigation">
		                            <a class="pull-letf btn btn-theme" href="#">이전</a>
		                            <a class="pull-center btn btn-theme" href="#">1</a>
		                            <a class="pull-center btn btn-theme" href="#">2</a>
		                            <a class="pull-center btn btn-theme" href="#">3</a>
		                            <a class="pull-center btn btn-theme" href="#">4</a>
		                            <a class="pull-right btn btn-theme" href="#">다음</a>
		                        </div>
		                    </div><!--/#comments-->
						</div>
						<a href="/writeVideoPost" class="pull-right btn btn-theme" href="#">글쓰기</a>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@include file="./include/footer.jspf" %>
