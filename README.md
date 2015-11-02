# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

# Solution Statement

A payment model has been created and belongs to a loan. In addition, every loan has many payments.

Every payment has a positive amount, which is validated to never exceed the outstanding balance. It also has a post date which should be either the same as the creation date, or could be a future date at user's discretion.

In the payments controller, #index shows all payments for the specific loan. #show shows that particular payments. #create creates a payment.

Rspec tests are also written to fully test every controller and model methods. The coverage of the tests written are 100%.