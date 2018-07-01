import { Component, OnInit, ViewChild } from '@angular/core';
import { MatSort, MatTableDataSource, MatDialog } from '@angular/material';
import { Product, ProductDialogData } from '../models/product.model';
import { ProductService } from '../services/product.service';
import { CreateEditProductDialogComponent } from './create-edit-product.dialog';
import { DeleteProductDialogComponent } from './delete-product.dialog';
import { Store } from '../models/store.model';
import { StoreService } from '../services/store.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {

  @ViewChild(MatSort) sort: MatSort;
  dataSource: MatTableDataSource<Product>;
  displayedColumns = ['id', 'name', 'description', 'price', 'stock', 'options'];
  products: Product[];
  store: Store;

  constructor(
    private productService: ProductService,
    private storeService: StoreService,
    private route: ActivatedRoute,
    public dialog: MatDialog) {
    this.products = [];
  }

  ngOnInit() {
    this.storeService.getStore(+this.route.snapshot.paramMap.get('id'))
    .then(store => {
      this.store = store;
      this.loadProducts();
    })
    .catch((error: string) => alert(error));
  }

  loadProducts() {
    this.productService.getProducts(this.store.id)
    .then(products => {
      this.products = products;
      this.dataSource = new MatTableDataSource(this.products);
      this.dataSource.sort = this.sort;
    })
    .catch((error: string) => alert(error));
  }

  addProduct() {
    const dialogRef = this.dialog.open(CreateEditProductDialogComponent, {
      width: '300px',
      data: {editMode: false} as ProductDialogData
    });

    dialogRef.afterClosed().subscribe((data: ProductDialogData) => {
      if (data) {
        data.product.store_id = this.store.id;
        this.productService.createProduct(data.product)
        .then(() => {
          this.loadProducts();
        })
        .catch((error: string) => alert(error));
      }
    });
  }

  viewSales(product: Product) {
    alert('viewing...');
  }

  editProduct(product: Product) {
    const dialogRef = this.dialog.open(CreateEditProductDialogComponent, {
      width: '300px',
      data: {editMode: true, product: product} as ProductDialogData
    });

    dialogRef.afterClosed().subscribe((data: ProductDialogData) => {
      if (data) {
        this.productService.updateProduct(data.product)
        .then(() => {
          this.loadProducts();
        })
        .catch((error: string) => alert(error));
      }
    });
  }

  deleteProduct(product: Product) {
    const dialogRef = this.dialog.open(DeleteProductDialogComponent, {
      width: '300px',
      data: product
    });

    dialogRef.afterClosed().subscribe((productToDelete: Product) => {
      if (productToDelete) {
        this.productService.deleteProduct(productToDelete)
        .then(() => {
          this.loadProducts();
        })
        .catch((error: string) => alert(error));
      }
    });
  }

}
