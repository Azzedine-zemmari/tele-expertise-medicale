<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 14/10/2025
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>File d'Attente</title>
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
            padding: 40px 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-header h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #666;
            font-size: 14px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        td {
            padding: 15px;
            font-size: 14px;
            color: #333;
        }

        .patient-name {
            font-weight: 600;
            color: #667eea;
        }

        .action-cell {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-vitals {
            background-color: #667eea;
            color: white;
        }

        .btn-vitals:hover {
            background-color: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-medical {
            background-color: #764ba2;
            color: white;
        }

        .btn-medical:hover {
            background-color: #63408a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
        }

        .btn-consult {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-consult:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background-color: white;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 15px;
        }

        .modal-header h2 {
            color: #333;
            font-size: 22px;
        }

        .close {
            color: #999;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .close:hover {
            color: #333;
        }

        .modal-body {
            color: #555;
            line-height: 1.8;
        }

        .info-group {
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: 600;
            color: #667eea;
            font-size: 13px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .info-value {
            color: #333;
            font-size: 14px;
            padding-left: 10px;
            border-left: 3px solid #667eea;
        }

        .vitals-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 15px;
        }

        .vital-item {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            border-left: 4px solid #764ba2;
        }

        .vital-label {
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .vital-value {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>📋 File d'Attente</h1>
        <p>Gestion des patients en attente de consultation</p>
    </div>

    <c:if test="${empty patients}">
        <div class="empty-state">
            <div class="empty-state-icon">😊</div>
            <p>Aucun patient en attente</p>
        </div>
    </c:if>

    <c:if test="${not empty patients}">
        <div class="table-wrapper">
            <table>
                <thead>
                <tr>
                    <th>Nom & Prénom</th>
                    <th>CIN</th>
                    <th>Groupe Sanguin</th>
                    <th>Mutuelle</th>
                    <th>Arrivée</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${patients}">
                    <tr>
                        <td class="patient-name">${p.prenom} ${p.nom}</td>
                        <td>${p.CIN}</td>
                        <td>${p.dossierMedical.bloodType}</td>
                        <td>${p.mutuelle}</td>
                        <td>${p.date_arrive}</td>
                        <td>
                            <div class="action-cell">
                                <button class="btn btn-vitals" onclick="openVitalsModal('vitals-${p.CIN}')">Signes Vitaux</button>
                                <button class="btn btn-medical" onclick="openMedicalModal('medical-${p.CIN}')">Dossier Médical</button>
                                <a href="CreeConsultation?dossier_medical_id=${p.dossierMedical.id}" class="btn btn-consult">Consultation</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Modals for each patient -->
        <c:forEach var="p" items="${patients}">
            <!-- Signes Vitaux Modal -->
            <div id="vitals-${p.CIN}" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>📊 Signes Vitaux</h2>
                        <span class="close" onclick="closeModal('vitals-${p.CIN}')">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="info-group">
                            <div class="info-label">Patient</div>
                            <div class="info-value">${p.prenom} ${p.nom}</div>
                        </div>
                        <div class="vitals-grid">
                            <c:forEach var="sn" items="${p.signesVitaux}">
                                <div class="vital-item">
                                    <div class="vital-label">Tension</div>
                                    <div class="vital-value">${sn.tension}</div>
                                </div>
<%--                                todo : ajouter l autre sn --%>
                                <div class="vital-item">
                                    <div class="vital-label">Température</div>
                                    <div class="vital-value">${sn.temperature}°C</div>
                                </div>
                                <div class="vital-item">
                                    <div class="vital-label">Température</div>
                                    <div class="vital-value">${sn.temperature}°C</div>
                                </div>
                                <div class="vital-item">
                                    <div class="vital-label">Température</div>
                                    <div class="vital-value">${sn.temperature}°C</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Dossier Médical Modal -->
            <div id="medical-${p.CIN}" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>📄 Dossier Médical</h2>
                        <span class="close" onclick="closeModal('medical-${p.CIN}')">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="info-group">
                            <div class="info-label">Patient</div>
                            <div class="info-value">${p.prenom} ${p.nom}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Groupe Sanguin</div>
                            <div class="info-value">${p.dossierMedical.bloodType}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Chirurgies Antérieures</div>
                            <div class="info-value">${p.dossierMedical.pastSurgeries}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Médicaments</div>
                            <div class="info-value">${p.dossierMedical.medications}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Allergies</div>
                            <div class="info-value">${p.dossierMedical.allergies}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Adresse</div>
                            <div class="info-value">${p.address}</div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">N° Sécurité Sociale</div>
                            <div class="info-value">${p.num_securite_social}</div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>

<script>
    function openVitalsModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function openMedicalModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = "none";
        }
    }
</script>
</body>
</html>