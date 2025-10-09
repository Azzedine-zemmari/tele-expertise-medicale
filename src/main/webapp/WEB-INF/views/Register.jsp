<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inscription</title>
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
        }

        .form-header p {
            color: #666;
            font-size: 14px;
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

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            margin-right: 10px;
            cursor: pointer;
        }

        .checkbox-group label {
            color: #666;
            font-size: 14px;
            cursor: pointer;
        }

        .checkbox-group a {
            color: #667eea;
            text-decoration: none;
        }

        .checkbox-group a:hover {
            text-decoration: underline;
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

        .form-footer {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .form-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .hidden {
            display: none;
        }

        /* Smooth transition for role-specific forms */
        .role-specific-form {
            overflow: hidden;
            transition: max-height 0.3s ease, opacity 0.3s ease;
            max-height: 0;
            opacity: 0;
        }

        .role-specific-form.show {
            max-height: 500px;
            opacity: 1;
        }

        @media (max-width: 480px) {
            .form-row {
                grid-template-columns: 1fr;
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
        <h1>Register</h1>
        <hr/>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/Register">
        <div class="form-row">
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="roles">Role</label>
            <select id="roles" name="role">
                <option value="" disabled selected>Select role</option>
                <option value="INFIRMIER">Infirmier</option>
                <option value="GENERALISTE">Generaliste</option>
                <option value="SPECIALISTE">Specialiste</option>
            </select>
        </div>

        <div id="InfirmierForm" class="role-specific-form hidden">
            <div class="form-group">
                <label for="service">Service</label>
                <input type="text" id="service" name="service">
            </div>
            <div class="form-group">
                <label for="shift">Shift</label>
                <select id="shift" name="shift" required>
                    <option value="JOUR">Jour</option>
                    <option value="NUIT">Nuit</option>
                </select>
            </div>
            <div class="form-group">
                <label for="experience_inf">Experience</label>
                <input type="text" id="experience_inf" name="experience">
            </div>
        </div>

        <div id="GeneralisteForm" class="role-specific-form hidden">
            <div class="form-group">
                <label for="experience_gen">Experience</label>
                <input type="text" id="experience_gen" name="experience_gen">
            </div>
            <div class="form-group">
                <label for="tarifConsultation">Tarif Consultation</label>
                <input type="text" id="tarifConsultation" name="tarifConsultation">
            </div>
        </div>

        <div id="SpecialisteForm" class="role-specific-form hidden">
            <div class="form-group">
                <label for="experience_spec">Experience</label>
                <input type="text" id="experience_spec" name="experience_spec">
            </div>
            <div class="form-group">
                <label for="tarif">Tarif Consultation</label>
                <input type="text" id="tarif" name="tarif">
            </div>
        </div>

        <button type="submit" class="submit-btn">Submit</button>
    </form>
</div>

<script>
    const roles = document.getElementById("roles");
    const infirmierForm = document.getElementById("InfirmierForm");
    const generalistForm = document.getElementById("GeneralisteForm");
    const specialisteForm = document.getElementById("SpecialisteForm");

    function handleRoleChange() {
        // Hide all forms first
        infirmierForm.classList.add("hidden");
        infirmierForm.classList.remove("show");
        generalistForm.classList.add("hidden");
        generalistForm.classList.remove("show");
        specialisteForm.classList.add("hidden");
        specialisteForm.classList.remove("show");

        // Clear required attributes
        document.querySelectorAll('.role-specific-form input').forEach(input => {
            input.removeAttribute('required');
        });

        // Show the right one and set required attributes
        if (roles.value === "INFIRMIER") {
            infirmierForm.classList.remove("hidden");
            setTimeout(() => infirmierForm.classList.add("show"), 10);
            document.querySelectorAll('#InfirmierForm input').forEach(input => {
                input.setAttribute('required', 'required');
            });
        } else if (roles.value === "GENERALISTE") {
            generalistForm.classList.remove("hidden");
            setTimeout(() => generalistForm.classList.add("show"), 10);
            document.querySelectorAll('#GeneralisteForm input').forEach(input => {
                input.setAttribute('required', 'required');
            });
        } else if (roles.value === "SPECIALISTE") {
            specialisteForm.classList.remove("hidden");
            setTimeout(() => specialisteForm.classList.add("show"), 10);
            document.querySelectorAll('#SpecialisteForm input').forEach(input => {
                input.setAttribute('required', 'required');
            });
        }
    }

    // Run on initial load
    handleRoleChange();

    roles.addEventListener("change", handleRoleChange);
</script>
</body>
</html>