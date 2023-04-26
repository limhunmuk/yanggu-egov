<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${!empty redirectUrl }">
		<c:choose>
			<c:when test="${!empty alertMsg }">
				<script>
					alert('${alertMsg}');
					location.replace ('${redirectUrl}');
				</script>
			</c:when>
			<c:otherwise>
				<script>
					location.replace ('${redirectUrl}');
				</script>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${!empty alertMsg }">
				<script>
					alert('${alertMsg}');
					history.back();
				</script>
			</c:when>
			<c:otherwise>
				<script>
					history.back();
				</script>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>