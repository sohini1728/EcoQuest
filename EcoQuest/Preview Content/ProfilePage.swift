//
//  ProfilePage.swift
//  EcoQuest
//
//  Created by Sohini Das on 2/8/25.
//
import Foundation
import SwiftUI

struct ProfilePage: View {
    @State private var showSidebar = false // State to toggle sidebar

    var body: some View {
        ZStack {
            // Main Profile Content
            VStack(spacing: 20) {
                // Profile Image
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                    .padding(.top, 40)

                // Username
                Text("Your Name")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Level Info
                Text("Level: 1")
                    .font(.headline)
                    .foregroundColor(.gray)

                Divider()
                    .padding(.vertical, 20)

                // Rewards Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Rewards")
                        .font(.title2)
                        .fontWeight(.bold)

                    // Example Rewards List
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("10 Points - Completed First Quest")
                        }
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("50 Points - Reached Level 2")
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Sidebar Toggle Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            showSidebar.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }

            // Sidebar Menu (Right Side)
            if showSidebar {
                SidebarMenu(showSidebar: $showSidebar)
            }
        }
    }
}
