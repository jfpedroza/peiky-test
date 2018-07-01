import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Product } from '../models/product.model';
import { BaseService } from './base.service';

@Injectable({
  providedIn: 'root'
})
export class ProductService extends BaseService {

  constructor(private http: HttpClient) {
    super();
  }

  getProducts(storeId: number): Promise<Product[]> {
    return this.http.get(`${this.baseUrl}/stores/${storeId}/products`)
    .toPromise()
    .then((res: any) => {
      const data: Product[] = res.data;
      return data.map(product => new Product(product));
    })
    .catch(this.handleError);
  }

  getProduct(productId: number): Promise<Product> {
    return this.http.get(`${this.baseUrl}/products/${productId}`)
    .toPromise()
    .then((res: any) => {
      return new Product(res.data);
    })
    .catch(this.handleError);
  }

  createProduct(product: Product): Promise<Product> {
    return this.http.post(`${this.baseUrl}/stores/${product.store_id}/products`, { product: product })
    .toPromise()
    .then((res: any) => {
      return new Product(res.data);
    })
    .catch(this.handleError);
  }

  updateProduct(product: Product): Promise<Product> {
    return this.http.put(`${this.baseUrl}/products/${product.id}`, { product: product })
    .toPromise()
    .then((res: any) => {
      return new Product(res.data);
    })
    .catch(this.handleError);
  }

  deleteProduct(product: Product): Promise<any> {
    return this.http.delete(`${this.baseUrl}/products/${product.id}`)
    .toPromise()
    .then(() => {})
    .catch(this.handleError);
  }
}
