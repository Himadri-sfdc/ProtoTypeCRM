

public with sharing class AccountPhoneEmailHnadler {

    public static void PreventDuplicateEmail(List<Account> accList)
    {
        Set<String> setPhone = new Set<String>();
        Map<String,Id> mapToEmail = new Map<String,Id>();

        for(Account acc : acclist)
        {
            if(String.isNotBlank(acc.Phone))
            {
                setPhone.add(acc.Phone);
            }
        }
        for(Account acc : [SELECT Id,Phone FROM Account WHERE Phone IN : setPhone])
        {
            mapToEmail.put(acc.Phone,acc.Id);
        }
        for(Account acc : accList)
        {
            if(String.isNotBlank(acc.Phone) && mapToEmail.containskey(acc.Phone) && mapToEmail.get(acc.Phone) != acc.Id)
            {
                acc.addError('CANNot INSERT : DUPLICATE FOUND');
            }
        }
    }
}    
