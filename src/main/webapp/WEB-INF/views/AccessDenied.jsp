<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 13/10/2025
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Access Denied</title>
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
            padding: 50px 40px;
            text-align: center;
        }

        .error-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 30px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .error-code {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .info-box {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 30px;
            text-align: left;
        }

        .info-box p {
            margin: 0;
            font-size: 14px;
            color: #555;
        }

        .info-box strong {
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        .btn-back {
            display: inline-block;
            padding: 14px 35px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-back:active {
            transform: translateY(0);
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
            margin: 25px 0;
        }

        .suggestions {
            text-align: left;
            margin-top: 30px;
            padding: 20px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            border-radius: 12px;
        }

        .suggestions h3 {
            color: #667eea;
            font-size: 16px;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .suggestions ul {
            list-style: none;
            padding: 0;
        }

        .suggestions li {
            color: #555;
            font-size: 14px;
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
        }

        .suggestions li:before {
            content: "→";
            position: absolute;
            left: 0;
            color: #667eea;
            font-weight: bold;
        }

        @media (max-width: 480px) {
            .container {
                padding: 40px 25px;
            }

            h1 {
                font-size: 26px;
            }

            .error-icon {
                width: 80px;
                height: 80px;
                font-size: 40px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="error-icon">🚫</div>

    <span class="error-code">403 FORBIDDEN</span>

    <h1>Access Denied</h1>

    <p>You do not have permission to view this page.</p>

    <div class="info-box">
        <strong>⚠️ Accès Restreint</strong>
        <p>Cette page nécessite des autorisations spéciales que vous ne possédez pas actuellement.</p>
    </div>

    <a href="<%= request.getContextPath() %>/dashboard" class="btn-back">
        🏠 Retour au Dashboard
    </a>

    <div class="suggestions">
        <h3>💡 Que faire maintenant ?</h3>
        <ul>
            <li>Vérifiez que vous êtes connecté avec le bon compte</li>
            <li>Contactez un administrateur pour demander les permissions</li>
            <li>Retournez à la page d'accueil et réessayez</li>
        </ul>
    </div>
</div>
</body>
</html>