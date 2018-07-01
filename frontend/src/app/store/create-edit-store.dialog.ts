import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Store, StoreDialogData } from '../models/store.model';

@Component({
    selector: 'app-create-edit-store-dialog',
    templateUrl: 'create-edit-store.dialog.html'
})
export class CreateEditStoreDialogComponent {

    constructor(
        public dialogRef: MatDialogRef<CreateEditStoreDialogComponent>,
        @Inject(MAT_DIALOG_DATA) public data: StoreDialogData) {
            this.data.store = new Store(this.data.store);
        }

    onCancelClick(): void {
        this.dialogRef.close();
    }
}
