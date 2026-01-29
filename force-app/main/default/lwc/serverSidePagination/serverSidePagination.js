import { LightningElement,wire,track} from 'lwc';
import getContacts from '@salesforce/apex/ContactPaginationControl.getContacts';
import getTotalContacts from '@salesforce/apex/ContactPaginationControl.getTotalContacts';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class ServerSidePagination extends LightningElement {

    columns = COLUMNS;
    pageSize = 5;
    pageNumber = 1;
    totalRecords = 0;
    totalPages = 0;
    @track data = [];

    @wire(getContacts, { pageSize: '$pageSize', pageNumber: '$pageNumber' })
    wiredContacts({ data, error }) {
        if (data) {
            this.data = data;
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getTotalContacts)
    wiredTotal({ data }) {
        if (data) {
            this.totalRecords = data;
            this.totalPages = Math.ceil(data / this.pageSize);
        }
    }

    get disablePrev() {
        return this.pageNumber === 1;
    }

    get disableNext() {
        return this.pageNumber === this.totalPages;
    }

    handleNext() {
        if (!this.disableNext) this.pageNumber++;
    }

    handlePrev() {
        if (!this.disablePrev) this.pageNumber--;
    }
}