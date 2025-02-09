import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                GeometryReader { geometry in
                    Image("homeScreen") // Replace "homeScreen" with the name of your image asset
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea()

                // Foreground Content
                GeometryReader { geometry in
                    VStack {
                        Spacer()

                        // Transparent Button (precise positioning, no text)
                        NavigationLink(destination: Landing()) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear) // Transparent button
                                .frame(width: 200, height: 50) // Match button size
                        }
                        // Adjust position precisely based on the design
                        .position(
                            x: geometry.size.width / 2, // Center horizontally
                            y: geometry.size.height * 0.55 // Adjust vertical position
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true) // Hides the back button
        }
    }
}

#Preview {
    ContentView()
}
