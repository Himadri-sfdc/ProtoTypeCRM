import { LightningElement, track } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountDataTableClass.fetchAccounts';
import getContactsByAccount from '@salesforce/apex/AccountDataTableClass.getContactsByAccount';

const accountColumns = [
    { label: 'Id', fieldName: 'Id', type: 'text', sortable: true },
    { label: 'Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Industry', fieldName: 'Industry', type: 'text', sortable: true },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'number', sortable: true },
    {
        type: 'button',
        typeAttributes: {
            label: 'View Contacts',
            name: 'view_contacts',
            variant: 'brand',
            iconPosition: 'left'
        }
    }
];

const contactColumns = [
    { label: 'First Name', fieldName: 'FirstName', type: 'text' },
    { label: 'Last Name', fieldName: 'LastName', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class AccountDataTable extends LightningElement {
    @track data = [];
    @track sortedData = [];
    @track contacts = [];
    @track contactCount = 0;
    @track showContacts = false;
    columns = accountColumns;
    contactColumns = contactColumns;
    sortedBy;
    sortedDirection = 'asc';
    searchKey = '';

    connectedCallback() {
        this.loadAccounts('');
    }

    loadAccounts(key) {
        fetchAccounts({ searchKey: key })
            .then(result => {
                this.data = result;
                this.sortedData = [...result];
                this.showContacts = false;
                this.contacts = [];
                this.contactCount = 0;
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
            });
    }

    handleInputChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        this.loadAccounts(this.searchKey);
    }

    handleSort(event) {
        const { fieldName, sortDirection } = event.detail;

        this.sortedData = [...this.data].sort((a, b) => {
            const valA = a[fieldName] || '';
            const valB = b[fieldName] || '';
            return valA > valB ? 1 : valA < valB ? -1 : 0;
        });

        if (sortDirection === 'desc') {
            this.sortedData.reverse();
        }

        this.sortedBy = fieldName;
        this.sortedDirection = sortDirection;
    }

    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;

        if (action.name === 'view_contacts') {
            getContactsByAccount({ accountId: row.Id })
                .then(result => {
                    this.contacts = result;
                    this.contactCount = result.length;
                    this.showContacts = true;
                })
                .catch(error => {
                    console.error('Error fetching contacts:', error);
                });
        }
    }
}
