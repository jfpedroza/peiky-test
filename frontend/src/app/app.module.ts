import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatTableModule, MatSortModule, MatButtonModule, MatIconModule, MatToolbarModule } from '@angular/material';
import { MatDialogModule, MatFormFieldModule, MatInputModule } from '@angular/material';

import { AppComponent } from './app.component';
import { StoreComponent } from './store/store.component';
import { CreateEditStoreDialogComponent } from './store/create-edit-store.dialog';
import { DeleteStoreDialogComponent } from './store/delete-store.dialog';

import { StoreService } from './services/store.service';

@NgModule({
  declarations: [
    AppComponent,
    StoreComponent,
    CreateEditStoreDialogComponent,
    DeleteStoreDialogComponent
  ],
  entryComponents: [
    CreateEditStoreDialogComponent,
    DeleteStoreDialogComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    RouterModule,
    FormsModule,
    BrowserAnimationsModule,
    MatTableModule, MatSortModule, MatButtonModule, MatIconModule, MatToolbarModule,
    MatDialogModule, MatFormFieldModule, MatInputModule
  ],
  providers: [StoreService],
  bootstrap: [AppComponent]
})
export class AppModule { }
