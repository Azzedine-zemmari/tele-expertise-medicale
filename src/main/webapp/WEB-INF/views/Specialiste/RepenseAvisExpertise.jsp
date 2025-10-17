<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 18/10/2025
  Time: 19:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Soumettre un Avis Médical</title>
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

        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 150px;
            resize: vertical;
        }

        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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
            margin-top: 10px;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }

        .back-btn:active {
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

            .form-group textarea {
                font-size: 12px;
            }

            .submit-btn,
            .back-btn {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-header">
        <h1>📝 Soumettre un Avis Médical</h1>
        <hr/>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/AnswerAvis">
        <input type="hidden" name="demandeExpertise" value="${param.id}"/>
        <div class="form-group">
            <label for="avis">💬 Votre Avis Médical</label>
            <textarea
                    name="avis"
                    id="avis"
                    placeholder="Rédigez votre avis médical détaillé concernant cette demande d'expertise..."
                    oninput="updateCharCount()"
            ></textarea>
            <div class="char-count" id="charCount">0 caractères</div>
        </div>
        <button type="submit" class="submit-btn">
            <span>📄</span>
            <span>Soumettre l'Avis</span>
        </button>
    </form>

    <a href="${pageContext.request.contextPath}/CreationAvis" class="back-btn">
        <span>⬅️</span> Retour
    </a>
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
