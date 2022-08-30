//
//  Furniture.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 26/08/22.
//

import SwiftUI

struct Furniture: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var image: String
    var subtitle: String
    var prize: String
}

// MARK: - Example Data
var furnitures: [Furniture] = [
    Furniture(title: "Mueble 1", image: "furniture1", subtitle: "Descripcion 1 - Este es el ejemplo de un primer mueboe que tiene un texto bastante grande en la descripcion, y poder ver en varias lineas su comportamiento", prize: "$1500"),
    
    Furniture(title: "Mueble 2 - este es otro titulo que contiene varias linea", image: "furniture2", subtitle: "Descripcion 2", prize: "$2700"),
    
    Furniture(title: "Mueble 3", image: "furniture3", subtitle: "Descripcion 3", prize: "$750"),
    
    Furniture(title: "Mueble 4", image: "furniture4", subtitle: "Descripcion 4", prize: "$3500"),
    
    Furniture(title: "Mueble 5", image: "furniture5", subtitle: "Descripcion 5", prize: "$450")
]
