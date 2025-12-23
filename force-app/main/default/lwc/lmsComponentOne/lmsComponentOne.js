import { LightningElement,api,wire } from 'lwc';
import LWCPassData from '@salesforce/messageChannel/LWCPassData__c';
import { subscribe, MessageContext } from 'lightning/messageService';
export default class LmsComponentOne extends LightningElement {

    @wire(MessageContext) messageContext;

    receivedMessage = '';

    connectedCallback()
    {
        subscribe(this.messageContext,LWCPassData,(message) => {

            this.receivedMessage = message.Section;
        });
}
}