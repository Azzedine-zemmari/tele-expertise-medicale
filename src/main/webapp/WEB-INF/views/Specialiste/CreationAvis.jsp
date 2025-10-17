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
    <title>Liste des Demandes d'Expertise</title>
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
            max-width: 1000px;
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

        .form-header p {
            color: #666;
            font-size: 14px;
        }

        .form-header hr {
            border: none;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
            margin-top: 15px;
        }

        .alert {
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

        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border: 2px solid #c3e6cb;
        }

        .alert-info {
            background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
            color: #0c5460;
            border: 2px solid #bee5eb;
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

        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            background: #f8f9fa;
            border-radius: 8px;
            overflow: hidden;
        }

        .details-table th,
        .details-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
            font-size: 14px;
            color: #555;
        }

        .details-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
        }

        .details-table tr:last-child td {
            border-bottom: none;
        }

        .details-table tr:hover {
            background: #f1f3f5;
        }

        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .details-btn {
            background: linear-gradient(135deg, #36d1dc 0%, #5b86e5 100%);
            color: white;
            margin-right: 10px;
        }

        .answer-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }

        .action-btn:active {
            transform: translateY(0);
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }

            .form-header h1 {
                font-size: 24px;
            }

            .details-table th,
            .details-table td {
                font-size: 12px;
                padding: 8px;
            }

            .action-btn {
                font-size: 12px;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-header">
        <h1>📝 Liste des Demandes d'Expertise</h1>
        <p>Gérez les demandes d'expertise et soumettez vos avis médicaux</p>
        <hr/>
    </div>

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success">
            <span class="alert-icon">✅</span>
            <span>Avis ajouté avec succès !</span>
        </div>
    </c:if>

    <!-- Table for DemandeExpertise with Action Buttons -->
    <c:if test="${not empty demandeExpertiseList}">
        <table class="details-table">
            <thead>
            <tr>
                <th>Question</th>
                <th>Priorité</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="d" items="${demandeExpertiseList}">
                <tr>
                    <td><c:out value="${d.question != null ? d.question : 'N/A'}" /></td>
                    <td><c:out value="${d.priority != null ? d.priority : 'N/A'}" /></td>
                    <td>
                            <a href="${pageContext.request.contextPath}/DemandeExpertiseDetails?id=${d.id}" class="action-btn details-btn">
                            <span>🔍</span> Détails
                        </a>
                        <a href="${pageContext.request.contextPath}/AnswerAvis?id=${d.id}" class="action-btn answer-btn">
                            <span>📝</span> Répondre
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty demandeExpertiseList}">
        <div class="alert alert-info">
            <span class="alert-icon">ℹ️</span>
            <span>Aucune demande d'expertise trouvée pour ce spécialiste.</span>
        </div>
    </c:if>
</div>
</body>
</html>