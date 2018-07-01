import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatTableModule, MatSortModule, MatButtonModule, MatIconModule, MatToolbarModule } from '@angular/material';
import { MatDialogModule, MatFormFieldModule, MatInputModule, MatSnackBarModule } from '@angular/material';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { StoreComponent } from './store/store.component';
import { CreateEditStoreDialogComponent } from './store/create-edit-store.dialog';
import { DeleteStoreDialogComponent } from './store/delete-store.dialog';
import { CreateEditProductDialogComponent } from './product/create-edit-product.dialog';
import { DeleteProductDialogComponent } from './product/delete-product.dialog';

import { StoreService } from './services/store.service';
import { ProductComponent } from './product/product.component';
import { SaleComponent } from './sale/sale.component';
import { CreateEditSaleDialogComponent } from './sale/create-edit-sale.dialog';
import { DeleteSaleDialogComponent } from './sale/delete-sale.dialog';

@NgModule({
  declarations: [
    AppComponent,
    StoreComponent,
    CreateEditStoreDialogComponent,
    DeleteStoreDialogComponent,
    ProductComponent,
    CreateEditProductDialogComponent,
    DeleteProductDialogComponent,
    SaleComponent,
    CreateEditSaleDialogComponent,
    DeleteSaleDialogComponent
  ],
  entryComponents: [
    CreateEditStoreDialogComponent,
    DeleteStoreDialogComponent,
    CreateEditProductDialogComponent,
    DeleteProductDialogComponent,
    CreateEditSaleDialogComponent,
    DeleteSaleDialogComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule,
    FormsModule,
    BrowserAnimationsModule,
    MatTableModule, MatSortModule, MatButtonModule, MatIconModule, MatToolbarModule,
    MatDialogModule, MatFormFieldModule, MatInputModule, MatSnackBarModule
  ],
  providers: [StoreService],
  bootstrap: [AppComponent]
})
export class AppModule { }
