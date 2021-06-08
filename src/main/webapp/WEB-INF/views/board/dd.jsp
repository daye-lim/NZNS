<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

 
  <style>
    #container {
      width: 70%;
      margin: 0 auto;     /* 가로로 중앙에 배치 */
      padding-top: 10%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
     
    #list {
      text-align: center;
    }
   
    #write {
      text-align: right;
    }
     
    /* Bootstrap 수정 */
    .table > thead {
      background-color: #b3c6ff;
    }
    .table > thead > tr > th {
      text-align: center;
    }
    .table-hover > tbody > tr:hover {
      background-color: #e6ecff;
    }
    .table > tbody > tr > td {
      text-align: center;
    }
    .table > tbody > tr > #title {
      text-align: left;
    }
     
    div > #paging {
      text-align: center;
    }
     
    .hit {
      animation-name: blink;
      animation-duration: 1.5s;
      animation-timing-function: ease;
      animation-iteration-count: infinite;
      /* 위 속성들을 한 줄로 표기하기 */
      /* -webkit-animation: blink 1.5s ease infinite; */
    }
     
    /* 애니메이션 지점 설정하기 */
    /* 익스플로러 10 이상, 최신 모던 브라우저에서 지원 */
    @keyframes blink {
      from {color: white;}
      30% {color: yellow;}
      to {color: red; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }
  </style>
 
 


 <script>
//게시판 목록 페이지로 이동하게 하는 함수
function list(page){
    console.log("페이지를 이동합니다.");
    location.href="list.do?curPage="+page;
};
 
</script>

    
 
 
<center>
<div id = "list">
<b>베스트 게시물 게시판</b>
</div>
 
<div>
<!-- 해당 table 클래스는 마우스를 올려놓았을때 게시글의 색깔이 파란색으로 변하도록 하는 클래스 -->
<table class="table table-striped table table-hover">
<center>
<thead>
    <tr>
    <!-- width옆에 %는 테이블에서 차지할 비율을 나타낸것 -->
        <th width="20%"><span style="color: green; font-weight: bold;">추천수 순위</span></th>
        <th width="10%">게시글 번호</th>
        <th width="15%">제목</th>
        <th width="15%">작성자</th>
        <th width="15%">내용</th>
        <th width="15%">날짜</th>
        <th width="5%">조회수</th>
        <th width="5%">추천수</th>
    </tr>
    </thead>
    <tbody>
        
    <!-- forEach var = "개별데이터" items = "집합데이터" -->
    <c:forEach var = "row" items = "${map.list}" varStatus="status"> <!-- 컨트롤러에서 map안에 list를 넣었기 때문에 이렇게 받는다. -->
    <tr>
    
        <td>
        <center>
        <!-- hit를 사용해서 추천수 상위 1~3위 까지는 순위 애니메이션이 출력되도록 함 -->
        <c:if test="${row.rk <= 3 }">
            <span class = "hit" size = "7">${row.rk}위!!</span>
        </c:if>
        
        
        <!-- hit를 사용해서 추천수 상위 1~3위 까지는 이달의 추천글 애니메이션이 출력되도록 함 -->
        <c:if test="${row.rk >= 4 }">
            <span class = "hit" size = "4">이달의 추천글!!</span>
        </c:if>
        
        </font>
        </center>
        </td>    <!-- 게시글 순위 -->
        
        
        <td><center>${row.member_bno}</center></td>    <!-- 글번호 -->
        <!-- 클릭하면 컨트롤러의 view.do로 이동하고, 게시물번호, 페이지 번호, 검색옵션, 키워드를 같이 넘긴다 -->
        
        <!-- 조회수가 50이 넘는 글은 제목옆에 hit라는 애니메이션이 출력되도록 함 -->
    <td id ="title">
        <a href="best_board_view.do?member_bno=${row.member_bno}">${row.title}</a>
        <c:if test="${row.viewcnt >= 50 }">
            <span class = "hit">hit!!</span>
        </c:if>
</td>
 
        <td>${row.user_id}</td>    <!-- 작성자의 이름 -->
        <td>${row.content}</td>    <!-- 글의내용 -->
        <td>${row.reg_date}</td>    <!-- 날짜의 출력형식을 변경함 -->
        <td><center>${row.viewcnt}</center></td>    <!-- 조회수 -->
        <td><center>${row.recommend}</center></td>    <!-- 추천수 -->
 
 
    
    </tr>
    </c:forEach>
    </tbody>
 
</table>
</div>
 
<form name="form1" method="post" action="list.do">
    <select name="search_option">
        <option value="user_id"
<c:if test="${map.search_option == 'user_id'}">selected</c:if>
        >작성자</option>
        <option value="title" 
<c:if test="${map.search_option == 'title'}">selected</c:if>
        >제목</option>
        <option value="content" 
<c:if test="${map.search_option == 'content'}">selected</c:if>
        >내용</option>
        <option value="all" 
<c:if test="${map.search_option == 'all'}">selected</c:if>
        >작성자+내용+제목</option>
    </select>
    <input name="keyword" value="${map.keyword}">
    <input type="submit" value="조회">
   
</form>
 
 
 
 
</center>


