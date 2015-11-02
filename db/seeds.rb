loan = Loan.create!(funded_amount: 1000.0)
Payment.create!(amount: 100.0, post_at: Date.today, loan_id: loan.id)
Payment.create!(amount: 200.0, post_at: Date.today + 1.day, loan_id: loan.id)
Payment.create!(amount: 300.0, post_at: Date.today + 2.day, loan_id: loan.id)