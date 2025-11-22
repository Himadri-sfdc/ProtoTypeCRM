
// accountList.js
import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountList extends LightningElement {
    @wire(getAccounts)
    accounts; // yahan data aur error dono milenge

    get hasData() {
        return this.accounts && this.accounts.data;
    }
}
