import SwiftUI

struct Landing: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
            ZStack {
                // Login Button
               
                // Background Image
                GeometryReader { geometry in
                    Image("new") // Replace "new" with your actual asset name
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea()

                
                // Foreground Content
                VStack(spacing: 15) {
                    Spacer()
                        .frame(height: 100)

                    // Email and Password Fields
                    VStack(spacing: 15) {
                        TextField("Enter email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal, 40)
                            .frame(maxWidth: 350)
                        
                        SecureField("Enter password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 40)
                            .frame(maxWidth: 350)
                        
                        Spacer()
                                                .frame(height: 125)
                        
                        Button(action: handleLogin) {
                            Rectangle() // Use a transparent rectangle
                                .frame(maxWidth: 200, maxHeight: 50) // Define the button size
                                .foregroundColor(.clear) // Make it transparent
                                .cornerRadius(10) // Optionally keep the rounded corners
                                .padding(.top, 50) // Adjust the padding to position it
                        }
                    }
                    

                 

                    // NavigationLink to Home
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView() // Invisible link
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarBackButtonHidden(true)
        }

    private func handleLogin() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in both fields."
            showAlert = true
        } else if email == "test@example.com" && password == "password123" {
            isLoggedIn = true // Trigger navigation to Home
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }
}

struct Home: View {
    @State private var xpProgress: Double = 0.8 // Example progress value
    @State private var showQuestPopup: Bool = false // State to toggle the pop-up

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                GeometryReader { geometry in
                    Image("ecorehome") // Replace "ecorehome" with your actual asset name
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea()

                VStack(spacing: geometry.size.height * 0.03) {
                    Spacer()
                        .frame(height: geometry.size.height * 0.50) // Further increase the top spacer height

                    // Button for "See your quests!"
                    Button(action: {
                        // Show pop-up when the button is clicked
                        withAnimation {
                            showQuestPopup = true
                        }
                    }) {
                        Rectangle() // Transparent rectangle for clickable area
                            .foregroundColor(.clear) // Make it transparent
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06) // Button size
                    }
                    .cornerRadius(10) // Optional: Keep rounded corners for layout consistency

                    // Button for "Find your next adventure!"
                    Button(action: {}) {
                        NavigationLink(destination: MapsView()) {
                            Rectangle() // Transparent rectangle for clickable area
                                .foregroundColor(.clear) // Make it transparent
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06) // Button size
                        }
                    }
                    .cornerRadius(10) // Optional: Keep rounded corners for layout consistency

                    Spacer()
                        .frame(height: geometry.size.height * 0.1) // Maintain some bottom balance
                }
                // Quest Pop-Up
                if showQuestPopup {
                    ZStack {
                        // Dimmed background
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showQuestPopup = false
                                }
                            }

                        // Pop-Up Content (Only Image)
                        Image("quest") // Replace "quest" with your actual image asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8)
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
}


#Preview {
    Landing()
}
