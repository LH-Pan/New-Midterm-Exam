//
//  HTTPClient.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import Foundation




enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum MyHTTPClientError: Error {
    
    case decodeDataFail
    
    case clientError(Data)
    
    case serverError
    
    case unexpectedError
}

enum MyHTTPMethod: String {
    
    case GET
    
    case POST
}

enum MyHTTPHeaderFiled: String {
    
    case contentType = "Content-Type"
    
    case accept = "Accept"
}

enum MyHTTPHeaderValue: String {
    
    case formData = "x-www-form-urlencoded"
}

protocol MyRequest {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
}

//class HTTPClient {
//
//    static let shared = HTTPClient()
//
//    func requestWithUrlencodedBody(urlString: String,
//                                   parameters: String,
//                                   completion: @escaping (Result<Data>) -> Void) {
//
////
//
//        let url = URL(string: urlString)!
//
//        var request = URLRequest(url: url)
//
//        request.httpBody = parameters.data(using: String.Encoding.utf8)
//
//        request.httpMethod = "POST"
//
//        request.setValue("x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        fetchedDataByDataTask(from: request, completion: completion)
//    }
//
//    private func fetchedDataByDataTask(from request: URLRequest,
//                               completion: @escaping (Result<Data>) -> Void ) {
//
//        URLSession.shared.dataTask(
//            with: request) {(data, response, error) in
//
//                guard error == nil else {
//
//                    return completion(Result.failure(error!))
//                }
//
//                let httpResponse = response as! HTTPURLResponse
//
//                let statusCode = httpResponse.statusCode
//
//                switch statusCode {
//
//                case 200..<300:
//
//                    guard let data = data else { return }
//
////                    completion(Result.success(data!))
//
//                case 400..<500:
//
////                    completion(Result.failure(MyHTTPClientError.clientError(data!)))
//
//                case 500..<600:
//
//                    completion(Result.failure(MyHTTPClientError.serverError))
//
//                default: return
//
//                    completion(Result.failure(MyHTTPClientError.unexpectedError))
//                }
//
//        }.resume()

//    }
//}
