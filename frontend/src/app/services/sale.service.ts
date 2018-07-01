import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { HttpClient } from '@angular/common/http';
import { Sale } from '../models/sale.model';

@Injectable({
  providedIn: 'root'
})
export class SaleService extends BaseService {

  constructor(private http: HttpClient) {
    super();
  }

  getSales(productId: number): Promise<Sale[]> {
    return this.http.get(`${this.baseUrl}/products/${productId}/sales`)
    .toPromise()
    .then((res: any) => {
      const data: Sale[] = res.data;
      return data.map(sale => new Sale(sale));
    })
    .catch(this.handleError);
  }

  getSale(saleId: number): Promise<Sale> {
    return this.http.get(`${this.baseUrl}/sales/${saleId}`)
    .toPromise()
    .then((res: any) => {
      return new Sale(res.data);
    })
    .catch(this.handleError);
  }

  createSale(sale: Sale): Promise<Sale> {
    return this.http.post(`${this.baseUrl}/stores/${sale.store_id}/sales`, { sale: sale })
    .toPromise()
    .then((res: any) => {
      return new Sale(res.data);
    })
    .catch(this.handleError);
  }

  updateSale(sale: Sale): Promise<Sale> {
    return this.http.put(`${this.baseUrl}/sales/${sale.id}`, { sale: sale })
    .toPromise()
    .then((res: any) => {
      return new Sale(res.data);
    })
    .catch(this.handleError);
  }

  deleteSale(sale: Sale): Promise<any> {
    return this.http.delete(`${this.baseUrl}/sales/${sale.id}`)
    .toPromise()
    .then(() => {})
    .catch(this.handleError);
  }
}
