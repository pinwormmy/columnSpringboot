<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>테스트 영상글~~@@</title>
</head>
<body>
<%@include file="../include/header.jspf" %>

<header id="headerwrap" class="quarterscreen">
    <div class="align-bottom wow fadeInUp">
        <div class="row">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading mb">
                        <h1>영상 컬럼</h1>
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
                                                           <a href="javascript:checkMemberLevelBeforeRead(${video.videoNum});">
                                                           <h2>${video.title}</h2><small>${video.regDate}</small></a><br>
                                                           <c:if test="${member.memberLevel == 3}">
                                                                <a href="/deleteVideoPost?videoNum=${video.videoNum}">삭제</a>
                                                           </c:if>
                                                       </div>
                                                   </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div><!--/#comments-list-->
		                        <div class="post-navigation">
                                    <c:if test="${page.prevPageSetPoint >= 1}">
                                        <a class="pull-letf btn btn-theme" href="/videoBoard?recentPage=${page.prevPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">이전</a>
                                    </c:if>
                                    <c:forEach var="countPage" begin="${page.pageBeginPoint}" end="${page.pageEndPoint}">
                                        <a class="pull-center btn btn-theme" href="/videoBoard?recentPage=${countPage}&searchType=${page.searchType}&keyword=${page.keyword}">${countPage}</a>
                                    </c:forEach>
                                    <c:if test="${page.nextPageSetPoint <= page.totalPage}">
                                        <a class="pull-right btn btn-theme" href="/videoBoard?recentPage=${page.nextPageSetPoint}&searchType=${page.searchType}&keyword=${page.keyword}">다음</a>
                                    </c:if>
                                </div>
		                    </div><!--/#comments-->
						</div>
						<c:if test="${member.memberLevel == 3}">
						    <a href="/writeVideoPost" class="pull-right btn btn-theme" href="#">글쓰기</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@include file="../include/footer.jspf" %>

<script>
    function checkMemberLevelBeforeRead(videoNum) {
        if(${member == null || member.memberLevel < 2}) {
            alert("해당 글 열람은 관리자 승인이 필요합니다.");
            return false;
        }
        location.href = "/readVideo?videoNum=" + videoNum;
    }
</script>

</body>
</html>