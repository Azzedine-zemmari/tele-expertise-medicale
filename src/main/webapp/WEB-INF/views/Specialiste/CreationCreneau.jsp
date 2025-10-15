<%--
  Created by IntelliJ IDEA.
  User: azzed
  Date: 15/10/2025
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Création de Créneaux</title>
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

    .form-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
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
    }

    .days-section {
      margin-bottom: 30px;
    }

    .days-section h3 {
      color: #333;
      font-weight: 600;
      font-size: 14px;
      margin-bottom: 15px;
    }

    .days-grid {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }

    .day-checkbox {
      display: flex;
      align-items: center;
      gap: 10px;
      cursor: pointer;
      user-select: none;
    }

    .day-checkbox input[type="checkbox"] {
      width: 18px;
      height: 18px;
      cursor: pointer;
      accent-color: #667eea;
    }

    .day-checkbox label {
      font-size: 15px;
      color: #333;
      cursor: pointer;
      font-weight: 500;
    }

    .actions {
      display: flex;
      gap: 15px;
      margin-bottom: 40px;
      flex-wrap: wrap;
    }

    .btn {
      padding: 12px 24px;
      border-radius: 8px;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-generate {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      flex: 1;
      min-width: 200px;
    }

    .btn-generate:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
    }

    .btn-add {
      background: #f8f9fa;
      color: #666;
      border: 2px solid #e0e0e0;
      padding: 12px 24px;
    }

    .btn-add:hover {
      background: white;
      border-color: #667eea;
      color: #667eea;
    }

    .btn-clear {
      background: #fff5f5;
      color: #e53e3e;
      border: 2px solid #feb2b2;
      padding: 12px 24px;
    }

    .btn-clear:hover {
      background: #fed7d7;
      border-color: #fc8181;
    }

    .slots-section {
      margin-top: 40px;
      padding-top: 30px;
      border-top: 2px solid #f0f0f0;
    }

    .slots-section h2 {
      font-size: 18px;
      color: #333;
      margin-bottom: 20px;
      font-weight: 600;
    }

    .slots-list {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .slot-item {
      background: #f8f9fa;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      padding: 16px 20px;
      display: flex;
      align-items: center;
      gap: 15px;
      transition: all 0.3s ease;
    }

    .slot-item:hover {
      background: white;
      border-color: #667eea;
    }

    .slot-arrow {
      color: #667eea;
      font-size: 18px;
      font-weight: bold;
    }

    .slot-content {
      flex: 1;
      color: #333;
      font-size: 14px;
      font-weight: 500;
    }

    .slot-delete {
      background: #fff5f5;
      border: 2px solid #feb2b2;
      color: #e53e3e;
      padding: 8px 16px;
      border-radius: 6px;
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .slot-delete:hover {
      background: #fed7d7;
      border-color: #fc8181;
    }

    .submit-section {
      margin-top: 40px;
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

    @media (max-width: 768px) {
      .form-grid {
        grid-template-columns: 1fr;
      }

      .actions {
        flex-direction: column;
      }

      .btn-generate {
        width: 100%;
      }

      .container {
        padding: 30px 20px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="form-header">
    <h1>Création de Créneaux</h1>
    <p>Définissez les horaires de disponibilité</p>
  </div>

  <div class="form-grid">
    <div class="form-group">
      <label for="date">Date debut</label>
      <input type="datetime-local" id="date" name="date" value="2025-10-15">
    </div>


    <div class="form-group">
      <label for="datefin">Date fin</label>
      <input type="datetime-local" id="datefin" name="datefin" value="2025-10-22">
    </div>
  </div>

  <div class="actions">
    <button class="btn btn-generate" onclick="generateSlots()">Générer (30m)</button>
<%--    <button class="btn btn-add" onclick="addSlot()">Ajouter créneau unique</button>--%>
<%--    <button class="btn btn-clear" onclick="clearSlots()">Vider créneaux</button>--%>
  </div>

  <div class="slots-section">
    <h2>Liste des créneaux générés</h2>
    <div class="slots-list" id="slotsList">

    </div>
  </div>

</div>

<script>
  function generateSlots() {
    const dateValue = document.getElementById('date').value;
    const datefinValue = document.getElementById('datefin').value;

    const date = new Date(dateValue);
    const datefin = new Date(datefinValue);

    const diffMillescond = datefin.getTime() - date.getTime();
    const diffMinutes = diffMillescond / 60000;

    console.log("diffMillescond : ", diffMillescond);
    console.log("diffMinutes : ", diffMinutes);

    if (diffMinutes <= 0) {
      alert('La date/heure de fin doit être après la date/heure de début');
      return;
    }

    // Divide diffMinutes into 30 min chunks
    const chunkSize = 30;
    const totalChunks = Math.ceil(diffMinutes / chunkSize);
    const chunks = [];
    let current = new Date(date);

    for (let i = 0; i < totalChunks; i++) {
      let next = new Date(current.getTime() + chunkSize * 60000);
      if (next > datefin) next = new Date(datefin);
      chunks.push({start: new Date(current), end: new Date(next)});
      current = next;
    }

    console.log("Chunks array:", chunks);
    console.log("Chunks length:", chunks.length);
    console.log("Chunks type:", Array.isArray(chunks));

    // Clear existing slots
    const slotsList = document.getElementById('slotsList');
    slotsList.innerHTML = '';

    // Add new slots to the HTML
    chunks.forEach((chunk, index) => {
      // Format: 2025-10-15 | 10:00 - 10:30
      const dateStr = chunk.start.toISOString().split('T')[0];
      const startTime = chunk.start.toTimeString().substring(0, 5);
      const endTime = chunk.end.toTimeString().substring(0, 5);


      const slotHTML = `
      <div class="slot-item">
        <span class="slot-arrow">→</span>
        <span class="slot-content"> ` + dateStr + ` | ` + startTime + ` - ` + endTime + `</span>
        <button class="slot-delete" id="slot-`+ index +`">suppr</button>
      </div>
    `;
        console.log(slotHTML)

      slotsList.innerHTML += slotHTML;
    });

  }

 document.querySelectorAll('.slot-delete').forEach(button=>{
   button.addEventListener('click',function (){
     this.parentElement.remove();
   })
 })

  function submitSlots() {
    alert('Spécialiste créé avec succès !');
  }

  document.addEventListener('click', function(e) {
    if (e.target.classList.contains('slot-delete')) {
      e.target.closest('.slot-item').remove();
    }
  });
</script>
</body>
</html>
