<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="./include/header.jspf" %>

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
		                        <div id="comments-list" class="gap">
		                           <c:forEach>
		                           <div class="media">
		                                <div class="media-body">
                                            <div class="well">
                                                <div class="media-heading">

                                                </div>
                                            </div>
		                                </div>
		                           </div>
		                           </c:forEach>
		                           <div class="media">
                                        <div class="media-body">
                                               <div class="well">
                                                   <div class="media-heading">
                                                       <h2>尹 시장교란 불법 공매도 뿌리뽑겠다</h2><br>
                                                       <small>2022.07.28</small>
                                                   </div>
                                               </div>
                                        </div>
                                   </div>

		                        </div><!--/#comments-list-->
		                        <div class="post-navigation">
		                            <a class="pull-left btn btn-theme" href="#">Older Posts</a>
		                            <a class="pull-right btn btn-theme" href="#">Newer Posts</a>
		                        </div>
		                        <a class="pull-right btn btn-theme" href="#">Reply</a>
		                    </div><!--/#comments-->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@include file="./include/footer.jspf" %>
