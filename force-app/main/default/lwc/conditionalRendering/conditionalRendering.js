import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {

    flag = false;

    statuschange(event){
        this.flag = event.target.checked;
    }
}