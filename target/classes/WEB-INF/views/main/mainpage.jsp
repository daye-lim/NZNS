<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>

<link rel="stylesheet" href="/resources/css/main.css">
<%@include file="../includes/header.jsp" %>
<style>

table#mtable {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 3px solid #369;
  margin : 20px 10px;
}
table#mtable th {
  width: 147px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #153d73;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
table#mtable td {
  width: 349px;
  padding: 10px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
</style>

<div class="map">
	<h1>부동산 위치 찾기</h1>
	<%@include file="../includes/findAgent.jsp" %>
</div>


<div class="reviews">
	<h1>Best Reviews</h1>

                            <table id="mtable" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>글번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>추천수</th>

                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}" /></td>
                                		<td><a class="move" href='<c:out value="${board.bno}" />'><c:out value="${board.title}" />
                                		<b>[ <c:out value="${board.replyCnt}" />]</b></a></td>
                                		<td><c:out value="${board.writer}" /></td>
                                		<td><c:out value="${board.recommend}" /></td>

                                	</tr>
                                </c:forEach>
                               
                            </table>
                           <form id='actionForm' action="/board/list" method="get">
                            </form>

</div>


<div class="content">
	<h1>오늘의 뉴스</h1>
		<ul>
			<li><a class="nav-link"
					href="https://news.naver.com/main/read.nhn?mode=LS2D&mid=shm&sid1=101&sid2=260&oid=028&aid=0002546548" target="_blank">
					전월세신고 어떻게?…6월1일 시행 임대차신고제 총정리</a></li>
			<li><a class="nav-link"
					href="https://www.yna.co.kr/view/AKR20210531004700057?input=1195m" target="_blank">
					울산 개별공시지가 8.5% 상승…</a></li>
			<li><a class="nav-link"
					href="https://news.naver.com/main/read.nhn?mode=LS2D&mid=shm&sid1=101&sid2=260&oid=629&aid=0000086098" target="_blank">
					전국 미분양 주택 22개월 만에 증가…전월比 3.5%↑</a></li>
			<li><a class="nav-link"
					href="http://www.busan.com/view/busan/view.php?code=2021052710351004720" target="_blank">
					울산 범서읍 사연리 일원 5년간 토지거래허가구역 지정</a></li>
		</ul>
</div>

<div class="content">
	<h1>주요사이트 바로가기</h1>
	<ul>			
	
			<li><a class="nav-link"
					href="http://rt.molit.go.kr/" target="_blank">
					국토교통부 실거래가 공개시스템</a></li>
			<li><a class="nav-link"
					href="http://www.khug.or.kr/index.jsp" target="_blank">
					HUG 주택도시보증공사</a></li>
			<li><a class="nav-link"
					href="https://kras.go.kr:444/cmmmain/goMainPage.do" target="_blank">
					일사편리 부동산 통합민원</a></li>
			<li><a class="nav-link"
					href="https://seereal.lh.or.kr/main.do" target="_blank">
					씨:리얼 (SEE:REAL) 한국토지주택공사운영 부동산 정보 포털사이트</a></li>
			<li><a class="nav-link"
					href="https://land.naver.com/" target="_blank">
					네이버 부동산</a></li>
		</ul>
</div>
<!-- 여기까지 main.jsp -->


<%@include file="../includes/footer.jsp" %>




		<script type="text/javascript">
		$(document).ready(function(){

			var actionForm = $("#actionForm");


			$(".move").on("click",function(e){
				
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/board/get");
				actionForm.submit();
			})
			
			

			

		});
		
		</script>