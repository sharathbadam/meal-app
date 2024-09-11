//
//  MealDetailView.swift
//  Meal
//
//  Created by Sharath badam on 11/09/24.
//

import SwiftUI

struct MealDetailView: View {
    
    let meal: Meal
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                } else if viewModel.strError != nil {
                    Text(viewModel.strError ?? "Failed to fetch meal list")
                        .font(.subheadline)
                        .foregroundColor(.red)
                } else if let mealDetail = viewModel.mealDetail{
                    if let url = URL.init(string: mealDetail.strMealThumb ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                                .frame(height: 300)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    VStack {
                        HStack {
                            roundTextView(text: mealDetail.strCategory ?? "")
                            roundTextView(text: mealDetail.strArea ?? "")
                            
                            Spacer()
                            Button {
                                if let opensURL = URL.init(string: mealDetail.strYoutube ?? "") {
                                    UIApplication.shared.open(opensURL)
                                }
                            } label: {
                                Image(systemName: "video.fill")
                                    .tint(Color.red)
                            }
                        }
                        
                        Spacer()
                        Divider()
                            .background(Color.orange)
                        
                        Spacer()
                        Text("Ingredient")
                            .font(.title)
                        bulletPoint(mealDetail.strIngredient1 ?? "", mealDetail.strMeasure1 ?? "")
                        bulletPoint(mealDetail.strIngredient2 ?? "", mealDetail.strMeasure2 ?? "")
                        bulletPoint(mealDetail.strIngredient3 ?? "", mealDetail.strMeasure3 ?? "")
                        bulletPoint(mealDetail.strIngredient4 ?? "", mealDetail.strMeasure4 ?? "")
                        bulletPoint(mealDetail.strIngredient5 ?? "", mealDetail.strMeasure5 ?? "")
                        bulletPoint(mealDetail.strIngredient6 ?? "", mealDetail.strMeasure6 ?? "")
                        bulletPoint(mealDetail.strIngredient7 ?? "", mealDetail.strMeasure7 ?? "")
                        bulletPoint(mealDetail.strIngredient8 ?? "", mealDetail.strMeasure8 ?? "")
                        bulletPoint(mealDetail.strIngredient9 ?? "", mealDetail.strMeasure9 ?? "")
                        bulletPoint(mealDetail.strIngredient10 ?? "", mealDetail.strMeasure10 ?? "")
                        bulletPoint(mealDetail.strIngredient11 ?? "", mealDetail.strMeasure11 ?? "")
                        bulletPoint(mealDetail.strIngredient12 ?? "", mealDetail.strMeasure12 ?? "")
                        bulletPoint(mealDetail.strIngredient13 ?? "", mealDetail.strMeasure13 ?? "")
                        bulletPoint(mealDetail.strIngredient14 ?? "", mealDetail.strMeasure14 ?? "")
                        bulletPoint(mealDetail.strIngredient15 ?? "", mealDetail.strMeasure15 ?? "")
                        bulletPoint(mealDetail.strIngredient16 ?? "", mealDetail.strMeasure16 ?? "")
                        bulletPoint(mealDetail.strIngredient17 ?? "", mealDetail.strMeasure17 ?? "")
                        bulletPoint(mealDetail.strIngredient18 ?? "", mealDetail.strMeasure18 ?? "")
                        bulletPoint(mealDetail.strIngredient19 ?? "", mealDetail.strMeasure19 ?? "")
                        bulletPoint(mealDetail.strIngredient20 ?? "", mealDetail.strMeasure20 ?? "")
                        
                        Divider()
                            .background(Color.orange)
                        
                        Text("Instruction")
                            .font(.title)
                        Text(mealDetail.strInstructions ?? "")
                            .font(.body)
                        
                        Divider()
                            .background(Color.orange)
                    }
                    .padding()
                }
            }
            
        }
        .navigationBarTitle(Text(meal.strMeal), displayMode: .inline)
        .task {
            await viewModel.fetchMealDetail(meal: meal)
        }
    }
    
    @ViewBuilder
    private func bulletPoint(_ text: String, _ value: String) -> some View {
        if text.isEmpty {
            EmptyView()
        } else {
            HStack(alignment: .top, spacing: 5) {
                Text(text)
                    .font(.body)
                Spacer()
                Text(value)
                    .font(.body)
                    .lineLimit(nil)
            }
        }
    }
    
    @ViewBuilder
    private func roundTextView(text: String) -> some View {
        Text(text)
            .font(.caption2)
            .frame(height: 30)
            .padding(.horizontal, 8)
            .background(Color.orange.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}
