<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 09/10/2025
  Time: 23:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>creeConsultation</title>
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

    .form-header p {
      color: #666;
      font-size: 14px;
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
    }

    .form-group input:focus,
    .form-group select:focus {
      outline: none;
      border-color: #667eea;
      background: white;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px;
    }

    .checkbox-group {
      display: flex;
      align-items: center;
      margin-bottom: 25px;
    }

    .checkbox-group input[type="checkbox"] {
      width: 18px;
      height: 18px;
      margin-right: 10px;
      cursor: pointer;
    }

    .checkbox-group label {
      color: #666;
      font-size: 14px;
      cursor: pointer;
    }

    .checkbox-group a {
      color: #667eea;
      text-decoration: none;
    }

    .checkbox-group a:hover {
      text-decoration: underline;
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

    .form-footer {
      text-align: center;
      margin-top: 20px;
      color: #666;
      font-size: 14px;
    }

    .form-footer a {
      color: #667eea;
      text-decoration: none;
      font-weight: 600;
    }

    .form-footer a:hover {
      text-decoration: underline;
    }

    @media (max-width: 480px) {
      .form-row {
        grid-template-columns: 1fr;
      }

      .container {
        padding: 30px 20px;
      }
    }

  </style>
</head>
<body>
<div class="container">
  <div class="form-header">
    <h1>Consultation</h1>
    <hr/>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/">
    <div class="form-row">
      <div class="form-group">
        <label for="firstName">Generalist</label>
        <select name="generalist_id">
          <option selected disabled> choisi generalist</option>
          <c:forEach var="g" items="${generalists}">
            <option value="${g.id}">${g.utilisateur.nom} ${g.utilisateur.prenom}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="bloodType">Dossier Medical</label>
        <select name="dossier_medical_id">
          <c:forEach var="d" items="${dossierMedical}">
            <option value="${d.id}">${d.patient.nom} ${d.patient.prenom} ${d.bloodType}</option>
          </c:forEach>
        </select>
      </div>
    </div>

    <div class="form-group">
      <label for="date">date</label>
      <input type="date" id="date" name="date" required>
    </div>

    <div class="form-group">
      <label for="motif">motif</label>
      <input type="text" id="motif" name="motif" required>
    </div>

    <div class="form-group">
      <label for="diagnostique">diagnostique</label>
      <input type="text" id="diagnostique" name="diagnostique" required>
    </div>
    <div class="form-group">
      <label for="traitement">traitement</label>
      <input type="text" id="traitement" name="traitement" required>
    </div>
    <div class="form-group">
      <label for="count">count</label>
      <input type="text" id="count" name="count" required>
    </div>

    <button type="submit" class="submit-btn">Submit</button>
  </form>
</div>
</body>
</html>