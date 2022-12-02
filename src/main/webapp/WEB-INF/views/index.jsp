<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>컬럼형 사이트</title>
<style>
.page-navigation {
    text-align: center;
}
.checkbox-list {
    padding: 10px;
}
.checkbox-list label {
    font-weight: 400;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jspf" %>
<div class="body-wrap">
<section class="products section">
	<div class="container">
		<div class="row">
			<%@ include file="/WEB-INF/views/include/sidebar.jspf" %>
			<div class="col-md-9">
			    <hr><br>
				<div class="row">
				    <c:if test="${empty productList}">
				        <h3>검색 결과가 없습니다</h3>
				    </c:if>
				    <c:forEach items="${productList}" var="product">
                        <div class="col-md-4">
                            <div class="product-item" style="margin-bottom: 15px;">
                                <div class="product-thumbnail">
                                    <a href="/readProduct?productNum=${product.productNum}">
                                        <img class="img-responsive" src="${product.thumbnail}"/>
                                    </a>
                                </div>
                                <div class="product-content">
                                    <a href="/readProduct?productNum=${product.productNum}">${product.name}</a>
                                    <p class="price"><c:if test="${product.onDiscount == 1}"><span class="bage">할인중</span></c:if>
                                    ${product.price}원
                                        <a href="javascript:addCart(${product.productNum});">🛒</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
			</div>
		</div>
	</div>
</section>
</div>

<hr>

<div class="page-navigation">
    <c:if test="${page.prevPageSetPoint >= 1}">
        <a class="pull-left btn btn-theme"
        href="/?recentPage=${page.prevPageSetPoint}&sortType=${page.sortType}&keyword=${page.keyword}">
        이전</a>
    </c:if>
    <c:forEach var="countPage" begin="${page.pageBeginPoint}" end="${page.pageEndPoint}">
        <c:if test="${page.recentPage != countPage}">
            <a class="pull-center btn btn-theme"
            href="/?recentPage=${countPage}&sortType=${page.sortType}&keyword=${page.keyword}">
            ${countPage}</a>
        </c:if>
        <c:if test="${page.recentPage == countPage}">${countPage}</c:if>
    </c:forEach>
    <c:if test="${page.nextPageSetPoint <= page.totalPage}">
        <a class="pull-right btn btn-theme"
        href="/?recentPage=${page.nextPageSetPoint}&sortType=${page.sortType}&keyword=${page.keyword}">
        다음</a>
    </c:if>
</div>
<%@ include file="/WEB-INF/views/include/footer.jspf" %>

<script>
    //alert("js test 03");

    function comingSoon() {
        alert("업데이트 예정입니다.");
    }

    function clickFreeShipping() {
        let freeShippingBox = document.getElementById("freeShipping");
        if(freeShippingBox.checked) {
            location.href=
            "/?sortType=${page.sortType}&keyword=${page.keyword}&onDiscount=${page.onDiscount}&freeShipping=1";
        }else {
            location.href=
            "/?sortType=${page.sortType}&keyword=${page.keyword}&onDiscount=${page.onDiscount}&freeShipping=0";
        }
    }

    function clickOnDiscount() {
        let onDiscountBox = document.getElementById("onDiscount");
        if(onDiscountBox.checked) {
            location.href=
            "/?sortType=${page.sortType}&keyword=${page.keyword}&freeShipping=${page.freeShipping}&onDiscount=1";
        }else {
            location.href=
            "/?sortType=${page.sortType}&keyword=${page.keyword}&freeShipping=${page.freeShipping}&onDiscount=0";
        }
    }

    //쿠키 불러오기(무엇에 대한 쿠키인지 작성하기)
    function getCookie(name) {
        // alert("js test 쿠키몬스터");
        var obj = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
            var y = (x+obj.length);
            if ( document.cookie.substring( x, y ) == obj ) {
                if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                    endOfCookie = document.cookie.length;
                return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;

            if ( x == 0 ) break;
        }
        return "";
    }

    function addCart(productNum) {
        if(${member == null}) {
            alert("로그인이 필요합니다.");
            return false;
        };
        fetch("/addCart", {
            method: 'POST',
            headers: {"Content-Type" : "application/json"},
            body: JSON.stringify({
                productNum : productNum,
                id : "${member.id}",
                quantity : 1,
            })
        })
        .then((data) => alert("장바구니에 담았습니다."));
    }

</script>

</body>
</html>

