//
//  Models.swift
//  Chetan_iOS
//
//  Created by Chetan Kumar on 5/20/24.
//

import Foundation

struct Meal: Decodable, Identifiable{
    var idMeal: String
    var strMeal: String?
    var strMealThumb: String?
    
    var id: String { idMeal }
}


struct MealDetail: Decodable {
    var strMeal: String?
    var strInstructions: String?
    var ingredients: [String] = []
    let strMealThumb: String
    
    enum CodingKeys: String, CodingKey {
        case strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        // Dynamically fetching ingredients and measurements
        var tempIngredients = [String]()
        for i in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(rawValue: "strMeasure\(i)")!
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measurement = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty {
                tempIngredients.append("\(ingredient):    \(measurement)")
            }
        }
        ingredients = tempIngredients
    }
}
