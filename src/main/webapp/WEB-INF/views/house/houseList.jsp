+<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="resources/css/houseList.css">
<c:set var="list" value="${pagingMap.list}"/>
<h1>조건에 맞는 방 <span id="noOfHouse"> ${pagingMap.totalPage}</span>건</h1>
<table id="outerTable">
	<tr>
		<td>
			<c:forEach var="house" items="${list}">
				<table id="innerTable">
					<tr>
						<td class="img"><img src="#" alt="${house.HCODE}" width="300" height="300"/></td>
					</tr>
					<tr> 
						<td class="greyText">
						<c:choose>
							<c:when  test="${house.HTYPE == 'o'}">
								원룸 
							</c:when>
							<c:when  test="${house.HTYPE == 't'}">
								<td colspan="3">투룸 </td>
							</c:when>
							<c:when  test="${house.HTYPE == 'f'}">
								<td colspan="3">오피스텔 </td>
							</c:when>
							<c:when  test="${house.HTYPE == 'p'}">
								<td colspan="3">아파트 </td>
							</c:when>
						</c:choose>
						</td>
 					</tr>
					<tr>
						<td style="padding: 6px 0 6px 0;"><font size=5><b>${house.RTYPE} ${house.DEPOSIT} / ${house.MRENT}</b></font></td>
					</tr>
 					<tr>
						<td class="greyText">
							<span>${house.AREA},</span>
							<span>관리비 ${house.MAINTC}</span>
						</td>
					</tr>
					<tr> <td class="greyText"><p class="hetc">${house.HETC}</p></td> </tr>
				</table>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<td id="pages">
			<c:choose>
				<c:when test="${fn:length(list) == 0}"><!-- 검색 결과가 0건일때  -->
					검색 결과가 없습니다 :(
				</c:when>
				<c:otherwise><!-- 검색 결과가 0건이 아닐때  -->
					<c:set var="repeat" value="${pagingMap.totalPage/pagingMap.perPage}"/>
					<c:forEach var="i" begin="1" end="${fn:substring(repeat, 0, fn:indexOf(repeat, '.')) +1}">
						<c:choose>
							<c:when test="${i == (pagingMap.curPage)}">
								<a>${i}</a>
							</c:when>
							<c:otherwise>
								<a href="HouseListServlet?curPage=${i}&search=${search}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>