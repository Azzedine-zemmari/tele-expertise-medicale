<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 10/10/2025
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>cree act medical</title>
</head>
<body>

<div class="container">
  <div class="form-header">
    <h1>Login</h1>
    <hr/>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/actmedical">
    <div class="form-group">
      <label for="email">Consultation : </label>
      <select name="consultation">
        <option disabled selected>Choisi consultation</option>
        <c:forEach var="c" items="${consultations}">
          <option value="${c.id}">${c.generalist.utilisateur.nom}${c.dossierMedical.bloodType}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="email">count : </label>
      <input type="text" name="count"/>
     </div>
    <div class="form-group">
      <label for="actmedical">Act medical : (multiple choix)</label>
      <select name="actmedical" multiple>
      <c:forEach var="a" items="${actTypes}">
        <option value="${a}">${a}</option>
      </c:forEach>
      </select>
    </div>
    <button type="submit" class="submit-btn">Submit</button>
  </form>
</div>
</body>

</body>
</html>
