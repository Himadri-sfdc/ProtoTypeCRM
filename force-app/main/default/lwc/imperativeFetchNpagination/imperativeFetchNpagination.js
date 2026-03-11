
import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountContlr.getAccounts';

export default class AccountList extends LightningElement {

    accounts=[];
    searchKey='';
    pageSize=5;
    offset=0;

    columns=[
        {label:'Name',fieldName:'Name'},
        {label:'Industry',fieldName:'Industry'}
    ];

    connectedCallback(){ this.loadAccounts(); }

    loadAccounts(){
        getAccounts({searchKey:this.searchKey,limitSize:this.pageSize,offsetSize:this.offset})
        .then(res=>{this.accounts=res;});
    }

    handleSearch(e){ this.searchKey=e.target.value; this.offset=0; this.loadAccounts(); }

    nextPage(){ this.offset+=this.pageSize; this.loadAccounts(); }

    prevPage(){ if(this.offset>0){ this.offset-=this.pageSize; this.loadAccounts(); } }
}