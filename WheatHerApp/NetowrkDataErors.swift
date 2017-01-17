//
//  NetowrkDataErors.swift
//  WheatHerApp
//
//  Created by Student on 1/14/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

public enum NetworkDataErrors : Error {
    case NOInternetConnection
    case TroubleGettingData(errorMsg: String)
}
