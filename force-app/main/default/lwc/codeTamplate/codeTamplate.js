

import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccs from '@salesforce/apex/AccountControllerr.getAccs';
import getCons from '@salesforce/apex/AccountControllerr.getCons';

export default class AccConSimple extends NavigationMixin(LightningElement) {
    accounts; contacts;
    accCols = [
        { label: 'Name', fieldName: 'Name' },
        { type: 'action', typeAttributes: { rowActions: [{label:'View', name:'view'}, {label:'Edit', name:'edit'}] }}
    ];
    conCols = [{ label: 'Contact Name', fieldName: 'Name' }];

    @wire(getAccs) 
    wiredData({data}) { if(data) this.accounts = data; }

    handleSelect(event) {
        getCons({ accId: event.detail.selectedRows[0].Id })
            .then(res => this.contacts = res);
    }

    handleAction(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: { recordId: event.detail.row.Id, actionName: event.detail.action.name }
        });
    }
}