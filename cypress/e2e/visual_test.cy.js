describe('Hospital Appointment API - Visual Test', () => {
    it('should demonstrate API functionality with visual feedback', () => {
        // Visit the visual test page
        cy.visit('/api_test.html');

        // Wait for page to load
        cy.wait(2000);

        // Step 1: Fetch Doctors
        cy.contains('button', 'Fetch Doctors').click();

        // Wait to see the subtitle and result
        cy.wait(5000);

        // Verify the subtitle is visible
        cy.get('#subtitle-container').should('be.visible');

        // Verify doctors output is updated
        cy.get('#doctors-output').should('not.contain', 'Waiting for action');

        // Step 2: Book Appointment
        cy.contains('button', 'Book Appointment').click();

        // Wait to see the subtitle and result
        cy.wait(5000);

        // Verify appointment output is updated
        cy.get('#appointment-output').should('not.contain', 'Waiting for action');

        // Final wait to capture the complete state
        cy.wait(2000);
    });
});
