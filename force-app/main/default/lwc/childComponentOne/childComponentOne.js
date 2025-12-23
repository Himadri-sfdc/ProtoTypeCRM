import { LightningElement } from 'lwc';
export default class ChildComponentOne extends LightningElement {

    fireEvent()
    {
        const eventData = new CustomEvent("firedevent",{detail : 'Passed Details From Child Via EventListner'});
        this.dispatchEvent(eventData);
    }
}