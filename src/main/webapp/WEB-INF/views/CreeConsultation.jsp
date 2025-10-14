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
      padding: 15px;
      background: #f8f9fa;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .checkbox-group:hover {
      background: #e9ecef;
    }

    .checkbox-group input[type="checkbox"] {
      width: 20px;
      height: 20px;
      margin-right: 12px;
      cursor: pointer;
      accent-color: #667eea;
    }

    .checkbox-group label {
      color: #333;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      user-select: none;
      margin-bottom: 0;
    }

    .checkbox-group a {
      color: #667eea;
      text-decoration: none;
    }

    .checkbox-group a:hover {
      text-decoration: underline;
    }

    /* Smooth transition for the signes vitaux form */
    #signeVitauxForm {
      overflow: hidden;
      max-height: 0;
      opacity: 0;
      border: 1px solid #e0e0e0;
      padding: 0 15px;
      border-radius: 10px;
      margin-bottom: 20px;
      background: #f8f9fa;
      transition: all 0.5s ease-in-out;
    }

    #signeVitauxForm.show {
      max-height: 600px;
      opacity: 1;
      padding: 20px 15px;
      margin-bottom: 25px;
    }

    #signeVitauxForm h3 {
      color: #667eea;
      font-size: 18px;
      margin-bottom: 20px;
      text-align: center;
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

  <div class="form-content">
    <form method="post" action="${pageContext.request.contextPath}/CreeConsultation">
        <div class="form-group">
          <label for="temperature">Température (°C)</label>
          <input type="text" id="temperature" name="temperature">
        </div>

        <div class="form-group">
          <label for="poids">Poids (kg)</label>
          <input type="text" id="poids" name="poids">
        </div>

        <div class="form-group">
          <label for="FrequenceCardiaque">Fréquence Cardiaque</label>
          <input type="text" id="FrequenceCardiaque" name="FrequenceCardiaque">
        </div>
        <div class="form-group">
          <label for="tension">Tension</label>
          <input type="text" id="tension" name="tension">
        </div>

      <button type="submit" class="submit-btn">Submit</button>
    </form>
  </div>
</div>

</body>
</html>