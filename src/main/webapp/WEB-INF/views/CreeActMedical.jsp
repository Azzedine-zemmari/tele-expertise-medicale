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
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .container {
      background: white;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      max-width: 500px;
      width: 100%;
      padding: 40px;
    }

    .form-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .form-header h1 {
      color: #333;
      font-size: 28px;
      margin-bottom: 10px;
    }

    .form-header hr {
      border: none;
      border-top: 2px solid #e0e0e0;
      margin-top: 15px;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 600;
      font-size: 14px;
    }

    .form-group input,
    .form-group select {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 14px;
      transition: all 0.3s ease;
      background: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .form-group select[multiple] {
      min-height: 150px;
      padding: 8px;
    }

    .form-group select[multiple] option {
      padding: 8px 12px;
      margin-bottom: 4px;
      border-radius: 4px;
      cursor: pointer;
    }

    .form-group select[multiple] option:hover {
      background: #667eea;
      color: white;
    }

    .form-group select[multiple] option:checked {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }

    .form-group input:focus,
    .form-group select:focus {
      outline: none;
      border-color: #667eea;
      background: white;
    }

    .submit-btn {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    .multi-select-hint {
      font-size: 12px;
      color: #666;
      margin-top: 5px;
      font-style: italic;
    }

    @media (max-width: 480px) {
      .container {
        padding: 30px 20px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="form-header">
    <h1>Acte Médical</h1>
    <hr/>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/actmedical">
    <div class="form-group">
      <label for="consultation">Consultation</label>
      <select name="consultation" id="consultation">
        <option disabled selected>Choisi consultation</option>
        <c:forEach var="c" items="${consultations}">
          <option value="${c.id}">${c.generalist.utilisateur.nom} ${c.dossierMedical.bloodType}</option>
        </c:forEach>
      </select>
    </div>

    <div class="form-group">
      <label for="count">Count</label>
      <input type="text" id="count" name="count" required/>
    </div>

    <div class="form-group">
      <label for="actmedical">Acte Médical (choix multiples)</label>
      <select name="actmedical" id="actmedical" multiple>
        <c:forEach var="a" items="${actTypes}">
          <option value="${a}">${a}</option>
        </c:forEach>
      </select>
      <div class="multi-select-hint">Maintenez Ctrl (Windows) ou Cmd (Mac) pour sélectionner plusieurs options</div>
    </div>

    <button type="submit" class="submit-btn">Submit</button>
  </form>
</div>

</body>
</html>