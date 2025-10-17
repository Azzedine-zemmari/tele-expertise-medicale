    package org.medicale.teleexpertisemedicale.controller;

    import org.medicale.teleexpertisemedicale.model.SigneVital;
    import org.medicale.teleexpertisemedicale.repository.SigneVitalRepository;

    import javax.persistence.EntityManagerFactory;
    import javax.persistence.Persistence;
    import javax.servlet.ServletException;
    import javax.servlet.annotation.WebServlet;
    import javax.servlet.http.HttpServlet;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import java.io.IOException;
    import java.util.UUID;

    @WebServlet("/GetSigneVital")
    public class GetSigneVitalForClientServlet extends HttpServlet {
        private SigneVitalRepository signeVitalRepository;

        @Override
        public void init() throws ServletException {
            EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
            signeVitalRepository = new SigneVitalRepository(emf);
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String patientId = req.getParameter("patientId");
            UUID patientUUID = UUID.fromString(patientId);
            SigneVital signeVital = signeVitalRepository.getSigneVital(patientUUID);
            String json = "{"
                    + "\"tension\" :\"" + signeVital.getTension() + "\","
                    + "\"temperature\":\"" + signeVital.getTemperature() + "\","
                    + "\"frequenceCardiaque\":\"" + signeVital.getFrequenceCardiaque() + "\","
                    + "\"poids\":\"" + signeVital.getPoids() + "\""
                    + "}";

            resp.getWriter().write(json);
        }
    }
