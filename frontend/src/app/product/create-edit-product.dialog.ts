import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Product, ProductDialogData } from '../models/product.model';

@Component({
    selector: 'app-create-edit-product-dialog',
    templateUrl: 'create-edit-product.dialog.html'
})
export class CreateEditProductDialogComponent {

    constructor(
        public dialogRef: MatDialogRef<CreateEditProductDialogComponent>,
        @Inject(MAT_DIALOG_DATA) public data: ProductDialogData) {
            this.data.product = new Product(this.data.product);
        }

    onCancelClick(): void {
        this.dialogRef.close();
    }
}
