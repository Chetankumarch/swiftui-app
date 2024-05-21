//
//  NetworkManager.swift
//  Chetan_iOS
//
//  Created by Chetan Kumar on 5/20/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchMeals(completion: @escaping ([Meal]) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            let mealResponse = try? JSONDecoder().decode([String: [Meal]].self, from: data)
            if let meals = mealResponse?["meals"] {
                DispatchQueue.main.async {
                    completion(meals)
                }
            }
        }.resume()
    }
    
    
    func fetchMealDetails(mealID: String, completion: @escaping (MealDetail?) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            let detailResponse = try? JSONDecoder().decode([String: [MealDetail]].self, from: data)
            if let details = detailResponse?["meals"]?.first {
                DispatchQueue.main.async {
                    completion(details)
                }
            }
        }.resume()
    }

}


