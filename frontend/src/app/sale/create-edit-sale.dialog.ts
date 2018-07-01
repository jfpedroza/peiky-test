import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Sale, SaleDialogData } from '../models/sale.model';

@Component({
    selector: 'app-create-edit-sale-dialog',
    templateUrl: 'create-edit-sale.dialog.html'
})
export class CreateEditSaleDialogComponent {

    constructor(
        public dialogRef: MatDialogRef<CreateEditSaleDialogComponent>,
        @Inject(MAT_DIALOG_DATA) public data: SaleDialogData) {
            this.data.sale = new Sale(this.data.sale);
        }

    onCancelClick(): void {
        this.dialogRef.close();
    }
}
