//
//  APIService.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func request<T: Mappable>(url: String) -> Observable<T> {
        return Observable.create { observer in
            AF.request(url, parameters: [:], encoding: URLEncoding.default)
                .validate(statusCode: 200 ..< 300)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let data):
                        if let object = Mapper<T>().map(JSONObject: data) {
                            observer.onNext(object)
                            observer.onCompleted()
                        } else if let array = Mapper<T>().mapArray(JSONObject: data) {
                            for item in array {
                                observer.onNext(item)
                            }
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
