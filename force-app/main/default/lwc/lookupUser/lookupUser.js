import { LightningElement, track } from 'lwc';
import searchUsers from '@salesforce/apex/UserLookupController.searchUsers';

export default class LookupUser extends LightningElement {
    @track searchTerm = '';
    @track results = [];

    handleSearch(event) {
        this.searchTerm = event.target.value;

        if (this.searchTerm.length >= 2) {
            searchUsers({ keyword: this.searchTerm })
                .then((data) => {
                    this.results = data;
                })
                .catch((error) => {
                    console.error('Erro ao buscar usuários:', error);
                });
        } else {
            this.results = [];
        }
    }

    handleSelect(event) {
        const userId = event.currentTarget.dataset.id;
        const userName = event.currentTarget.dataset.name;

        this.results = [];
        this.searchTerm = userName;

        this.dispatchEvent(new CustomEvent('userselected', {
            detail: { userId, userName }
        }));
    }
}
