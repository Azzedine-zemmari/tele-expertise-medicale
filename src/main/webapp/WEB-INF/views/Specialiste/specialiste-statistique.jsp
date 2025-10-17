<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 19/10/2025
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Statistiques</title>
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
            max-width: 900px;
            width: 100%;
            padding: 40px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-header h1 {
            color: #333;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #666;
            font-size: 16px;
        }

        .page-header hr {
            border: none;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
            margin-top: 15px;
            width: 100px;
            margin-left: auto;
            margin-right: auto;
        }

        .specialist-info {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 35px;
            border-left: 4px solid #667eea;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .specialist-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            font-weight: 700;
            flex-shrink: 0;
        }

        .specialist-details h3 {
            color: #333;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .specialist-details p {
            color: #666;
            font-size: 14px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .stat-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            padding: 30px;
            border-radius: 15px;
            border: 2px solid rgba(102, 126, 234, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.2);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 20px;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .stat-label {
            color: #999;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }

        .stat-value {
            color: #333;
            font-size: 36px;
            font-weight: 700;
            line-height: 1;
            margin-bottom: 8px;
        }

        .stat-description {
            color: #666;
            font-size: 14px;
            line-height: 1.4;
        }

        .stat-value-small {
            font-size: 14px;
            color: #667eea;
            font-weight: 600;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 30px 20px;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .stat-value {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>📊 Statistiques</h1>
        <p>Aperçu de votre performance</p>
        <hr/>
    </div>

    <div class="specialist-info">
        <div class="specialist-avatar">
            ${specialiste.utilisateur.nom.substring(0,1)}${specialiste.utilisateur.prenom.substring(0,1)}
        </div>
        <div class="specialist-details">
            <h3>Dr. ${specialiste.utilisateur.nom} ${specialiste.utilisateur.prenom}</h3>
            <p>Spécialiste ID: #${specialiste.id}</p>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">💰</div>
            <div class="stat-label">Revenu Total</div>
            <div class="stat-value">${revenu} DH</div>
            <div class="stat-description">Revenu généré depuis le début</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-label">Total Consultations</div>
            <div class="stat-value">${count}</div>
            <div class="stat-description">Nombre de consultations effectuées</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">📈</div>
            <div class="stat-label">Revenu Moyen</div>
            <div class="stat-value">${count > 0 ? revenu / count : 0} DH</div>
            <div class="stat-description">Par consultation</div>
        </div>
    </div>
</div>
</body>
</html>