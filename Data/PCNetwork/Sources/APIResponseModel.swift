//
//  APIResponseModel.swift
//  PCNetwork
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI

struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let message: String
    let data: T
}
