
import { LightningElement, wire } from 'lwc';
import LWCPassData from '@salesforce/messageChannel/LWCPassData__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class LmsComponentTwo extends LightningElement {

    @wire(MessageContext) messageContext;

    handleClick() {
        const payload = {
            Section: 'Passing data from two to one using message Channel'
        };
        publish(this.messageContext, LWCPassData, payload);
    }
}
