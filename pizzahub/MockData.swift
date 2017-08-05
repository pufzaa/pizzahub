//
//  MockData.swift
//  Pufza
//
//  Created by Yusuf Tezel on 25/07/2017.
//  Copyright © 2017 YTE. All rights reserved.
//

import UIKit


let mockArray = [
    Topping(name: "Agurk", price: 3),
    Topping(name: "Ananas", price: 3),
    Topping(name: "Bacon", price: 5),
    Topping(name: "Chili", price: 0),
    Topping(name: "Dressing", price: 0),
    Topping(name: "Feta", price: 5),
    Topping(name: "Hvidløg", price: 0),
    Topping(name: "Iceberg", price: 3),
    Topping(name: "Jalapenos", price: 3),
    Topping(name: "Kebab", price: 5),
    Topping(name: "Kylling", price: 5),
    Topping(name: "Løg", price: 3),
    Topping(name: "Majs", price: 3),
    Topping(name: "Oksekød", price: 5),
    Topping(name: "Oliven", price: 3),
    Topping(name: "Ost", price: 5),
    Topping(name: "Paprika", price: 3),
    Topping(name: "Pepperoni", price: 5),
    Topping(name: "Pølser", price: 5),
    Topping(name: "Rejer", price: 5),
    Topping(name: "Skinke", price: 5),
    Topping(name: "Spaghetti", price: 3),
    Topping(name: "Tomat", price: 3),
    Topping(name: "Tun", price: 5)
]

func generateData() -> [[Topping]]{
    var toppingArray: [[Topping]] = []
    let prices = Set(mockArray.map {$0.initialPrice})
    for a in prices {
        var toppings: [Topping] = []
        for t in mockArray {
            if t.initialPrice == a {
                toppings.append(t)
            }
        }
        toppingArray.append(toppings)
    }
    return toppingArray
}
