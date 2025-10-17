<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 17/10/2025
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${param.success == 'true'}">
    <p style="color: green;">Avis ajouté avec succès ✅</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/CreationAvis">
<select name="demandeExpertise" id="demandeExpertise">
<c:forEach var="d" items="${demandeExpertiseList}">
    <option value="${d.id}">${d.question}</option>
</c:forEach>
</select>
    <input name="avis" type="text" />
    <button type="submit">Submit</button>
</form>
</body>
</html>
