import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { StoreComponent } from './store/store.component';
import { ProductComponent } from './product/product.component';
import { SaleComponent } from './sale/sale.component';

const routes: Routes = [
    { path: '', redirectTo: '/stores', pathMatch: 'full'},
    { path: 'stores', component: StoreComponent },
    { path: 'stores/:id/products', component: ProductComponent },
    { path: 'stores/:id/products/:productId/sales', component: SaleComponent }
];

@NgModule({
    imports: [ RouterModule.forRoot(routes) ],
    exports: [ RouterModule ]
})
export class AppRoutingModule { }
