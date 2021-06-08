/**
 * reply.js에서는 Ajax 호출을 담당
 */


console.log("Reply Module....");


//replyService라는 객체의 내부에 add라는 메서드가 존재하는 형태
//replyService.add(객체, 콜백) 형태로 외부에서 호출 가능
var replyService = (function(){

	
	// Ajax를 이용해서 POST 방식으로 호출하는 코드 작성
	function add(reply, callback, error){ 
		// add() 파라미터로 callback과 error를 함수로 받을것임
		// Ajax호출이 성공하고, callback값으로 적절한 함수가 존재한다면 해당함수를 호출해서 결과를 반영한다. 
//js는 함수의 파라미터 개수를 일치시킬 필요가 없기 때문에 callback이나 error와 같은 파라미터를 필요에 따라 작성할수있음		
		
		console.log("add reply.........")
		
		$.ajax({
			// ajax의 메서드 옵션 종류
			type : 'post',	// 데이터 전송 방식
			url : '/replies/new',	// 서버 주소(Controller호출)
			data : JSON.stringify(reply),	
			//dataType : 서버에서 요청 받아올 데이터 타입 지정
			contentType : "application/json; charset=utf-8", // 서버로 전송시킬 데이터 타입 지정
			// 데이터 전송 타입 : "application/json; charset=utf-8" 방식으로 전송
			
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				} // Ajax로 통신이 정상적으로 이루어졌으면 함수를 실행
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}// 통신에 문제가 발생했을 때 함수를 실행(error)
			}
			
		})
	}
	
	

	function getList(param,callback,error){
		// getList() = param이라는 객체를 통해서 필요한 파라미터를 전달받아 JSON 목록을 호출하는 함수
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
				// json 형태가 필요하므로 URL 호출 시 확장자를 .json으로 요구
				
			function(data){
			if (callback){
			//	callback(data); 댓글 목록만  가져오는 경우
				callback(data.replyCnt,data.list); // 댓글 숫자와 목록을 가져오는 경우
				// replyCnt = 해당 게시물의 댓글 수
				// list = 페이지에 해당하는 댓글 데이터
// Ajax로 가져오는 데이터가 replyCnt와 list라는 데이터로 구성되므로 이를 처리하는 reply.js 의 구조를 replyCnt와 list데이터를 처리하는 구조로 수정한다.
			}
		}).fail(function(xhr, status, err){
			if (error){
				error();
			}
		});
	}
	
	function remove(rno, callback, error){
		// DELETE방식을 통해 해당 URL을 호출하여 댓글 삭제

		$.ajax({	// $.ajax()를 이용해서 구체적으로 type속성을 'delete'로 지정
			type : 'delete',
			url : '/replies/' + rno,
			
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}

	
	function update(reply, callback, error){
	//댓글 수정 수정하는 내용과 함께 댓글 번호 전송 댓글 내용은 JSON형태로 전송
		console.log("RNO: " + reply.rno);
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; cahrset=utf-8",
			// 데이터 전송 타입 : "application/json; charset=utf-8" 방식으로 전송
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(rno, callback, error){
		// 댓글 조회 처리. 특정 번호의 댓글 조회는 GET 방식으로 동작한다
		
		$.get("/replies/" + rno + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
		
	}
	
	// 댓글목록의 시간(날짜)에 대한 처리
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, 
				':', (ss > 9 ? '' : '0') + ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd].join('');
		}
	};
	
		
		return {
			add : add,
			get : get,
			getList : getList,
			remove : remove,
			update : update,
			displayTime : displayTime
			
		};
		
	
	
	
})(); 