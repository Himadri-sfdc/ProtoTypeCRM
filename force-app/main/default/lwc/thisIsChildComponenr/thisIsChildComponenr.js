import { LightningElement,api } from 'lwc';
export default class ThisIsChildComponenr extends LightningElement {

    message = '';
    @api
    showMessage(){
        this.message = 'child method executed successfully';
    }
}