<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 13/10/2025
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>recherche specialiste et demande expertise</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            margin-bottom: 25px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-header h1 {
            color: white;
            font-size: 32px;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 10px;
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
        }

        .section-title {
            color: #667eea;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(102, 126, 234, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
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
        .form-group select,
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

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group select:disabled {
            background: #e9ecef;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 15px;
            align-items: end;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            white-space: nowrap;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-block {
            width: 100%;
            padding: 14px;
        }

        .specialist-select-wrapper {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 20px;
            border-radius: 12px;
            border: 2px solid rgba(102, 126, 234, 0.2);
        }

        .specialist-select-wrapper select {
            background: white;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .empty-state small {
            color: #999;
            font-size: 14px;
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
            margin: 30px 0;
        }

        input[type="hidden"] {
            display: none;
        }

        @media (max-width: 768px) {
            .search-form {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 30px 20px;
            }

            .page-header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>🔍 Recherche Spécialiste</h1>
        <p>Trouvez un spécialiste et demandez une expertise</p>
    </div>

    <!-- Search Specialist Card -->
    <div class="card">
        <h2 class="section-title">🩺 Rechercher un Spécialiste</h2>
        <form method="post" action="${pageContext.request.contextPath}/rechercher-specialiste">
            <input type="hidden" name="consultationId" value="${consultationId != null ? consultationId : param.consultationId}"/>

            <div class="search-form">
                <div class="form-group">
                    <label>Spécialité</label>
                    <input type="text" placeholder="Ex: Cardiologie, Dermatologie..." name="specialite" />
                </div>
                <div class="form-group">
                    <label>Tarif Maximum</label>
                    <input type="text" placeholder="Ex: 500 DH" name="tarif" />
                </div>
                <button type="submit" class="btn btn-primary">Rechercher</button>
            </div>
        </form>

        <div class="divider"></div>

        <!-- Specialist Results -->
        <c:choose>
            <c:when test="${not empty specialistes}">
                <div class="specialist-select-wrapper">
                    <div class="form-group">
                        <label for="specialiste">👨‍⚕️ Sélectionner un Spécialiste</label>
                        <select id="specialiste" name="sepecialiste">
                            <option selected disabled>-- Sélectionner un spécialiste --</option>
                            <c:forEach var="r" items="${specialistes}">
                                <option value="${r.id}">${r.utilisateur.nom} ${r.utilisateur.prenom} - ${r.specialiste}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <p>🔍 Aucun spécialiste trouvé</p>
                    <small>Essayez de modifier vos critères de recherche</small>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Request Expertise Card -->
    <div class="card">
        <h2 class="section-title">📋 Demande d'Expertise</h2>
        <form method="post" action="${pageContext.request.contextPath}/demande-expertise/create">
            <input type="hidden" name="consultationId" value="${param.consultationId}" />
            <input type="hidden" id="specialistId" name="specialistId" value=""/>

            <div class="form-group">
                <label for="creneau">📅 Créneaux Disponibles</label>
                <select id="creneau" name="datedemande" disabled>
                    <option value="">-- Sélectionner un spécialiste d'abord --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="priorite">⚡ Priorité</label>
                <select id="priorite" name="priorite">
                    <option value="BASSE">🟢 Basse</option>
                    <option value="MOYENNE">🟡 Moyenne</option>
                    <option value="HAUTE">🔴 Haute</option>
                </select>
            </div>

            <div class="form-group">
                <label for="question">💬 Votre Question</label>
                <textarea id="question" name="question" placeholder="Décrivez votre demande d'expertise en détail..." required></textarea>
            </div>

            <button type="submit" class="btn btn-primary btn-block">✉️ Envoyer la Demande</button>
        </form>
    </div>
</div>

<script>
    document.getElementById("specialiste").addEventListener("change",(e)=>{
        const specialistId = e.target.value;
        document.getElementById("specialistId").value = specialistId;
        console.log(specialistId);
        const creneauSelect = document.getElementById("creneau");

        if (!specialistId) {
            creneauSelect.innerHTML = '<option value="">-- Sélectionner un spécialiste d\'abord --</option>';
            creneauSelect.disabled = true;
            return;
        }

        fetch('${pageContext.request.contextPath}/getCreneaux?specialisteId=' + specialistId)
            .then(response => response.json())
            .then(data => {
            console.log("Received creneaux:", data);
                creneauSelect.innerHTML = ""
                if(data.length == 0){
                    creneauSelect.innerHTML = '<option value="">Aucun créneau disponible</option>';
                }
                else{
                    data.forEach(creneu =>{
                        console.log(creneu);
                        const startDate = creneu.heureDebut.date;
                        const startTime = creneu.heureDebut.time;
                        const endDate = creneu.heureFin.date;
                        const endTime = creneu.heureFin.time;

                        const StartStr = startDate.year + '-' + startDate.month + '-' + startDate.day +' ' + startTime.hour + ':' + startTime.minute ;
                        const EndStr =  endTime.hour + ':' + endTime.minute ;
                        creneauSelect.innerHTML += '<option value="'+ StartStr + '|' + EndStr +'">'+ StartStr +' - ' + EndStr +'</option>';
                    })
                }
                creneauSelect.disabled = false;
            })
            .catch(err => console.error("Erreur lors du chargement des créneaux :", err));
    })
</script>
</body>
</html>