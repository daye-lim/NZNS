 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/menu.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/resources/js/menu.js"></script>
<style>
</style>
<form action="HouseListServlet" method="get" id="searchBar">
<div id=searchWrap>
	<input type="text" name="search" id="search" placeholder="삼산동, 달동, 신축 ...">
     	<button id="searchBtn">검색</button>
</div>

<div id=optionWrap>
	<ul id="filterList">
		<li class="filterOpt">방타입
			<ul class="sublist subListHide">
				<li class="subFilter">
					<div class="rangeWrap" >
						<input type="checkbox" name="rtype" class="filter" value="o">원룸<br>
						<input type="checkbox" name="rtype" class="filter" value="t">투룸<br>
						<input type="checkbox" name="rtype" class="filter" value="f">오피스텔<br>
						<input type="checkbox" name="rtype" class="filter" value="p">아파트<br>
					</div>
				</li>
			</ul>
		</li>
		<li class="filterOpt">월세/전세
			<ul class="sublist">
				<li class="subFilter">
					<div class="rangeWrap" >
						<input type="checkbox" name="rentType" class="filter" value="월세">월세<br>
						<input type="checkbox" name="rentType" class="filter" value="전세">전세<br>
					</div>
				</li>
			</ul>
		</li>
		<li class="filterOpt">가격대
			<ul class="sublist">
				<li class="subFilter">월세
					<select name="mrent" class="filter">
						<option value="선택해주세요">선택해주세요</option>
						<option value="mrent0~30">0만원~30만원</option>
						<option value="mrent30~60">30만원~60만원</option>
						<option value="mrent60~90">60만원~90만원</option>
						<option value="mrent90~120">90만~120만원</option>
						<option value="mrent120~999">120만원 이상</option>
					</select>
				</li>
				<li class="subFilter">보증금/전세가
					<div class="rangeWrap" >
						<input type="range" min=0 max=20000 step=100 value=10000 class="slider" id="myRange" >
						<span class="searchRange"></span>
						<div class="rangeLable">
							<span class="rangeValue startValue">0</span>
							<span class="rangeValue middleValue">1억</span>
							<span class="rangeValue endValue">무제한</span>
						</div>
					</div>
				</li>
			</ul>
		</li>
		<li class="filterOpt">관리비
			<ul class="sublist">
				<li class="subFilter">
					<div class="rangeWrap" >
						<input type="radio" name="util" class="filter" value="maintc0" >무관<br>
						<input type="radio" name="util" class="filter" value="maintc5">~5만원<br>
						<input type="radio" name="util" class="filter" value="maintc10">~10만원<br>
						<input type="radio" name="util" class="filter" value="maintc20">~20만원<br>
					</div>
				</li>
			</ul>
		</li>
		<li class="filterOpt" id="filterInitializer" style="background-color: grey;">필터 초기화</li>
	</ul>
</div>
</form>
<div style="clear:both;" id="test"></div>
