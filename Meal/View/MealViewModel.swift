//
//  MealViewModel.swift
//  Meal
//
//  Created by Sharath badam on 11/09/24.
//

import Foundation

@MainActor
class MealViewModel: ObservableObject {
    @Published var mealList: [Meal] = []
    @Published var isLoading = false
    @Published var strError: String?
    
    func fetchMeal() async {
        do {
            // Make a network request using the NetworkManager defined earlier
            isLoading = true
            strError = nil
            self.mealList = try await NetworkManager.shared.request(
                urlString: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert",
                responseType: [Meal].self, keyPath: "meals"
            )
            
            isLoading = false
            strError = nil
        } catch {
            print("Error fetching posts: \(error)")
            
            isLoading = false
            strError = error.localizedDescription
        }
    }
}
