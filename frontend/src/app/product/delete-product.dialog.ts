import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material';
import { Product } from '../models/product.model';

@Component({
    selector: 'app-delete-product-dialog',
    templateUrl: 'delete-product.dialog.html'
})
export class DeleteProductDialogComponent {

    constructor(
        @Inject(MAT_DIALOG_DATA) public product: Product) {
        }
}
