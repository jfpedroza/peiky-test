export class Store {
    id: number;
    name: string;
    address: string;

    constructor(params?: Store) {
        if (params) {
            this.id = params.id;
            this.name = params.name;
            this.address = params.address;
        }
    }
}

export class StoreDialogData {
    store: Store;
    editMode: boolean;
}
