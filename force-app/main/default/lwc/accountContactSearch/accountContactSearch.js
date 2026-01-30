import { LightningElement,wire,track } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountContactSearchCtrl.searchAccounts';
import getContacts from '@salesforce/apex/AccountContactSearchCtrl.getContacts';

const ACCOUNT_COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Phone', fieldName: 'Phone' }
];

const CONTACT_COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone' }
];
export default class AccountContactSearch extends LightningElement {

     @track searchObj = {};          // ✅ Blank object
    @track accounts = [];
    @track selectedAccountId;      // 🔥 Reactive property
    @track contacts = [];

    accountColumns = ACCOUNT_COLUMNS;
    contactColumns = CONTACT_COLUMNS;

    // -------- Imperative (Search) ----------
    handleInput(event) {
        this.searchObj.keyword = event.target.value;
    }

    handleSearch() {
        searchAccounts({ keyword: this.searchObj.keyword })
            .then(result => {
                this.accounts = result;
                this.selectedAccountId = null;
                this.contacts = [];
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleRowSelection(event) {
        const rows = event.detail.selectedRows;
        if (rows.length > 0) {
            this.selectedAccountId = rows[0].Id; // 🔥 triggers @wire
        }
    }

    // -------- Wire (Reactive Contacts) ----------
    @wire(getContacts, { accountId: '$selectedAccountId' })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data;
        } else if (error) {
            console.error(error);
        }
    }
}