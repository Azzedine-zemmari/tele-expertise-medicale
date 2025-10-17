<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 18/10/2025
  Time: 07:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profil Spécialiste</title>
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
            padding: 20px;
        }

        .layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 25px;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Sidebar Styles */
        .sidebar {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 30px 0;
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .sidebar-header {
            padding: 0 25px 25px;
            border-bottom: 2px solid #f0f0f0;
        }

        .sidebar-header h2 {
            color: #333;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            color: #999;
            font-size: 13px;
        }

        .sidebar-menu {
            padding: 15px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 25px;
            color: #555;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            font-size: 15px;
            font-weight: 500;
        }

        .menu-item:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.1) 0%, transparent 100%);
            color: #667eea;
            border-left-color: #667eea;
        }

        .menu-item.active {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.15) 0%, transparent 100%);
            color: #667eea;
            border-left-color: #667eea;
            font-weight: 600;
        }

        .menu-icon {
            font-size: 20px;
            width: 24px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
        }

        /* Profile Header */
        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid #f0f0f0;
        }

        .avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: white;
            font-weight: 700;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            flex-shrink: 0;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 32px;
            color: #333;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .profile-email {
            color: #667eea;
            font-size: 16px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.15) 0%, rgba(118, 75, 162, 0.15) 100%);
            color: #667eea;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            border: 2px solid rgba(102, 126, 234, 0.3);
        }

        /* Info Cards Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            padding: 25px;
            border-radius: 12px;
            border: 2px solid rgba(102, 126, 234, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.15);
        }

        .info-card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .info-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
        }

        .info-card h3 {
            color: #333;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-card-value {
            color: #555;
            font-size: 18px;
            font-weight: 600;
            line-height: 1.4;
        }

        /* Experience Section */
        .experience-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }

        .experience-section h3 {
            color: #333;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .experience-section p {
            color: #555;
            font-size: 15px;
            line-height: 1.6;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: static;
            }

            .sidebar-menu {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                text-align: center;
            }

            .profile-email {
                justify-content: center;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .main-content {
                padding: 30px 20px;
            }

            .profile-name {
                font-size: 26px;
            }

            .sidebar-menu {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Menu</h2>
            <p>Gestion du Profil</p>
        </div>
        <nav class="sidebar-menu">
            <a href="#" class="menu-item active">
                <span class="menu-icon">👤</span>
                <span>Mon Profil</span>
            </a>
            <a href="${pageContext.request.contextPath}/CreeCreneau" class="menu-item">
                <span class="menu-icon">📅</span>
                <span>Créer Créneau</span>
            </a>
            <a href="${pageContext.request.contextPath}/CreationAvis" class="menu-item">
                <span class="menu-icon">📋</span>
                <span>Avis Expertise</span>
            </a>
            <a href="${pageContext.request.contextPath}/specialiste-statistiques" class="menu-item">
                <span class="menu-icon">📊</span>
                <span>Statistiques</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="avatar">
                ${specialiste.utilisateur.nom.substring(0,1)}${specialiste.utilisateur.prenom.substring(0,1)}
            </div>
            <div class="profile-info">
                <h1 class="profile-name">${specialiste.utilisateur.nom} ${specialiste.utilisateur.prenom}</h1>
                <p class="profile-email">
                    <span>✉️</span>
                    <span>${specialiste.utilisateur.email}</span>
                </p>
                <span class="badge">🩺 Spécialiste Médical</span>
            </div>
        </div>

        <!-- Info Cards Grid -->
        <div class="info-grid">
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-icon">🎓</div>
                    <h3>Spécialité</h3>
                </div>
                <div class="info-card-value">${specialiste.specialiste}</div>
            </div>

            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-icon">💰</div>
                    <h3>Tarif</h3>
                </div>
                <div class="info-card-value">${specialiste.tarif} DH</div>
            </div>

            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-icon">⏱️</div>
                    <h3>Expérience</h3>
                </div>
                <div class="info-card-value">${specialiste.experience} ans</div>
            </div>
        </div>

        <!-- Experience Section -->
        <div class="experience-section">
            <h3>
                <span>📖</span>
                <span>Parcours Professionnel</span>
            </h3>
            <p>${specialiste.experience} années d'expérience dans le domaine de ${specialiste.specialiste}.
                Spécialiste qualifié offrant des consultations professionnelles et des avis d'expertise médicale.</p>
        </div>
    </main>
</div>
</body>
</html>