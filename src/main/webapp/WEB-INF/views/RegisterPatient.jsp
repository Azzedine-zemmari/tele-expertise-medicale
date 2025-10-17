<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 08/10/2025
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Patient Management</title>
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

        /* Search Section */
        .search-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border: 2px solid rgba(102, 126, 234, 0.2);
        }

        .search-section h3 {
            color: #667eea;
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            white-space: nowrap;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
        }

        .search-btn:active {
            transform: translateY(0);
        }

        /* Patient Info Section */
        .patient-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid #667eea;
        }

        .patient-info h3 {
            color: #333;
            font-size: 18px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .patient-detail {
            display: flex;
            align-items: center;
            padding: 8px 0;
            color: #555;
            font-size: 14px;
        }

        .patient-detail strong {
            color: #333;
            min-width: 80px;
            font-weight: 600;
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
            margin: 25px 0;
        }

        /* Form Sections */
        .form-section-title {
            color: #667eea;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(102, 126, 234, 0.2);
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
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group input[readonly] {
            background: #e9ecef;
            color: #666;
            cursor: not-allowed;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
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

        .link-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 24px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            text-align: center;
        }

        .link-btn:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
        }

        @media (max-width: 480px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 30px 20px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-header">
        <h1>Patient Account</h1>
        <hr/>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <h3>🔍 Search Patient by CIN</h3>
        <form method="get" action="${pageContext.request.contextPath}/searchPatient" class="search-form">
            <input type="text" name="patient_cin" placeholder="Enter patient CIN..." class="search-input" required>
            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>

    <c:choose>
        <c:when test="${not empty patientfound}">
            <!-- Patient Found - Show Info -->
            <div class="patient-info">
                <h3>👤 Patient Information</h3>
                <div class="patient-detail">
                    <strong>Name:</strong> ${patientfound.nom} ${patientfound.prenom}
                </div>
                <div class="patient-detail">
                    <strong>CIN:</strong> ${patientfound.CIN}
                </div>
            </div>

            <div class="divider"></div>

            <!-- Add Vital Signs Form -->
            <h2 class="form-section-title">📋 Add Vital Signs</h2>
            <form method="post" action="${pageContext.request.contextPath}/SigneVital">
                <div class="form-group">
                    <label for="patientId">Patient ID</label>
                    <input type="text" id="patientId" name="patientId" value="${patientfound.id}" readonly>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="tension">Tension (mmHg)</label>
                        <input type="text" id="tension" name="tension" placeholder="e.g., 120/80" required>
                    </div>
                    <div class="form-group">
                        <label for="frequenceCardiaque">Heart Rate (bpm)</label>
                        <input type="text" id="frequenceCardiaque" name="frequenceCardiaque" placeholder="e.g., 72" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="temperature">Temperature (°C)</label>
                        <input type="text" id="temperature" name="temperature" placeholder="e.g., 37.5" required>
                    </div>
                    <div class="form-group">
                        <label for="poids">Weight (kg)</label>
                        <input type="text" id="poids" name="poids" placeholder="e.g., 70" required>
                    </div>
                </div>

                <button type="submit" class="submit-btn">💾 Save Vital Signs</button>
            </form>
        </c:when>

        <c:otherwise>
            <!-- Patient Not Found - Registration Form -->
            <h2 class="form-section-title">➕ Register New Patient</h2>
            <form method="post" action="${pageContext.request.contextPath}/Register-Patient">
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" placeholder="Enter first name" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" placeholder="Enter last name" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="cin">CIN</label>
                    <input type="text" id="cin" name="CIN" placeholder="Enter CIN number" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="mutuelle">Mutuelle</label>
                        <input type="text" id="mutuelle" name="mutuelle" placeholder="Insurance provider" required>
                    </div>
                    <div class="form-group">
                        <label for="securite_social">Social Security Number</label>
                        <input type="text" id="securite_social" name="securite_social" placeholder="Enter SSN" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="adress">Address</label>
                    <input type="text" id="adress" name="adress" placeholder="Enter full address" required>
                </div>

                <button type="submit" class="submit-btn">✅ Register Patient</button>

                <a href="${pageContext.request.contextPath}/SigneVital" class="link-btn">📊 Go to Vital Signs Page</a>
            </form>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>