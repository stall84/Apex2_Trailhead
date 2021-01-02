public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> acctList) {
        
        for (Account a : acctList) {
            if (a.shippingState != a.billingState) {
                a.shippingState = a.billingState;
                
            }
        }
        
    }
}