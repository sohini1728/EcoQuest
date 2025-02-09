import SwiftUI

struct Home: View {
    @Environment(\.presentationMode) var presentationMode // For navigating back
    @State private var xpProgress: Double = 0.8 // Example progress value

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color
                Color(red: 0.88, green: 0.95, blue: 1.0) // Light blue background
                    .ignoresSafeArea()

                VStack(spacing: geometry.size.height * 0.02) { // Adjust spacing dynamically
                    // Top Navigation
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Go back to Landing
                        }) {
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .resizable()
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("EcoQuest")
                            .font(.system(size: geometry.size.width * 0.08, weight: .bold))
                            .foregroundColor(.blue)
                        Spacer()
                        Button(action: {
                            // Add functionality for menu
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)

                    // XP Progress
                    VStack(spacing: geometry.size.height * 0.01) {
                        Text("200 XP left till the next level!")
                            .font(.system(size: geometry.size.width * 0.045))
                            .foregroundColor(.black)
                        ProgressView(value: xpProgress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .frame(width: geometry.size.width * 0.8)
                        HStack {
                            Text("Level 1")
                                .font(.caption)
                            Spacer()
                            Text("Level 2")
                                .font(.caption)
                        }
                        .frame(width: geometry.size.width * 0.8)
                    }

                    // Stats Section
                    HStack(spacing: geometry.size.width * 0.05) {
                        VStack {
                            Text("CO2 Saved:")
                                .font(.headline)
                            Text("Equivalent to 2\ntrees planted!")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                            Image(systemName: "leaf.arrow.circlepath")
                                .resizable()
                                .frame(width: geometry.size.width * 0.12, height: geometry.size.width * 0.12)
                                .foregroundColor(.green)
                        }
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)

                        VStack {
                            Text("Money saved:")
                                .font(.headline)
                            Text("$7")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .frame(width: geometry.size.width * 0.12, height: geometry.size.width * 0.12)
                                .foregroundColor(.green)
                        }
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    }

                    // Buttons
                    VStack(spacing: geometry.size.height * 0.02) {
                        Button(action: {
                            // Navigate to the Quests page
                        }) {
                            HStack {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.white)
                                Text("See your quests!")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }

                        Button(action: {
                            // Navigate to the Adventure page
                        }) {
                            HStack {
                                Text("Find your next adventure!")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.right.2")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }

                    Spacer()
                }
                .padding(.top, geometry.size.height * 0.02)
            }
        }
    }
}

#Preview {
    Home()
}
