
import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'; 

import fetchAccounts from '@salesforce/apex/AccountDataTableClass.fetchAccounts';
import fetchContacts from '@salesforce/apex/AccountDataTableClass.fetchContacts';

// Columns for accounts table
const ACCOUNT_COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Industry', fieldName: 'Industry', type: 'text', sortable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

// Columns for contacts table with row actions
const CONTACT_COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName', type: 'text' },
    { label: 'Last Name', fieldName: 'LastName', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'View', name: 'view' },
                { label: 'Edit', name: 'edit' },
                { label: 'Delete', name: 'delete' }
            ]
        }
    }
];

export default class AccountContactTable extends NavigationMixin(LightningElement) {
    // Table columns
    accountColumns = ACCOUNT_COLUMNS;
    contactColumns = CONTACT_COLUMNS;

    // Reactive state
    @track searchKey = '';
    @track accounts = [];
    @track contacts = [];
    @track showContacts = false;
    @track selectedAccountId = null;

    editModalOpen = false;
    editRecordId;

    wiredAccountsResult;
    wiredContactsResult;

    /* ----------------- Accounts Wire ----------------- */
    @wire(fetchAccounts, { searchKey: '$searchKey' })
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.accounts = result.data;
        } else if (result.error) {
            this.accounts = [];
            console.error('Error fetching accounts:', result.error);
        }
    }

    /* ----------------- Contacts Wire ----------------- */
    @wire(fetchContacts, { accountId: '$selectedAccountId' })
    wiredContacts(result) {
        this.wiredContactsResult = result;

        if (this.selectedAccountId && result.data) {
            this.contacts = result.data;
            this.showContacts = this.contacts.length > 0;
        } else {
            this.contacts = [];
            this.showContacts = false;
        }
    }

    /* ----------------- Search ----------------- */
    handleSearchKeyChange(event) {
        this.searchKey = event.target.value;
    }

    refreshAccounts() {
        if (this.wiredAccountsResult) refreshApex(this.wiredAccountsResult);
    }

    /* ----------------- Account Selection ----------------- */
    handleAccountSelection(event) {
        const rows = event.detail.selectedRows;
        this.selectedAccountId = rows.length ? rows[0].Id : null;

        if (!this.selectedAccountId) {
            this.contacts = [];
            this.showContacts = false;
        } else if (this.wiredContactsResult) {
            refreshApex(this.wiredContactsResult);
        }
    }

    /* ----------------- Contact Row Actions ----------------- */
    handleContactRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;

        switch (action) {
            case 'view':
                this.navigateToRecord(row.Id);
                break;
            case 'edit':
                this.editRecordId = row.Id;
                this.editModalOpen = true;
                break;
            case 'delete':
                this.deleteContact(row.Id);
                break;
        }
    }

    navigateToRecord(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }

    async deleteContact(recordId) {
        try {
            await deleteRecord(recordId);
            this.showToast('Deleted', 'Contact deleted successfully', 'success');
            if (this.wiredContactsResult) refreshApex(this.wiredContactsResult);
        } catch (error) {
            const message = error?.body?.message || String(error);
            this.showToast('Delete failed', message, 'error');
        }
    }

    /* ----------------- Edit Modal ----------------- */
    closeModal() {
        this.editModalOpen = false;
        this.editRecordId = null;
    }

    handleEditSuccess() {
        this.showToast('Updated', 'Contact updated successfully', 'success');
        this.closeModal();
        if (this.wiredContactsResult) refreshApex(this.wiredContactsResult);
    }

    /* ----------------- Toast ----------------- */
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
