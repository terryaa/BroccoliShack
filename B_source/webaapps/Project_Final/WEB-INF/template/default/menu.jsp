<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul>
	<li><a href="./">Home</a></li>
	<c:choose>
		<c:when test="${empty sessionScope.uid}">
			<li><a href="loginform">로그인</a></li>
			<li><a href="member">회원가입</a></li>
		</c:when>
		<c:otherwise>
			<li>${sessionScope.uname}님 <a href="logout">로그아웃</a></li>
			<li><a href="mypage">마이페이지</a></li>
		</c:otherwise>
	</c:choose>
	<li><a href="write">게시판</a></li>
	<li><a href="urlform">UI 적용 예제 2</a></li>
	<li><a href="ckeditor">CkEditor</a></li>
	<li><a href="txf">트랜젝션 예제</a></li>

</ul>