import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Store } from '../models/store.model';
import { BaseService } from './base.service';

@Injectable({
  providedIn: 'root'
})
export class StoreService extends BaseService {

  constructor(private http: HttpClient) {
    super();
  }

  getStores(): Promise<Store[]> {
    return this.http.get(`${this.baseUrl}/stores`)
    .toPromise()
    .then((res: any) => {
      const data: Store[] = res.data;
      return data.map(store => new Store(store));
    })
    .catch(this.handleError);
  }

  getStore(storeId: number): Promise<Store> {
    return this.http.get(`${this.baseUrl}/stores/${storeId}`)
    .toPromise()
    .then((res: any) => {
      return new Store(res.data);
    })
    .catch(this.handleError);
  }

  createStore(store: Store): Promise<Store> {
    return this.http.post(`${this.baseUrl}/stores`, { store: store })
    .toPromise()
    .then((res: any) => {
      return new Store(res.data);
    })
    .catch(this.handleError);
  }

  updateStore(store: Store): Promise<Store> {
    return this.http.put(`${this.baseUrl}/stores/${store.id}`, { store: store })
    .toPromise()
    .then((res: any) => {
      return new Store(res.data);
    })
    .catch(this.handleError);
  }

  deleteStore(store: Store): Promise<any> {
    return this.http.delete(`${this.baseUrl}/stores/${store.id}`)
    .toPromise()
    .then(() => {})
    .catch(this.handleError);
  }
}
