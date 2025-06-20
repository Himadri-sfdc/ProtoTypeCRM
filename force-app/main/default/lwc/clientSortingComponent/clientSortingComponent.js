import { LightningElement,wire } from 'lwc';
import fetchData from '@salesforce/apex/SortingController.fetchData';

 const columns  = [
        {label : 'Id' , fieldName : 'Id' , type : 'text'},
        {label : 'Name' , fieldName : 'Name' , type : 'text'},
        {label : 'Amount' , fieldName : 'Amount' , type : 'Number'}
    ];

export default class ClientSortingComponent extends LightningElement {

    data = [];
    columns = columns; 
    @wire(fetchData)
    wiredData({error,data})
    {
        if(data)
        {
            this.data = data;
            console.log(JSON.stringify(this.data));
        }
        else if(error)
        {
            console.log('Error--->'+JSON.stringify(error));
        }
    }
}