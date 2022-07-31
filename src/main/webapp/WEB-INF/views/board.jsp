<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="./include/header.jspf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header id="headerwrap" class="halfscreen">

		<div class="align-bottom wow fadeInUp">
            <div class="row">
            	<div class="container">
	                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
	                    <div class="post-heading mb">
	                        <h1>컬럼 목록 화면123</h1>
	                        <p class="lead white">수리 모드에서는 사진과 메시지, 계정 등 개인 데이터에 접근할 수 없고 기본으로 설치된 애플리케이션만 이용할 수 있다.
	                        스마트폰 설정에서 '배터리 및 디바이스 케어' 메뉴를 선택한 뒤 '수리 모드' 탭을 실행하면 스스로 시스템 재부팅을 하면서 수리 모드가 켜진다.</p>
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
		                        <c:if test="${empty postList}">작성된 글이 없습니다. 글쓰기 버튼을 누르면 작성할 수 있습니다~!</c:if>
		                        <div id="comments-list" class="gap">
		                            <c:forEach var="post" items="${postList}">
                                        <div class="media">
                                             <div class="media-body">
                                                   <div class="well">
                                                       <div class="media-heading">
                                                           <h2><a href="/post?postNum=${post.postNum}">${post.title}</a></h2><br>
                                                           <small><fmt:formatDate pattern="yyyy.MM.dd" value="${post.regDate}"/> </small>
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
						<a href="/writePost" class="pull-right btn btn-theme" href="#">글쓰기</a>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@include file="./include/footer.jspf" %>
