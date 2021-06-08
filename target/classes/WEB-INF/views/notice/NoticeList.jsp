<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<link rel="stylesheet" href="/resources/css/board.css">
 <%@ include file ="../includes/header.jsp" %>
<style>
 #getLogin{
	text-decoration: underline;
	color: red;
}
</style>
<div id="content">

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">공지사항</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        

                        <c:if test="${loginResult.adminCk == 1 }">
                            <button id='regBtn' type="button" class="btn btn-xs pull-right">글쓰기</button>
                        </c:if> 
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>글번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list}" var="notice">
                                	<tr>
                                		<td><c:out value="${notice.nno}" /></td>
                                		<td><a class="move" href='<c:out value="${notice.nno}" />'><c:out value="${notice.title}" />
                                		</a></td>
                                		<td><c:out value="${notice.writer}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.updateDate}" /></td>
                                	</tr>
                                </c:forEach>
                               
                            </table>
                            
                            <div class='row'>
                             <div class="col-lg-12">
                             
                              <form id='searchForm' action="/board/list" method='get'>
                               <select name='type'> 
                               <!-- 삼항연산자를 이용해서 해당 조건으로 검색되었다면 selected라는 문자열을 출력하게 하여 화면에서 선택한 항목으로 보이도록함 -->
                                <option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
                                 <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
                                 <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
                                 <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
                                 <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
                                 <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
                                 <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
                               </select>
                                <input type="text" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'  />
                                <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
                            	<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
                            	<button class='btn btn-default'>Search</button>
                              </form>
                             </div>
                            </div>
                            
                            
                            <!-- 페이지 처리  pageDTO = pageMaker -->
                            <div class='pull-right'>
                            <ul class="pagination">
                            	<c:if test="${pageMaker.prev}">
                            		<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a>
                            		</li>
                            	</c:if>
                            	
                            	<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
                            	<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} "><a href="${num}">${num}</a>
                            	</li>                            	
                            	</c:forEach>
                            	
                            	<c:if test="${pageMaker.next}">
                            		<li class="paginate_button next"><a href="${pageMaker.endPage +1 }">Next</a>
                            		</li>
                            	</c:if>
                            </ul>
                            </div>
                            
                            
                            <!-- URL의 이동을 처리하도록 변경
                            	검색 이후에 페이지 번호를 클릭해서 이동할 때에도 검색조건과 키워드가 유지되도록 같이 전달되도록 한다-->
                            <form id='actionForm' action="/notice/NoticeList" method="get">
                            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                            	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                            	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
                            	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
                            </form>
                            <!-- end Pagenation -->
                            
                                                 

                            
             				<!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">처리가완료되었습니다
                                         
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                        
                                        <div class="row"></div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

            
                         </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
</div>  

  

		<script type="text/javascript">
		$(document).ready(function(){
		
			/* Modal창 보여주는 작업 */
			var result = '<c:out value="${result}"/>';
			
			checkModal(result);
			
			history.replaceState({},null,null);
			
			function checkModal(result){
				
				if(result === '' || history.state){
					return;
				}
				
				if(parseInt(result) > 0){
					$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
				}
				
				$("#myModal").modal("show");
			}
			
			$("#regBtn").on("click",function(){
				
				self.location ="/notice/NoticeRegister";
			});
			
			
			/* 페이지번호클릭시 동작하게하는 작업 */
			// <form>태그 내 pageNum값은 href속성값으로 변경
			var actionForm = $("#actionForm");
			$(".paginate_button a").on("click",function(e){
				e.preventDefault();
				console.log("click");
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			
			/* 게시물 제목 클릭했을때 이동하도록 하는 작업 */
			// list.jsp 게시물 조회를 위한 이벤트 처리 추가
			// 게시물 제목 클릭 시 pageNum과 amount의 파라미터가 전달됨
			$(".move").on("click",function(e){
				
				e.preventDefault();
				actionForm.append("<input type='hidden' name='nno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/notice/NoticeGet");
				actionForm.submit();
			})
			
			
			/* 검색버튼의 이벤트처리 */
			// 브라우저에서 검색 버튼 클릭하면 <form>태그의 전송은 막고 페이지 번호는 1이 되도록 처리
			// 화면에서 키워드가 없다면 검색을 하지 않도록 제어
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e){
				
				if(!searchForm.find("option:selected").val()){
					alert("검색종류를 선택하세요");
					return false;
				}
				
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하세요");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchForm.submit();
			});
				
			

		});
		
		</script>
		
<%@include file="../includes/footer.jsp" %>