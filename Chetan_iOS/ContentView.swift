//
//  ContentView.swift
//  Chetan_iOS
//
//  Created by Chetan Kumar on 5/17/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @State private var meals: [Meal] = []

    var body: some View {
        NavigationView {
            List(meals, id: \.idMeal) { meal in  // Ensure unique identification for List
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    Text(meal.strMeal ?? "Unknown Meal").padding([.top, .leading, .trailing])
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                NetworkManager.shared.fetchMeals { fetchedMeals in
                    meals = fetchedMeals.sorted { $0.strMeal ?? "" < $1.strMeal ?? "" }
                }
            }
        }
    }
}

struct MealDetailView: View {
    var mealID: String
    @State private var mealDetail: MealDetail?

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                if let mealDetail = mealDetail {
                    Text(mealDetail.strMeal ?? "No Meal Name")
                        .font(.title).padding([.leading, .bottom])
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                             .scaledToFit()
                             .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    Text(mealDetail.strInstructions ?? "No Instructions")
                        .font(.body)
                        .multilineTextAlignment( .leading)
                        .lineLimit(nil)
                        .padding(.leading)
                    Text("Ingredients/Measurements").font(.title).padding([.top, .leading])
                    ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .padding([.top, .leading])
                    }
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                NetworkManager.shared.fetchMealDetails(mealID: mealID) { fetchedDetails in
                    mealDetail = fetchedDetails
                }
            }
        }
    }
}

// Uncomment to use in your App's main entry point
//@main
//struct DessertRecipesApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
