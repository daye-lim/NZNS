<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="uploadFormAction" method="post" enctype="multipart/form-data">
 
 <input type="file" name="uploadFile" multiple>
 <!-- multiple = 하나의 input태그로 한꺼번에 여러개의 파일 업로드 가능 -->
 <button>Submit</button>
 
</form>
</body>
</html>