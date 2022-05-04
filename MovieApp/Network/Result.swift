//
//  Result.swift
//  MovieApp
//
//  Created by FIVE on 27.04.2022..
//

import Foundation
import UIKit

enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}
