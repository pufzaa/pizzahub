//
//  Topping.swift
//  Pufza
//
//  Created by Yusuf Tezel on 25/07/2017.
//  Copyright © 2017 YTE. All rights reserved.
//

import Foundation


class Topping : Equatable {
    let name: String
    let initialPrice: Int
    
    init(name: String, price: Int){
        self.name = name
        self.initialPrice = price
    }
    
    func getPrice(multipler: Int) -> Int{
        return initialPrice * multipler
    }
    
    public static func ==(lhs: Topping, rhs: Topping) -> Bool {
        return lhs.name == rhs.name
    }
}
