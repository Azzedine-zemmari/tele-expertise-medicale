<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 13/10/2025
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>recherche</title>
</head>
<%--todo : fix the ui --%>
<body>
    <form method="post" action="${pageContext.request.contextPath}/rechercher-specialiste">
        <input placeholder="specialist" name="specialite" />
        <input placeholder="tarif" name="tarif" />
        <button type="submit"> submit </button>
    </form>
    <c:choose>
        <c:when test="${not empty specialistes}">
            <c:forEach var="r" items="${specialistes}">
                <p>${r.utilisateur.nom} ${r.utilisateur.prenom} ${r.specialiste}</p>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>Nothing</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
