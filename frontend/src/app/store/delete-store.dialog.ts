import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material';
import { Store } from '../models/store.model';

@Component({
    selector: 'app-delete-store-dialog',
    templateUrl: 'delete-store.dialog.html'
})
export class DeleteStoreDialogComponent {

    constructor(
        @Inject(MAT_DIALOG_DATA) public store: Store) {
        }
}
