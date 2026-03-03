
public with sharing class CalculatingStageDuration {

    public static void trackingStageduration(List<Order__c> orderList, Map<Id,Order__c> oldMap)
    {
        if(orderList == null || orderList.isEmpty())
        {
            return;
        }
        for(Order__c newOrder : orderList)
        {
            if(oldMap != null)
            {
                Order__c oldOrder = oldMap.get(newOrder.Id);

                if(oldOrder.Stage__c != newOrder.Stage__c)
                {
                    datetime lastchange;

                    if(oldOrder.LastDateChange__c != null)
                    {
                        lastchange = oldOrder.LastDateChange__c;
                    }
                    else
                    {
                        lastchange = oldOrder.CreatedDate;
                    }

                    long Totalseconds = (System.now().getTime() - lastchange.getTime())/1000;
                    long days = Totalseconds/86400;
                    long hours = Math.mod(Totalseconds/3600,24);
                    long seconds = Math.mod(Totalseconds,60);

                    String duration = days + ' days '+ hours + ' hours '+ seconds + ' seconds ';
                    String history = oldOrder.Stage__c + ' to '+newOrder.Stage__c + ' IN ' + duration;

                    if(oldOrder.StageHistory__c != null)
                    {
                        newOrder.StageHistory__c = oldOrder.StageHistory__c + '\n '+ history;
                    }
                    else
                    {
                        newOrder.StageHistory__c = history;
                    }

                    newOrder.LastDateChange__c = System.now();

                    long minuteSpent = Totalseconds/60;

                    if(newOrder.HighestStageTime__c == null ||  minuteSpent > newOrder.HighestStageTime__c)
                    {
                        newOrder.HighestStageTime__c = minuteSpent;
                        newOrder.HighestStageName__c = oldOrder.Stage__c;
                        newOrder.HighestStageDuration__c = duration;
                    }
                }
            }
        }
    }
}