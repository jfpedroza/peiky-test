import { HttpResponse, HttpErrorResponse } from '@angular/common/http';

export class BaseService {
    protected baseUrl = 'api/v1';

    protected handleError(errRes: HttpErrorResponse): Promise<any> {
        let errorMsg = `${errRes.status}`;
        if (errRes.error) {
          if (errRes.error.errors) {
            const errors: any[] = errRes.error.errors;
            const errorArray: string[] = [];
            for (const key of Object.keys(errors)) {
              const values: string[] = errors[key];
              errorArray.push(`${key} ${values.join(', ')}`);
            }

            const details = errorArray.join('; ');
            errorMsg += ` - ${details}`;
          }
        }

        return new Promise((resolve, reject) => {
          reject(errorMsg);
        });
    }
}
