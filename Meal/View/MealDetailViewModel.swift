//
//  MealDetailViewModel.swift
//  Meal
//
//  Created by Sharath badam on 11/09/24.
//

import SwiftUI

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var strError: String?
    
    func fetchMealDetail(meal: Meal) async {
        do {
            // Make a network request using the NetworkManager defined earlier
            isLoading = true
            strError = nil
            let mealDetails = try await NetworkManager.shared.request(
                urlString: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)",
                responseType: [MealDetail].self, keyPath: "meals"
            )
            if mealDetails.isEmpty {
                mealDetail = nil
                strError = "Meal details not found"
            } else {
                strError = nil
                mealDetail = mealDetails.first
            }
            isLoading = false
            
        } catch {
            print("Error in fetching : \(error)")
            
            isLoading = false
            strError = error.localizedDescription
        }
    }
}
