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
    case BUILD
    case QUEUE
    case STATUS
}
