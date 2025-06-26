import { LightningElement,wire } from 'lwc';
import getAccount from '@salesforce/apex/GetAccDetails.fetchData';

export default class ForEachLoop extends LightningElement {

    @wire(getAccount)
    accountDetails;
}