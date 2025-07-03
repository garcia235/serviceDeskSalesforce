import { LightningElement, wire, track } from 'lwc';
import getTickets from '@salesforce/apex/TicketQueryController.getTickets';

import { subscribe, MessageContext } from 'lightning/messageService';
import TICKET_CHANNEL from '@salesforce/messageChannel/ticketMessageChannel__c';

import { refreshApex } from '@salesforce/apex';


export default class TicketList extends LightningElement {
    @track statusFilter = '';
    @track priorityFilter = '';
    @track tickets = [];
    @track sortedBy = 'CreatedDate';
    @track sortDirection = 'desc';

    @wire(MessageContext)
    messageContext;

    wiredResult;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (this.subscription) return;

        this.subscription = subscribe(this.messageContext, TICKET_CHANNEL, (message) => {
            if (message.event === 'created') {
                this.refreshTicketList();
            }
        });
    }

    columns = [
        { label: 'Título', fieldName: 'Title__c', type: 'text' },
        { label: 'Prioridade', fieldName: 'Priority__c', type: 'text' },
        { label: 'Status', fieldName: 'Status__c', type: 'text' },
        { label: 'Responsável', fieldName: 'AssignedTo__c', type: 'text' },
        { label: 'Data de Criação', fieldName: 'CreatedDate', type: 'date' }
    ];

    statusOptions = [
        { label: 'Todos', value: '' },
        { label: 'Open', value: 'Open' },
        { label: 'In Progress', value: 'In Progress' },
        { label: 'Resolved', value: 'Resolved' },
        { label: 'Closed', value: 'Closed' },
        { label: 'Cancelled', value: 'Cancelled' }
    ];

    priorityOptions = [
        { label: 'Todas', value: '' },
        { label: 'Baixa', value: 'Low' },
        { label: 'Média', value: 'Medium' },
        { label: 'Alta', value: 'High' }
    ];

    @wire(getTickets, { statusFilter: '$statusFilter', priorityFilter: '$priorityFilter' })
    wiredTickets(result) {
        this.wiredResult = result;
        if (result.data) {
            this.tickets = result.data;
        } else if (result.error) {
            console.error('Erro ao carregar chamados:', result.error);
        }
    }

    refreshTicketList() {
        if (this.wiredResult) {
            refreshApex(this.wiredResult);
        }
    }

    handleStatusChange(event) {
        this.statusFilter = event.detail.value;
    }

    handlePriorityChange(event) {
        this.priorityFilter = event.detail.value;
    }

    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
    }
}
