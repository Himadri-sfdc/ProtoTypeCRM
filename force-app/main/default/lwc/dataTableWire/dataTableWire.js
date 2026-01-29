
import { LightningElement, wire, track } from 'lwc';
import searchContacts from '@salesforce/apex/DataTableWithWireClassParc.searchContacts';
import { refreshApex } from '@salesforce/apex'; 

const COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class DataTableWire extends LightningElement {

    columns = COLUMNS;
    @track searchKey = '';
    contacts;
    wiredResult; 

    handleSearch(event) {
        this.searchKey = event.target.value;
    }

    handleRefresh() {
        refreshApex(this.wiredResult);
    }

    @wire(searchContacts, { searchKey: '$searchKey' })
    wiredContacts(result) {        
        this.wiredResult = result; 

        if (result.data) {
            this.contacts = result.data;
        } else if (result.error) {
            console.error(result.error);
        }
    }
}
