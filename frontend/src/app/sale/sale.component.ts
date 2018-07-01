import { Component, OnInit, ViewChild } from '@angular/core';
import { MatSort, MatTableDataSource, MatDialog, MatSnackBar } from '@angular/material';
import { Sale, SaleDialogData } from '../models/sale.model';
import { Product } from '../models/product.model';
import { SaleService } from '../services/sale.service';
import { ProductService } from '../services/product.service';
import { ActivatedRoute } from '@angular/router';
import { StoreService } from '../services/store.service';
import { Store } from '../models/store.model';
import { DeleteSaleDialogComponent } from './delete-sale.dialog';
import { CreateEditSaleDialogComponent } from './create-edit-sale.dialog';

@Component({
  selector: 'app-sale',
  templateUrl: './sale.component.html',
  styleUrls: ['./sale.component.css']
})
export class SaleComponent implements OnInit {

  @ViewChild(MatSort) sort: MatSort;
  dataSource: MatTableDataSource<Sale>;
  displayedColumns = ['id', 'client_name', 'price', 'purchase_date', 'options'];
  sales: Sale[];
  product: Product;
  store: Store;

  constructor(
    private saleService: SaleService,
    private productService: ProductService,
    private storeService: StoreService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    private snackBar: MatSnackBar) {
    this.sales = [];
  }

  ngOnInit() {
    this.storeService.getStore(+this.route.snapshot.paramMap.get('id'))
    .then(store => {
      this.store = store;
    })
    .then(() => {
      return this.productService.getProduct(+this.route.snapshot.paramMap.get('productId'));
    })
    .then(product => {
      this.product = product;
      this.loadSales();
    })
    .catch((error: string) => {
      this.snackBar.open(`Error: ${error}`, '', {
        duration: 2000
      });
    });
  }

  loadSales() {
    this.saleService.getSales(this.product.id)
    .then(sales => {
      this.sales = sales;
      this.dataSource = new MatTableDataSource(this.sales);
      this.dataSource.sort = this.sort;
    })
    .catch((error: string) => {
      this.snackBar.open(`Error: ${error}`, '', {
        duration: 2000
      });
    });
  }

  addSale() {
    const dialogRef = this.dialog.open(CreateEditSaleDialogComponent, {
      width: '300px',
      data: {editMode: false, product: this.product} as SaleDialogData
    });

    dialogRef.afterClosed().subscribe((data: SaleDialogData) => {
      if (data) {
        data.sale.product_id = this.product.id;
        data.sale.store_id = this.product.store_id;
        data.sale.price = this.product.price;
        data.sale.purchase_date = (new Date()).toISOString();

        this.saleService.createSale(data.sale)
        .then(() => {
          this.product.stock--;
          this.loadSales();
        })
        .catch((error: string) => {
          this.snackBar.open(`Error: ${error}`, '', {
            duration: 2000
          });
        });
      }
    });
  }

  editSale(sale: Sale) {
    const dialogRef = this.dialog.open(CreateEditSaleDialogComponent, {
      width: '300px',
      data: {editMode: true, sale: sale, product: this.product} as SaleDialogData
    });

    dialogRef.afterClosed().subscribe((data: SaleDialogData) => {
      if (data) {
        this.saleService.updateSale(data.sale)
        .then(() => {
          this.loadSales();
        })
        .catch((error: string) => {
          this.snackBar.open(`Error: ${error}`, '', {
            duration: 2000
          });
        });
      }
    });
  }

  deleteSale(sale: Sale) {
    const dialogRef = this.dialog.open(DeleteSaleDialogComponent, {
      width: '300px',
      data: sale
    });

    dialogRef.afterClosed().subscribe((saleToDelete: Sale) => {
      if (saleToDelete) {
        this.saleService.deleteSale(saleToDelete)
        .then(() => {
          this.loadSales();
        })
        .catch((error: string) => {
          this.snackBar.open(`Error: ${error}`, '', {
            duration: 2000
          });
        });
      }
    });
  }

}
