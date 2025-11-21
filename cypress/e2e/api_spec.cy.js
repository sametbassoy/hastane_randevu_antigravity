describe('Hospital Appointment API', () => {
    it('GET /doctors/available - should return a list of doctors', () => {
        cy.request('GET', '/doctors/available').then((response) => {
            expect(response.status).to.eq(200);
            expect(response.body).to.be.an('array');
            if (response.body.length > 0) {
                expect(response.body[0]).to.have.property('name');
                expect(response.body[0]).to.have.property('specialization');
            }
        });
    });

    it('POST /appointments - should create a new appointment', () => {
        // First get a doctor and a patient to link
        cy.request('GET', '/doctors/available').then((docResponse) => {
            const doctorId = docResponse.body[0].id;

            // Assuming patient exists from previous seeding. 
            // In a real test we might create one first, but for this task we rely on existing data.
            // We'll use a hardcoded patient ID or assume ID 1 exists if the array is empty?
            // Let's assume ID 1 exists or fetch it if we had an endpoint.
            // Since we don't have a patient list endpoint, we'll use the one we seeded (likely ID 1 or 2).
            // Let's try with ID 1.
            const patientId = 1;

            cy.request({
                method: 'POST',
                url: '/appointments',
                body: {
                    appointment: {
                        doctor_id: doctorId,
                        patient_id: patientId,
                        appointment_time: new Date(Date.now() + 3600 * 1000).toISOString()
                    }
                },
                failOnStatusCode: false // We want to inspect the response even if it fails
            }).then((response) => {
                if (response.status === 422) {
                    // If validation fails (e.g. patient not found), log it
                    cy.log('Validation failed: ' + JSON.stringify(response.body));
                }
                expect(response.status).to.eq(201);
                expect(response.body).to.have.property('status', 'scheduled');
                expect(response.body).to.have.property('doctor_id', doctorId);
            });
        });
    });
});
