<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>Créer un spécialiste</title>
  <link href='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.19/index.global.min.css' rel='stylesheet' />
  <link href='https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.19/index.global.min.css' rel='stylesheet' />
  <link href='https://cdn.jsdelivr.net/npm/@fullcalendar/timegrid@6.1.19/index.global.min.css' rel='stylesheet' />

  <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.19/index.global.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.19/index.global.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/timegrid@6.1.19/index.global.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.19/index.global.min.js'></script>

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
      max-width: 1200px;
      margin: 0 auto;
      background: white;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      padding: 40px;
    }

    .form-header {
      text-align: center;
      margin-bottom: 35px;
    }

    .form-header h1 {
      color: #333;
      font-size: 28px;
      margin-bottom: 10px;
    }

    .form-header p {
      color: #666;
      font-size: 14px;
    }

    #calendrier {
      margin: 30px 0;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    /* Style FullCalendar */
    .fc {
      background: #f8f9fa;
    }

    .fc .fc-button-primary {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      border-radius: 6px;
      padding: 8px 16px;
      font-weight: 600;
    }

    .fc .fc-button-primary:hover {
      background: linear-gradient(135deg, #5568d3 0%, #653a8b 100%);
    }

    .fc .fc-button-primary:disabled {
      background: #ccc;
      opacity: 0.6;
    }

    .fc-event {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .fc-event:hover {
      background: linear-gradient(135deg, #5568d3 0%, #653a8b 100%);
    }

    .fc-daygrid-day:hover,
    .fc-timegrid-slot:hover {
      background-color: rgba(102, 126, 234, 0.05);
    }

    .fc .fc-col-header-cell {
      background: #f8f9fa;
      font-weight: 600;
      color: #333;
      padding: 12px 0;
    }

    .fc .fc-scrollgrid {
      border-radius: 12px;
      overflow: hidden;
    }

    #crenauxInput {
      display: none;
    }

    .slots-info {
      background: #f8f9fa;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      padding: 20px;
      margin: 20px 0;
    }

    .slots-info h3 {
      color: #333;
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 12px;
    }

    .slots-info p {
      color: #666;
      font-size: 14px;
      margin-bottom: 8px;
    }

    .slots-count {
      display: inline-block;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 6px 14px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 14px;
      margin-top: 10px;
    }

    .submit-section {
      margin-top: 30px;
      padding-top: 30px;
      border-top: 2px solid #f0f0f0;
      text-align: center;
    }

    .btn-submit {
      background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
      color: white;
      padding: 14px 40px;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(72, 187, 120, 0.4);
    }

    .btn-submit:active {
      transform: translateY(0);
    }

    @media (max-width: 768px) {
      .container {
        padding: 30px 20px;
      }

      #calendrier {
        height: 500px;
      }
    }
  </style>

  <script>
    let slotsCount = 0;

    document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendrier');
      var slots = [];
      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'timeGridWeek',
        selectable: true,
        slotMinTime: '08:00:00',
        slotMaxTime: '20:00:00',
        allDaySlot: false,
        height: 600,
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'timeGridWeek,timeGridDay'
        },
        select: function(info) {
          calendar.addEvent({
            title: 'Créneau',
            start: info.start,
            end: info.end,
            allDay: false
          });

          slots.push({ start: info.startStr, end: info.endStr });
          slotsCount = slots.length;
          updateSlotsCount();

          document.getElementById('crenauxInput').value = JSON.stringify(slots);

          calendar.unselect();
          console.log("Debut : ",info.start)
          console.log("Fin : ",info.end)
        },
        eventClick: function(info) {
          if(confirm("Supprimer ce créneau ?")) {
            slots = slots.filter(slot => slot.start !== info.event.startStr || slot.end !== info.event.endStr);
            slotsCount = slots.length;
            updateSlotsCount();
            info.event.remove();
            document.getElementById('crenauxInput').value = JSON.stringify(slots);
          }
        }
      });
      calendar.render();
    });

    function updateSlotsCount() {
      const countElement = document.getElementById('slotsCount');
      if (countElement) {
        countElement.textContent = slotsCount + ' créneau' + (slotsCount > 1 ? 'x' : '');
      }
    }
  </script>
</head>
<body>
<div class="container">
  <div class="form-header">
    <h1>Créer un Spécialiste</h1>
    <p>Sélectionnez les créneaux de disponibilité sur le calendrier</p>
  </div>

  <div class="slots-info">
    <h3>Instructions :</h3>
    <p>📅 Cliquez et glissez sur le calendrier pour créer un créneau</p>
    <p>🗑️ Cliquez sur un créneau existant pour le supprimer</p>
    <p>📊 Créneaux sélectionnés : <span class="slots-count" id="slotsCount">0 créneau</span></p>
  </div>

  <form id="specialisteForm" action="${pageContext.request.contextPath}/CreeCreneau" method="post">
    <div id="calendrier"></div>
    <input type="hidden" id="crenauxInput" name="crenaux" />
    <input type="hidden" name="specialiste_id" value="${sessionScope.specialiste.getId()}"/>
    <div class="submit-section">
      <button type="submit" class="btn-submit">Créer les creneux </button>
    </div>
  </form>
</div>
</body>
</html>