//
//  DataState.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation

enum DataState {
    case successfull
    case failed(error: Error)
    case notAvailable
}
