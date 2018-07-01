import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material';
import { Sale } from '../models/sale.model';

@Component({
    selector: 'app-delete-sale-dialog',
    templateUrl: 'delete-sale.dialog.html'
})
export class DeleteSaleDialogComponent {

    constructor(
        @Inject(MAT_DIALOG_DATA) public sale: Sale) {
        }
}
