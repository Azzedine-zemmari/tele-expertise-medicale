<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 10/10/2025
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Dashboard - Consultations</title>
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
            padding: 30px 20px;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .dashboard-header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .dashboard-header h1 {
            font-size: 36px;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .dashboard-header p {
            font-size: 16px;
            opacity: 0.9;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .full-width-card {
            grid-column: 1 / -1;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }

        .waiting-icon {
            background: linear-gradient(135deg, #ffa726 0%, #fb8c00 100%);
        }

        .today-icon {
            background: linear-gradient(135deg, #66bb6a 0%, #43a047 100%);
        }

        .status-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .card-title {
            flex: 1;
        }

        .card-title h2 {
            color: #333;
            font-size: 22px;
            margin-bottom: 5px;
        }

        .card-title .count {
            color: #666;
            font-size: 14px;
            font-weight: 600;
        }

        .patient-list {
            list-style: none;
        }

        .patient-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .patient-item:hover {
            background: #e9ecef;
            border-left-color: #667eea;
            transform: translateX(5px);
        }

        .patient-info {
            display: flex;
            align-items: center;
            flex: 1;
        }

        .patient-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
            margin-right: 15px;
        }

        .patient-details {
            flex: 1;
        }

        .patient-name {
            color: #333;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 3px;
        }

        .patient-meta {
            color: #666;
            font-size: 13px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-waiting {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-today {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .status-consultation {
            background: #ede7f6;
            color: #5e35b1;
        }

        .patient-extra-info {
            margin-top: 8px;
            padding-top: 8px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .info-chip {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            background: white;
            border-radius: 12px;
            font-size: 12px;
            color: #666;
            border: 1px solid #e0e0e0;
        }

        .info-chip strong {
            margin-right: 5px;
            color: #333;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .empty-state p {
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .cards-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-header h1 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>📋 Dashboard des Consultations</h1>
        <p>Vue d'ensemble des patients aujourd'hui</p>
    </div>

    <div class="cards-grid">
        <!-- Consultations en attente -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon waiting-icon">⏳</div>
                <div class="card-title">
                    <h2>En Attente</h2>
                    <span class="count">${patients.size()} patient(s)</span>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty patients}">
                    <ul class="patient-list">
                        <c:forEach var="p" items="${patients}">
                            <li class="patient-item">
                                <div class="patient-info">
                                    <div class="patient-avatar">
                                            ${p.nom.substring(0, 1).toUpperCase()}
                                    </div>
                                    <div class="patient-details">
                                        <div class="patient-name">${p.nom} ${p.prenom}</div>
                                    </div>
                                </div>
                                <span class="status-badge status-waiting">En attente</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📭</div>
                        <p>Aucun patient en attente</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Consultations d'aujourd'hui -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon today-icon">📅</div>
                <div class="card-title">
                    <h2>Aujourd'hui</h2>
                    <span class="count">${patientsToday.size()} consultation(s)</span>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty patientsToday}">
                    <ul class="patient-list">
                        <c:forEach var="pt" items="${patientsToday}">
                            <li class="patient-item">
                                <div class="patient-info">
                                    <div class="patient-avatar">
                                            ${pt.nom.substring(0, 1).toUpperCase()}
                                    </div>
                                    <div class="patient-details">
                                        <div class="patient-name">${pt.nom} ${pt.prenom}</div>
                                    </div>
                                </div>
                                <span class="status-badge status-today">Aujourd'hui</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📭</div>
                        <p>Aucune consultation prévue aujourd'hui</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Patients avec consultations (full width) -->
    <div class="cards-grid">
        <div class="card full-width-card">
            <div class="card-header">
                <div class="card-icon status-icon">📊</div>
                <div class="card-title">
                    <h2>Statut des Consultations</h2>
                    <span class="count">${patientstatus.size()} patient(s) avec consultation</span>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty patientstatus}">
                    <ul class="patient-list">
                        <c:forEach var="ps" items="${patientstatus}">
                            <li class="patient-item">
                                <div class="patient-info">
                                    <div class="patient-avatar">
                                            ${ps.nom.substring(0, 1).toUpperCase()}
                                    </div>
                                    <div class="patient-details">
                                        <div class="patient-name">${ps.nom} ${ps.prenom}</div>
                                    </div>
                                </div>
                                <span class="status-badge status-consultation">Consultation</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📭</div>
                        <p>Aucun patient avec consultation</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>