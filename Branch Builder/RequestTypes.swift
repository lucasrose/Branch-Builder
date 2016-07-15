//
//  RequestTypes.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/13/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//

import Foundation

enum HTTPType: String {
    case GET = "GET"
    case POST = "POST"
}

enum RequestType {
    case BUILD_BRANCH
    case GET_BUILD_INFORMATION
    case GET_STATUS_OF_BUILD
    case GET_STATUS_OF_TESTS
}
