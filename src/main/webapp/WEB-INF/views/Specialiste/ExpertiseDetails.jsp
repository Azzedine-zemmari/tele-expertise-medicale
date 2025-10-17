<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 18/10/2025
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Détails de la Demande d'Expertise</title>
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
      max-width: 800px;
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
      font-weight: 700;
    }

    .form-header hr {
      border: none;
      height: 3px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 2px;
      margin-top: 15px;
    }

    .card {
      background: #f8f9fa;
      border-radius: 8px;
      padding: 20px;
      border-left: 4px solid #667eea;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .card h3 {
      font-size: 18px;
      color: #333;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .card-section {
      margin-bottom: 15px;
    }

    .card-section h4 {
      font-size: 16px;
      color: #667eea;
      margin-bottom: 10px;
      font-weight: 600;
    }

    .card-section p {
      font-size: 14px;
      color: #555;
      margin-bottom: 8px;
    }

    .card-section p strong {
      color: #333;
    }

    .back-btn {
      padding: 8px 12px;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      background: linear-gradient(135deg, #36d1dc 0%, #5b86e5 100%);
      color: white;
      display: inline-flex;
      align-items: center;
      gap: 5px;
      text-decoration: none;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      margin-top: 20px;
    }

    .back-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    }

    .back-btn:active {
      transform: translateY(0);
    }

    .alert-info {
      background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
      color: #0c5460;
      border: 2px solid #bee5eb;
      padding: 15px 20px;
      border-radius: 12px;
      margin-bottom: 25px;
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 14px;
      font-weight: 500;
      animation: slideDown 0.4s ease;
    }

    .alert-icon {
      font-size: 20px;
    }

    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @media (max-width: 480px) {
      .container {
        padding: 30px 20px;
      }

      .form-header h1 {
        font-size: 24px;
      }

      .card h3 {
        font-size: 16px;
      }

      .card-section h4 {
        font-size: 14px;
      }

      .card-section p {
        font-size: 12px;
      }

      .back-btn {
        font-size: 12px;
        padding: 6px 10px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="form-header">
    <h1>🔍 Détails de la Demande d'Expertise</h1>
    <hr/>
  </div>

  <c:if test="${empty demandeExpertiseDetails}">
    <div class="alert alert-info">
      <span class="alert-icon">ℹ️</span>
      <span>Aucune demande d'expertise trouvée pour cet identifiant.</span>
    </div>
  </c:if>

  <c:if test="${not empty demandeExpertiseDetails}">
    <div class="card">
      <h3>Demande d'Expertise #<c:out value="${demandeExpertiseDetails.id}" /></h3>
      <div class="card-section">
        <h4>Demande Expertise</h4>
        <p><strong>Question:</strong> <c:out value="${demandeExpertiseDetails.question != null ? demandeExpertiseDetails.question : 'N/A'}" /></p>
        <p><strong>Date Demande:</strong> <c:out value="${demandeExpertiseDetails.dateDemand != null ? demandeExpertiseDetails.dateDemand : 'N/A'}" /></p>
        <p><strong>Priorité:</strong> <c:out value="${demandeExpertiseDetails.priority != null ? demandeExpertiseDetails.priority : 'N/A'}" /></p>
        <p><strong>Statut:</strong> <c:out value="${demandeExpertiseDetails.statusExpertise != null ? demandeExpertiseDetails.statusExpertise : 'N/A'}" /></p>
        <p><strong>Avis:</strong> <c:out value="${demandeExpertiseDetails.avis != null ? demandeExpertiseDetails.avis : 'N/A'}" /></p>
        <p><strong>Date Avis:</strong> <c:out value="${demandeExpertiseDetails.dateAvis != null ? demandeExpertiseDetails.dateAvis : 'N/A'}" /></p>
      </div>
      <div class="card-section">
        <h4>Consultation</h4>
        <p><strong>Date:</strong> <c:out value="${demandeExpertiseDetails.consultation.date != null ? demandeExpertiseDetails.consultation.date : 'N/A'}" /></p>
        <p><strong>Motif:</strong> <c:out value="${demandeExpertiseDetails.consultation.motif != null ? demandeExpertiseDetails.consultation.motif : 'N/A'}" /></p>
        <p><strong>Diagnostique:</strong> <c:out value="${demandeExpertiseDetails.consultation.diagnostique != null ? demandeExpertiseDetails.consultation.diagnostique : 'N/A'}" /></p>
        <p><strong>Traitement:</strong> <c:out value="${demandeExpertiseDetails.consultation.traitement != null ? demandeExpertiseDetails.consultation.traitement : 'N/A'}" /></p>
        <p><strong>Statut:</strong> <c:out value="${demandeExpertiseDetails.consultation.status_consultation != null ? demandeExpertiseDetails.consultation.status_consultation : 'N/A'}" /></p>
      </div>
      <div class="card-section">
        <h4>Dossier Médical</h4>
        <p><strong>Patient:</strong> <c:out value="${demandeExpertiseDetails.consultation.dossierMedical.patient.nom != null ? demandeExpertiseDetails.consultation.dossierMedical.patient.nom : 'N/A'}" /></p>
        <p><strong>Groupe Sanguin:</strong> <c:out value="${demandeExpertiseDetails.consultation.dossierMedical.bloodType != null ? demandeExpertiseDetails.consultation.dossierMedical.bloodType : 'N/A'}" /></p>
        <p><strong>Allergies:</strong> <c:out value="${demandeExpertiseDetails.consultation.dossierMedical.allergies != null ? demandeExpertiseDetails.consultation.dossierMedical.allergies : 'N/A'}" /></p>
        <p><strong>Médicaments:</strong> <c:out value="${demandeExpertiseDetails.consultation.dossierMedical.medications != null ? demandeExpertiseDetails.consultation.dossierMedical.medications : 'N/A'}" /></p>
        <p><strong>Chirurgies Antérieures:</strong> <c:out value="${demandeExpertiseDetails.consultation.dossierMedical.pastSurgeries != null ? demandeExpertiseDetails.consultation.dossierMedical.pastSurgeries : 'N/A'}" /></p>
      </div>
    </div>
  </c:if>

  <c:if test="${not empty demandeExpertiseDetails}">
    <a href="${pageContext.request.contextPath}/CreationAvis?specialistId=${demandeExpertiseDetails.specialiste.id}" class="back-btn">
      <span>⬅️</span> Retour
    </a>
  </c:if>
</div>
</body>
</html>