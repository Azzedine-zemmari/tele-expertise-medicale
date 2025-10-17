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
    <title>recherche</title>
</head>
<%--todo : fix the ui --%>
<body>
    <form method="post" action="${pageContext.request.contextPath}/rechercher-specialiste">
        <input type="hidden" name="consultationId" value="${consultationId != null ? consultationId : param.consultationId}"/>
        <input placeholder="specialist" name="specialite" />
        <input placeholder="tarif" name="tarif" />
        <button type="submit"> submit </button>
    </form>
    <c:choose>
        <c:when test="${not empty specialistes}">
            <select id="specialiste" name="sepecialiste">
            <c:forEach var="r" items="${specialistes}">
                <option selected disabled>select specialiste</option>
                <option value="${r.id}">${r.utilisateur.nom} ${r.utilisateur.prenom} ${r.specialiste}</option>
            </c:forEach>
            </select>
        </c:when>
        <c:otherwise>
            <p>Nothing</p>
        </c:otherwise>
    </c:choose>
<%--    fch kndir submit kimchi consultation id --%>
<form method="post" action="${pageContext.request.contextPath}/demande-expertise/create">
    <label for="creneau">Créneaux disponibles :</label>
    <select id="creneau" name="datedemande" disabled>
        <option value="">-- Sélectionner un spécialiste d'abord --</option>
    </select>
    <label for="question">Votre question :</label>
    <textarea id="question" name="question" required></textarea>
    <input type="hidden" name="consultationId" value="${param.consultationId}" />
    <input type="hidden" id="specialistId" name="specialistId" value=""/>
    <label for="priorite">Priorité :</label>
    <select id="priorite" name="priorite">
        <option value="BASSE">Basse</option>
        <option value="MOYENNE">Moyenne</option>
        <option value="HAUTE">Haute</option>
    </select>

    <button type="submit">Envoyer</button>
</form>
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
                creneauSelect.innerHTML = ""
                if(data.length == 0){
                    creneauSelect.innerHTML = '<option value="">Aucun créneau disponible</option>';
                }
                else{
                    data.forEach(creneu =>{
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
