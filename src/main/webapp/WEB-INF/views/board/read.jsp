<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<h2><spring:message code="board.header.read" /></h2>

<form:form modelAttribute="board">
	<form:hidden path="boardNo" />

	<input type="hidden" name="page" value="${pgrq.page}">
	<input type="hidden" name="searchType" value="${pgrq.searchType}">
	<input type="hidden" name="keyword" value="${pgrq.keyword}">
	
	<table>
		<tr>
			<td><spring:message code="board.title" /></td>
			<td><form:input path="title" readonly="true" /></td>
			<td></td>
		</tr>
		<tr>
			<td><spring:message code="board.writer" /></td>
			<td><form:input path="writer" readonly="true" /></td>
			<td></td>
		</tr>
		<tr>
			<td><spring:message code="board.content" /></td>
			<td><form:textarea path="content" readonly="true" /></td>
			<td></td>
		</tr>
	</table>
</form:form>

<div>
	<sec:authentication property="principal" var="pinfo"/>

	<sec:authorize access="hasRole('ADMIN')">
		<button type="submit" id="btnRemove"><spring:message code="action.remove" /></button>
	</sec:authorize>

	<sec:authorize access="hasRole('MEMBER')">
       <c:if test="${pinfo.username eq board.writer}">
       	<button type="submit" id="btnEdit"><spring:message code="action.edit" /></button>
       	<button type="submit" id="btnRemove"><spring:message code="action.remove" /></button>
       </c:if>
	</sec:authorize>

	<button type="submit" id="btnList"><spring:message code="action.list" /></button>
</div>

<script>
	$(document).ready(function() {

		var formObj = $("#board");
		
		$("#btnEdit").on("click", function() {
			var boardNo = $("#boardNo");
			var boardNoVal = boardNo.val();
			
			self.location = "/board/modify${pgrq.toUriString()}" + "&boardNo=" + boardNoVal;
		});

		$("#btnRemove").on("click", function() {
			formObj.attr("action", "/board/remove");
			formObj.submit();
		});

		$("#btnList").on("click", function() {
			self.location = "/board/list${pgrq.toUriString()}";
		});

	});
</script>
