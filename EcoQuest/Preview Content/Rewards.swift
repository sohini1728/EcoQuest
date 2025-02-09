//
//  Rewards.swift
//  EcoQuest
//
//  Created by Sohini Das on 2/8/25.
//

import SwiftUI

struct Rewards: View {
    var body: some View {
        VStack(spacing: 20) {
            // Page Title
            Text("Your Rewards")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            // Divider
            Divider()
                .padding(.horizontal)
            
            // Rewards List
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    RewardItem(title: "Completed First Quest", points: 10)
                    RewardItem(title: "Reached Level 2", points: 50)
                    RewardItem(title: "Completed 5 Quests", points: 100)
                    RewardItem(title: "Daily Streak - 7 Days", points: 70)
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Rewards")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// A helper view for displaying individual rewards
struct RewardItem: View {
    let title: String
    let points: Int

    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text("\(points) Points")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        Rewards()
    }
}
