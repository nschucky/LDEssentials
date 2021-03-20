//
//  HTTPURLResponse+StatusCode.swift
//  LDEssentialsTests
//
//  Created by Antonio Alves on 3/20/21.
//

import Foundation

 extension HTTPURLResponse {
     private static var OK_200: Int { return 200 }

     var isOK: Bool {
         return statusCode == HTTPURLResponse.OK_200
     }
 }
