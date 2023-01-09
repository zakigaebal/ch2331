<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2><spring:message code="pds.header.modify" /></h2>

<form:form modelAttribute="pds" action="modify" enctype="multipart/form-data">
	<form:hidden path="itemId" />
	
	<table>
		<tr>
			<td><spring:message code="pds.itemName" /></td>
			<td><form:input path="itemName" /></td>
			<td><form:errors path="itemName" class="error_message" /></td>
		</tr>
		<tr>
			<td><spring:message code="pds.itemFile" /></td>
			<td>
				<input type="file" id="inputFile">

				<div class="uploadedList"></div>
			</td>
			<td></td>
		</tr>
		<tr>
			<td><spring:message code="pds.itemDescription" /></td>
			<td><form:textarea path="description" /></td>
			<td><form:errors path="description" class="error_message" /></td>
		</tr>
	</table>
</form:form>

<div>
	<button type="submit" id="btnModify"><spring:message code="action.modify" /></button>
	<button type="submit" id="btnList"><spring:message code="action.list" /></button>
</div>

<script>
$(document).ready(function() {
	
	var formObj = $("#pds");

	$("#btnModify").on("click", function() {
		formObj.submit();
	});

	$("#btnList").on("click", function() {
		self.location = "list";
	});
  
	$(".uploadedList").on("click", "span", function(event){
		$(this).parent("div").remove();
	});
		
	function getOriginalName(fileName){
		var idx = fileName.indexOf("_") + 1;
		return fileName.substr(idx);
	}
	
	var itemId = ${pds.itemId};
	
	$.getJSON("/pds/getAttach/"+itemId,function(list){
		$(list).each(function(){
			
			console.log("data : " + this);
			
			var data = this;
			
			console.log("data : " + data);
			console.log("getOriginalName(data) : " + getOriginalName(data));
			//console.log("getImageLink(data) : " + getImageLink(data));
			
			var str = "<div><a href='/pds/downloadFile?fullName="+data+"'>" + getOriginalName(data)+"</a>"
				+ "<span data-src="+data+">X</span></div>";
			  
			  $(".uploadedList").append(str);
		});
	});
	
	$("#pds").submit(function(event){
		event.preventDefault();
		
		var that = $(this);
		
		var str ="";
		$(".uploadedList a").each(function(index){	
			 var value = $(this).attr("href");
			 value = value.substr(27);
		
			 str += "<input type='hidden' name='files["+index+"]' value='"+ value +"'> ";
		});
		
		that.append(str);

		that.get(0).submit();
	});
	
	$("#inputFile").on("change", function(event){
		var files = event.target.files;
		var file = files[0];

		console.log(file);
		
		var formData = new FormData();
		
		formData.append("file", file);
		
		$.ajax({
		  url: "/pds/uploadAjax?${_csrf.parameterName}=${_csrf.token}",
		  data: formData,
		  dataType:"text",
		  processData: false,
		  contentType: false,
		  type: "POST",
		  success: function(data){
			  var str = "<div><a href='/pds/downloadFile?fullName="+data+"'>" 
			  + getOriginalName(data)+"</a>"
			  +"<span data-src="+data+">X</span></div></div>";
			  
			  $(".uploadedList").append(str);
		  }
		});
	});
		
});
</script>
