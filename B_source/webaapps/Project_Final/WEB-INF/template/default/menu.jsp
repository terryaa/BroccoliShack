<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul>
	<li><a href="./">Home</a></li>
	<c:choose>
		<c:when test="${empty sessionScope.uid}">
			<li><a href="loginform">�α���</a></li>
			<li><a href="member">ȸ������</a></li>
		</c:when>
		<c:otherwise>
			<li>${sessionScope.uname}�� <a href="logout">�α׾ƿ�</a></li>
			<li><a href="mypage">����������</a></li>
		</c:otherwise>
	</c:choose>
	<li><a href="write">�Խ���</a></li>
	<li><a href="urlform">UI ���� ���� 2</a></li>
	<li><a href="ckeditor">CkEditor</a></li>
	<li><a href="txf">Ʈ������ ����</a></li>

</ul>