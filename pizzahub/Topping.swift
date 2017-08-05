//
//  Topping.swift
//  Pufza
//
//  Created by Yusuf Tezel on 25/07/2017.
//  Copyright © 2017 YTE. All rights reserved.
//

import Foundation


enum PizzaSize: Int {
    case small, medium = 1
    case large = 2
    case xlarge = 3
}

class Topping {
    let id: String
    let name: String
    let initialPrice: Int
    let image: String
    let imageHighlighted: String
    let imageDisabled: String
    
    init(name: String, price: Int){
        self.id = UUID().uuidString
        self.name = name
        self.initialPrice = price
        self.image = name
        self.imageHighlighted = name + "Clicked"
        self.imageDisabled = name + "Disabled"
    }
    
    func getPrice(pizzaSize size: PizzaSize) -> Int{
        return initialPrice * size.rawValue
    }
}
