import { LightningElement, track, wire } from 'lwc';
import createTicket from '@salesforce/apex/CreateTicketController.createTicket';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { publish, MessageContext } from 'lightning/messageService';
import TICKET_CHANNEL from '@salesforce/messageChannel/ticketMessageChannel__c';

export default class TicketForm extends LightningElement {
    @track title = '';
    @track description = '';
    @track priority = '';
    @track assignedTo = '';

    get priorityOptions() {
        return [
            { label: 'Baixa', value: 'Low' },
            { label: 'Média', value: 'Medium' },
            { label: 'Alta', value: 'High' }
        ];
    }

    @wire(MessageContext)
    messageContext;

    handleTitleChange(event) {
        this.title = event.detail.value;
    }

    handleDescriptionChange(event) {
        this.description = event.detail.value;
    }

    handlePriorityChange(event) {
        this.priority = event.detail.value;
    }

    handleAssignedToChange(event) {
        this.assignedTo = event.detail.value;
    }

    handleUserSelected(event) {
        this.assignedTo = event.detail.userId;
    }

    get hasErrors() {
        return !this.title || !this.description || !this.priority || !this.assignedTo;
    }


    async handleSubmit() {
        try {
            await createTicket({ title: this.title, description: this.description, priority: this.priority, assignedTo: this.assignedTo });

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sucesso',
                    message: 'Chamado criado com sucesso!',
                    variant: 'success'
                })
            );

            publish(this.messageContext, TICKET_CHANNEL, {
                event: 'created'
            });

            this.title = '';
            this.description = '';
            this.priority = '';
            this.assignedTo = '';
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Erro',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
}
