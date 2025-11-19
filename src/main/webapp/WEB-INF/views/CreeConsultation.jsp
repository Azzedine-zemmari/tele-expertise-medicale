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
      max-width: 600px;
      width: 100%;
      padding: 40px;
      max-height: 90vh;
      display: flex;
      flex-direction: column;
    }

    .form-content {
      overflow-y: auto;
      overflow-x: hidden;
      padding-right: 10px;
    }

    .form-content::-webkit-scrollbar {
      width: 8px;
    }

    .form-content::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    .form-content::-webkit-scrollbar-thumb {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 10px;
    }

    .form-content::-webkit-scrollbar-thumb:hover {
      background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
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

    /* Added form sections for better organization */
    .form-section {
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 1px solid #e0e0e0;
    }

    .form-section:last-of-type {
      border-bottom: none;
    }

    .section-title {
      color: #667eea;
      font-size: 14px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 15px;
    }

    .form-group {
      margin-bottom: 20px;
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

    /* Improved button styling with clear visual hierarchy */
    .button-group {
      display: flex;
      gap: 12px;
      margin-top: 30px;
    }

    .submit-btn {
      flex: 1;
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

    /* Secondary button with outline style for "Avis exper" */
    .submit-btn.secondary {
      background: white;
      color: #667eea;
      border: 2px solid #667eea;
      box-shadow: none;
    }

    .submit-btn.secondary:hover {
      background: #f8f9fa;
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
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

      .button-group {
        flex-direction: column;
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

  <div class="form-content">
    <form method="post" action="${pageContext.request.contextPath}/CreeConsultation">
      <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

      <!-- Hidden dossier medical field -->
      <div class="form-group" style="display: none">
        <label for="bloodType">Dossier Medical</label>
        <input name="dossier_medical_id"  value="${dossier_medical.id}" />
      </div>

      <!-- Organized into sections for better modularity -->
      <div class="form-section">
        <div class="section-title">Informations Générales</div>
        <div class="form-group">
          <label for="date">Date</label>
          <input type="date" id="date" name="date" required>
        </div>

        <div class="form-group">
          <label for="motif">Motif</label>
          <input type="text" id="motif" name="motif" placeholder="Raison de la consultation" required>
        </div>
      </div>

      <div class="form-section">
        <div class="section-title">Diagnostic et Traitement</div>
        <div class="form-group">
          <label for="diagnostique">Diagnostic</label>
          <input type="text" id="diagnostique" name="diagnostique" placeholder="Diagnostic établi" required>
        </div>

        <div class="form-group">
          <label for="traitement">Traitement</label>
          <input type="text" id="traitement" name="traitement" placeholder="Plan de traitement" required>
        </div>

        <div class="form-group">
          <label for="count">Nombre de Visites</label>
          <input type="text" id="count" name="count" placeholder="Nombre de visites recommandées" required>
        </div>
      </div>

      <div class="form-section">
        <div class="section-title">Actions et Actes</div>
        <div class="form-group">
          <label for="typeact">Type d'Acte</label>
          <select name="typeact" multiple>
            <c:forEach var="act" items="${TypeAct}">
              <option value="${act}">${act}</option>
            </c:forEach>
          </select>
        </div>
      </div>

      <!-- Improved button layout with clear visual hierarchy -->
      <div class="button-group">
        <button type="submit" name="action" value="termine" class="submit-btn">Soumettre</button>
        <button type="submit" name="action" value="avis" class="submit-btn secondary">Avis Expert</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
