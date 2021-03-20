//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Antonio Alves on 12/23/20.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesReprensentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesReprensentation()
                }
            })
        }
        
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
