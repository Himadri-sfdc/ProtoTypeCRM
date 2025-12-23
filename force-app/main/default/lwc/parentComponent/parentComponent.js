import { LightningElement } from 'lwc';
export default class ParentComponent extends LightningElement {

renderedCallback()
{
    const child = this.template.querySelector('c-child-component-one');
    child.addEventListener('firedevent',(event)=>{
        alert(event.detail);
    })
}
}
