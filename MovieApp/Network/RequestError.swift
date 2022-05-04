//
//  RequestError.swift
//  MovieApp
//
//  Created by FIVE on 27.04.2022..
//

import Foundation
import UIKit

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
}
