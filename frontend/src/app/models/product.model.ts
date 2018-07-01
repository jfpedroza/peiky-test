export class Product {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
    store_id: number;

    constructor(params?: Product) {
        if (params) {
            this.id = params.id;
            this.name = params.name;
            this.description = params.description;
            this.price = params.price;
            this.stock = params.stock;
            this.store_id = params.store_id;
        }
    }
}

export class ProductDialogData {
    product: Product;
    editMode: boolean;
}
