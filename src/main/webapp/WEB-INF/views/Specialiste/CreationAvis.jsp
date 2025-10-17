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
    <title>Création d'Avis</title>
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

        /* Success Alert */
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

        /* Form Styling */
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

        .form-group select,
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-group select:focus,
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23667eea' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 40px;
        }

        .select-wrapper {
            position: relative;
        }

        .select-info {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            margin-top: 10px;
            font-size: 13px;
            color: #555;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }

            .form-header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-header">
        <h1>📝 Création d'Avis</h1>
        <p>Ajouter votre avis médical pour une demande d'expertise</p>
        <hr/>
    </div>

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success">
            <span class="alert-icon">✅</span>
            <span>Avis ajouté avec succès !</span>
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/CreationAvis">
        <div class="form-group">
            <label for="demandeExpertise">🔍 Sélectionner une Demande d'Expertise</label>
            <div class="select-wrapper">
                <select name="demandeExpertise" id="demandeExpertise" required>
                    <option value="" selected disabled>-- Choisir une demande --</option>
                    <c:forEach var="d" items="${demandeExpertiseList}">
                        <option value="${d.id}">${d.question}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="select-info">
                💡 Sélectionnez la demande d'expertise pour laquelle vous souhaitez donner votre avis médical
            </div>
        </div>

        <div class="form-group">
            <label for="avis">💬 Votre Avis Médical</label>
            <textarea
                    name="avis"
                    id="avis"
                    placeholder="Rédigez votre avis médical détaillé concernant cette demande d'expertise..."
                    required
                    oninput="updateCharCount()"
            ></textarea>
            <div class="char-count" id="charCount">0 caractères</div>
        </div>

        <button type="submit" class="submit-btn">
            <span>📄</span>
            <span>Soumettre l'Avis</span>
        </button>
    </form>
</div>

<script>
    function updateCharCount() {
        const textarea = document.getElementById('avis');
        const charCount = document.getElementById('charCount');
        const count = textarea.value.length;
        charCount.textContent = count + ' caractère' + (count > 1 ? 's' : '');
    }
</script>
</body>
</html>