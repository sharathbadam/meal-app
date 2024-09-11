//
//  ContentView.swift
//  Meal
//
//  Created by Sharath badam on 11/09/24.
//

import SwiftUI

struct MealView: View {
    
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    } else if viewModel.strError != nil {
                        Text(viewModel.strError ?? "Failed to fetch meal list")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.mealList, id: \.self) { meal in                            
                            NavigationLink {
                                MealDetailView(meal: meal)
                            } label: {
                                HStack(alignment: .center) {
                                    ZStack {
                                        if let url = URL.init(string: meal.strMealThumb) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: ContentMode.fill)
                                                    .clipped()
                                                    .frame(width: 100, height: 100)
                                            } placeholder: {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                                                    .frame(height: 100)
                                            }
                                            .frame(width: 100)
                                        }
                                    }
                                    Text(meal.strMeal)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxHeight: .infinity)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .frame(height: 100)
                                .background(Color.orange.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 16.0))
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select your meal")
        }
        .task {
            await viewModel.fetchMeal()
        }
    }
    
}

#Preview {
    MealView()
}
