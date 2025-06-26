import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {

    employee = {

        fname : 'Himadri',
        lname : 'Paul',
        position : 'Salesforce Developer',
        exp : 10
    }

    get EmployeeValue(){
        
        const status = this.employee.exp <=9?'Broze': this.employee.exp >=10 ?'silver':this.employee.exp >=20?'Gold':'no status';
        return status;
    }

    FullName = 'Himadri paul';

    nameChangeHandler(event){
        this.FullName = event.target.value;
    }
}