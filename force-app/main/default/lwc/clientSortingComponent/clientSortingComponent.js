
import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/SortingController.fetchData';

const columns = [
    { label: 'Id', fieldName: 'Id', type: 'text', sortable: true },
    { label: 'Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Amount', fieldName: 'Amount', type: 'number', sortable: true }
];

export default class ClientSortingComponent extends LightningElement {
    data = [];
    sortedData = [];
    columns = columns;
    sortedBy;
    sortedDirection = 'asc';

    @wire(fetchData)
    wiredData({ error, data }) {
        if (data) {
            this.data = data;
            this.sortedData = [...data];
            console.log(JSON.stringify(this.data));
        } else if (error) {
            console.error('Error:', JSON.stringify(error));
        }
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
