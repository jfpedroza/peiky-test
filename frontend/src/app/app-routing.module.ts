import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { StoreComponent } from './store/store.component';
import { ProductComponent } from './product/product.component';

const routes: Routes = [
    { path: '', redirectTo: '/stores', pathMatch: 'full'},
    { path: 'stores', component: StoreComponent },
    { path: 'stores/:id/products', component: ProductComponent }
];

@NgModule({
    imports: [ RouterModule.forRoot(routes) ],
    exports: [ RouterModule ]
})
export class AppRoutingModule { }
