import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountContactSearchCtrl.getAccountList';
import getRelatedContacts from '@salesforce/apex/AccountContactSearchCtrl.getRelatedContacts';

const ACC_COLUMNS = [{ label: 'Account Name', fieldName: 'Name' }, { label: 'Industry', fieldName: 'Industry' }];
const CON_COLUMNS = [{ label: 'First Name', fieldName: 'FirstName' }, { label: 'Last Name', fieldName: 'LastName' }, { label: 'Email', fieldName: 'Email', type: 'email' }];

export default class DualDatatables extends LightningElement {
    accountColumns = ACC_COLUMNS;
    contactColumns = CON_COLUMNS;
    
    searchKey = '';
    selectedAccountId = '';
    accounts;
    contacts;

    // Reacts whenever searchKey changes
    @wire(getAccountList, { searchKey: '$searchKey' })
    wiredAccounts({ data }) {
        if (data) this.accounts = data;
    }

    // Reacts whenever selectedAccountId changes
    @wire(getRelatedContacts, { accountId: '$selectedAccountId' })
    wiredContacts({ data }) {
        this.contacts = data ? data : [];
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value;
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedAccountId = selectedRows.length > 0 ? selectedRows[0].Id : '';
    }
}