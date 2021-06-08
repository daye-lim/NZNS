<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<link rel="stylesheet" href="/resources/css/board.css">
 <%@ include file ="../includes/header.jsp" %>
 <style>
 #getLogin{
	text-decoration: underline;
	color: red;
}

#replyList{
position:relative;
right:600px;
font-size:15px;
font-weight:900;
color:#369;}
</style>
<div id="content">

            <div class="row">
                <div class="col-lg-12">
                     <h1 class="page-header">게시글 조회페이지</h1>                    
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    
                        <div class="panel-heading"></div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        


  					<table width="80%"  id="mtable" class="table table-striped table-bordered table-hover">
 						 
 						 <thead>
 						  			<tr>
                                        <th><label> Bno</label></th>
                                        <td><input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly"></td>
                                    </tr>
                                    <tr>
                                        <th><label> Title</label></th>
                                        <td><input class="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly"></td>
                                    </tr>
                                    <tr>
                                        <th><label>Text area</label></th>
                                        <td><textarea cols="100" rows="20" class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content }"/></textarea></td>
                                    </tr>
                                    <tr>
                                        <th><label>Recommend</label></th>
                                        <td> <input class="form-control" name='recommend' value='<c:out value="${board.recommend }"/>' readonly="readonly"></td>
                                    </tr>
                                    <tr>
                                        <th><label>Writer</label></th>
                                        <td> <input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly"></td>
                                    </tr>

                                    
                                    <tr>
                                        <th colspan="2">
                                        <div class="regBtn">
                                     <!-- 로그인이 되어있고 본인 id인 경우에만 수정할 수 있도록 버튼을 출력 -->
                                    <c:if test = "${loginResult.id == board.writer}">
                                        <button data-oper='modify' class="btn btn-default" 
                                        onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">수정하기</button>
                                    </c:if>
                        				<button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">글목록</button>
                        				
                        				
                        				
                        				
                        				
                        	 <!-- 로그인이 되어있고, 본인 글이 아닐경우에만 추천할 수 있도록 버튼을 출력 -->
                        			 <c:if test = "${loginResult.id != null and loginResult.id != board.writer}">
<%-- 										    or sessionScope.navername != null and sessionScope.navername != dto.user_id --%>
<%-- 										    or sessionScope.kakaonickname != null and sessionScope.kakaonickname != dto.user_id --%>
<%-- 										    or sessionScope.facebookname != null and sessionScope.facebookname != dto.user_id --%>
										            
										<button type = "button" id = "recBtn" class="btn btn-danger">추천하기</button>
										    
									</c:if>
 										</div>
 										</th>
                                    </tr>
                           </thead>
                     </table>   	
                        	
                        	
                        	
                        	
                        	<!-- list버튼 클릭 시  페이지 번호 유지하며 다시 목록페이지로 이동. -->
                        	<!-- 버튼을 클릭하면 <form>태그를 이용하는 방식
                        		필요한 데이터들을 추가해서 이동하도록 설정 -->
                        	<!-- cri라는 이름으로 전달된 Criteria 객체를 이용해서 pageNum과 amount값을 태그로 구성하고 
                        	버튼을 클릭했을 때 정상적으로 목록페이지로 이동하게 처리한다. -->
                        	<form id='operForm' action="/board/modify" method="get">
                        		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
                        		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        	</form><!-- 브라우저에서는 form태그의 내용은 보이지 않고 버튼만 보이게 된다 -->
              </div>
		   <!-- end panel-body -->
		  </div>
		  <!-- end panel-body -->
		 </div>
		 <!-- end panel -->
		</div>
		<!-- /.row -->
                        	
                        	
      <!-- 첨부파일 영역 -->
            <div class='bigPictureWrapper'>
             <div class='bigPicture'><!-- 첨부파일 원본 이미지를 보여주는 부분 -->
             </div>
            </div>



		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">		  
					<div class="panel-heading">Files</div>		
						<div class="panel-body">
		   					<div class='uploadResult'> <!-- 크게 첨부파일 목록을 보여주는 부분 -->
		  					    <ul>
		     					</ul>
		  					</div>
						</div>
				</div>
			</div>
		</div>


            
            
                        	<!-- 댓글목록처리 -->
                        	<div class='row'>
                        	<div class="col-lg-12">
                        	<div class="panel panel-default">
                        	<div class="panel-heading">
                        	   <i class="fa fa-comments fa-fw" id="replyList">댓글목록</i>
                        	   <c:if test = "${loginResult.id != null}">
                        	   <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글쓰기</button>
                        	   </c:if>
                        	   
                        	   <c:if test = "${loginResult == null}">
                          	댓글쓰기는 <a id="getLogin" href="/member/loginpage">로그인</a>이 필요한 서비스입니다. 
                        	   </c:if>
                        	</div>
                        	
                        	
                        	
                        	<div class="panel-body">
                        	
                               <ul class="chat">
                        	<!-- start reply -->
                        	   <li class="left clearfix" data-rno='12'>
                        	<div>
                        	<div class="header">
                        	   <strong class="primary-font">user00</strong>
                        	   <small class="pull-right text-muted">2021-04-19 11:16</small>
                        	</div>
                        	   <p>Good job!</p>
                        	</div>
                        	   </li>
                        	<!-- edn reply -->
                           	   </ul>
                        	<!-- end ul -->
                        	</div>
                        	<!-- panel.chat-panel -->
                        	<div class="panel-footer"></div>
                        	</div>
                        	</div>
                        	<!-- end row -->
                        	</div>
</div>



                        	
                        	
                        	

                        	        


		
<!-- Modal 
         	   브라우저에서 댓글에 대한 CRUD 작업에서 활용할 것이므로 필요한 모든 내용을 담도록 하고 각 작업에 맞게 버튼이나 입력창이 보이거나 감춰지도록 한다-->
           <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                      </div>
                   <div class="modal-body">
                   
                   <div class="form-group">
                   	<label>Reply</label>
                   	<input class="form-control" name='reply' value='New RePly!!!!'>
                   </div>
                    <div class="form-group">
                   	<label>Replyer</label>
                   	<input class="form-control" name='replyer' value='${loginResult.id}'>
                   </div> <div class="form-group">
                   	<label>Reply Date</label>
                   	<input class="form-control" name='replyDate' value=''>
                   </div>
                   
                </div>          
              	   <div class="modal-footer">
                     <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                     <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                      <button id='modalRegisterBtn' type="button" class="btn btn-primary" data-dismiss="modal">Register</button>
                     <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
               </div>
    		<!-- /.modal-content -->
          </div>
             <!-- /.modal-dialog -->
            </div>
          <!-- /.modal -->
          
          
          
            
<!-- p.265 -->
 <script type="text/javascript">
 	$(document).ready(function(){
 		var operForm = $("#operForm");
 		$("button[data-oper='modify']").on("click",function(e){
 			operForm.attr("action","/board/modify").submit();
 		});
 		
 		$("button[data-oper='list']").on("click", function(e){
 			operForm.find("#bno").remove();
 			operForm.attr("action","/board/list")
 			operForm.submit();
 		});
 	});
 </script>
 
  <!-- p.400 모듈 구성하기 -->
 <script type="text/javascript" src="/resources/js/reply.js"></script>
 <script type="text/javascript">
 
 $(document).ready(function(){
	 console.log(replyService);
 });
 </script> 
 
 <!-- p.404  -->
 
 <script>
 	console.log("===================");
 	console.log("JS TEST");
 	
 	var bnoValue = '<c:out value="${board.bno}"/>';

 	
 	//p.413 댓글 조회 처리
 	replyService.get(10, function(data){
 		console.log(data);
 	});
 	
 </script>
 
 
 <!-- p.415~416 댓글 목록 이벤트 처리 -->
 <script>
	$(document).ready(function(){
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
			showList(1);
			
			function showList(page){
				console.log("show list " + page);
				replyService.getList({bno:bnoValue,page: page|| 1}, 
			function(replyCnt, list){
					
					console.log("replyCnt : " + replyCnt);
					console.log("list: " + list);
					console.log("list");
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
						
					}
					
					var str="";
					
				if(list == null || list.length == 0){
				
					return;
				}
				
				for (var i = 0, len = list.length || 0; i < len; i++){
					str +="<li class='left clearfix' data-rno='"+ list[i].rno+"'>";
					str +="	<div><div class='header'><strong class='primary-font'>[" + list[i].rno+"] "+list[i].replyer+"</strong>";
					//													p.418 replyService.displayTime 추가
					str +="		<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate)+"</small></div>";
					str +="			<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
				
				showReplyPage(replyCnt); //p.441 
					}); //end function
				
			} //end showList
				
			//p.421 새로운 댓글의 추가 버튼 이벤트 처리
				
				var modal = $(".modal");
				var modalInputReply = modal.find("input[name='reply']");
				var modalInputReplyer = modal.find("input[name='replyer']");
				var modalInputReplyDate = modal.find("input[name='replyDate']");
				
				var modalModBtn = $("#modalModBtn");
				var modalRemoveBtn = $("#modalRemoveBtn");
				var modalRegisterBtn = $("#modalRegisterBtn");
				
				$("#addReplyBtn").on("click", function(e){
					modal.find("input").val("");
					modalInputReplyDate.closest("div").hide();
					modal.find("button[id !='modalCloseBtn']").hide();
					
					modalRegisterBtn.show();
					
					$(".modal").modal("show");
				});
				
				
			//p.423 새로운 댓글 추가 처리
			
			modalRegisterBtn.on("click", function(e){//댓글쓰기
				
				var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno:bnoValue //p.404
					};
			
				replyService.add(reply,function(result){//p.403
					
					alert(result);
				
					modal.find("input").val("");
					modal.modal("hide");
					
					//p.424 댓글 목록 갱신 
					//showList(1);
					showList(-1);
					
					});
				
			}); //end modalRegisterBtn
			
			// 댓글 조회 클릭 이벤트 처리
			
			$(".chat").on("click", "li", function(e){
			
				var rno = $(this).data("rno");
				
				replyService.get(rno, function(reply){
					
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
					.attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id !='modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$(".modal").modal("show");

				}); //end replyService.get
			});
			
			modalModBtn.on("click", function(e){
				
				var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
				
				replyService.update(reply, function(result){
					
					alert(result);
					modal.modal("hide");
					showList(pageNum); //p.442 댓글 수정
				});
			}); // end modalModBtn
			
			//p.427 댓글 삭제
			
			modalRemoveBtn.on("click", function(e){
				var rno = modal.data("rno");
				
				replyService.remove(rno, function(result){
					
					alert(result);
					modal.modal("hide");
					showList(pageNum); //p.442 댓글삭제
				});
			}); //end modalRemoveBtn
			
			//p.440
			
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			
			function showReplyPage(replyCnt){
				
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum !=1;
				var next = false;
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt/10.0);
				}
				
				if(endNum * 10 < replyCnt){
					next = true;
				}
				
				var str = "<ul class='pagination pull-right'>";
				
				if(prev){
					str+= "<li class='page-item'><a class='age-link' hrdf='"+(startNum -1)+"'>previous</a></li>";
				}
				
				
				for (var i = startNum ; i <= endNum; i++){
					var active = pageNum == i? "active":"";
					
					str+="<li class='page-item " +active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				}
				
				if(next){
					str+="<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
				}
				
				str += "</ul></div>";
				
				console.log(str);
				
				replyPageFooter.html(str);
			} //p.440 showReplyPage 끝
				
				
			//p.441 페이지 번호 클릭했을때 새로운 댓글을 가져오도록하는 작업
			replyPageFooter.on("click", "li a", function(e){
				e.preventDefault();
				console.log("page click");
				
				var targetPageNum = $(this).attr("href");
				
				console.log("targetPageNum: " + targetPageNum);
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			}); //end replyPageFooter
			
			//p.571 게시물 조회 화면의 처리
			$(document).ready(function(){
				(function(){
					var bno = '<c:out value="${board.bno}"/>';
					
					$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
						
						console.log(arr);
						
						//p.574 첨부파일 보여주기
						var str = "";
						
						$(arr).each(function(i, attach){
							
							//image type
							if(attach.fileType){
								var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
								
								str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
								str += "<img src='/display?fileName="+fileCallPath+"'>";
								str += "</div>";
								str + "</li>";
							} else {
								
								str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
								str += "<span> "+ attach.fileName+"</span><br/>";
								str += "<img src='/resources/img/attach.png'>";
								str += "</div>";
								str + "</li>"
							}
						});
						
						$(".uploadResult ul").html(str);
						
					}); //end getjson
					
				})(); //end function
				
			});
		
			//p.575 첨부파일 클릭시 이벤트 처리
		$(".uploadResult").on("click","li", function(e){
			
			console.log("view image");
			//p.575 첨부파일 클릭 시 이벤트 처리
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g), "/"));
			// showImage() = 해당경로의 이미지를 보여주는 역할을 한다
			}else{
				//downliad
				self.location ="/download?fileName="+path
			}
			
		});
			function showImage(fileCallPath){
				
				alert(fileCallPath);
				
				$(".bigPictureWrapper").css("display","flex").show();
				
				$(".bigPicture")
					.html("<img src='/display?fileName="+fileCallPath+"'>")
					.animate({width:'100%', height: '100%'},1000);
			}
			
			//p.577 원본 이미지 창 닫기
			$(".bigPictureWrapper").on("click", function(e){
				
				$(".bigPicture")
					.animate({width:'0%', height:'0%'}, 1000);
					setTimeout(function(){
						$('.bigPictureWrapper').hide();
					},1000);
			})
		
			
			});//end script
		
</script>
<script>
 // 게시글 추천하기

	$(document).ready(function(){
 		var operForm = $("#operForm");
 		$("#recBtn").on("click",function(e){
 			operForm.attr("action","/board/recommend").submit();

 	        alert("해당 글을 추천하였습니다.")
 	        
 		});
 	});

</script>

 <%@include file="../includes/footer.jsp" %>
