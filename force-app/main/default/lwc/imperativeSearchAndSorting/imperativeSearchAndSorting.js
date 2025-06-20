import { LightningElement, track } from 'lwc';
import fetchData from '@salesforce/apex/SearchingSortingController.fetchData';

const columns = [
    { label: 'Id', fieldName: 'Id', type: 'text', sortable: true },
    { label: 'Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Amount', fieldName: 'Amount', type: 'number', sortable: true }
];

export default class ClientSortingComponent extends LightningElement {
    @track data = [];
    @track sortedData = [];
    columns = columns;
    sortedBy;
    sortedDirection = 'asc';
    searchKey = '';

    // On component load, show all data
    connectedCallback() {
        this.loadData('');
    }

    // Reusable method to call Apex
    loadData(key) {
        fetchData({ searchKey: key })
            .then(result => {
                this.data = result;
                this.sortedData = [...result];
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    handleInputChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        this.loadData(this.searchKey);
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
}
