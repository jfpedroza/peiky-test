import { Product } from './product.model';

export class Sale {
    id: number;
    purchase_date: string;
    client_name: string;
    price: number;
    product_id: number;
    store_id: number;

    constructor(params?: Sale) {
        if (params) {
            this.id = params.id;
            this.purchase_date = params.purchase_date;
            this.client_name = params.client_name;
            this.price = params.price;
            this.product_id = params.product_id;
            this.store_id = params.store_id;
        }
    }
}

export class SaleDialogData {
    sale: Sale;
    product: Product;
    editMode: boolean;
}
