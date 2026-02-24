
public with sharing class EmailOnCaseDeletion {

    public static void TaskEmailOnCaseDeletion(List<Case> oldCase)
    {
        Set<Id> accIds = new Set<Id>();
        List<Task> listTask = new List<Task>();
        List<Messaging.SingleEmailMessage> emailToSend = new List<Messaging.SingleEmailMessage>();

        for(case cs : oldCase)
        {
            if(cs.AccountId != null)
            {
                accIds.add(cs.AccountId);
            }
        }
        if(!accIds.isEmpty())
        {
            Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id,Name,Owner.Email,OwnerId FROM Account WHERE Id IN : accIds]);

            for(Case cs : oldCase)
            {
                if(cs.AccountId != null && accMap.containsKey(cs.AccountId))
                {
                    Task tsk = new Task();
                    tsk.Subject = cs.CaseNumber + ' with case subject '+ cs.subject +' has been deleted ';
                    tsk.WhatId = cs.AccountId;
                    tsk.Priority = 'Medium';
                    listTask.add(tsk);

                    if(accMap.get(cs.AccountId).Owner.Email != null)
                    {
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        email.setToAddresses(new String[] {accMap.get(cs.AccountId).Owner.Email});
                        email.setPlainTextBody(cs.CaseNumber + ' with case subject '+ cs.subject +' has been deleted ');
                        email.setSubject('case with a case number '+cs.CaseNumber + ' has been deleted');
                        emailToSend.add(email);
                    }
                }
            } 
            if(!listTask.isEmpty())
            {
                insert listTask;
            }
            if(!emailToSend.isEmpty())
            {
                Messaging.sendEmail(emailToSend);
            }
        }
    }
}