import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn: Bool = false // State to control navigation

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Title
                Text("EcoQuest Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)

                // Email TextField
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)

                // Password SecureField
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Login Button
                Button(action: handleLogin) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()

                // NavigationLink to MapsView
                NavigationLink(
                    destination: MapsView(),
                    isActive: $isLoggedIn, // Activates when isLoggedIn is true
                    label: { EmptyView() }
                )
                .hidden() // Hide the NavigationLink from view
                
                NavigationLink(
                    destination: ProfilePage(),
                    isActive: $isLoggedIn, // Activates when isLoggedIn is true
                    label: { EmptyView() }
                )
                .hidden() // Hide the NavigationLink from view
            }
            
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Handle login button tap
    private func handleLogin() {
        // Mock login validation
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in both fields."
            showAlert = true
        } else if email == "test@example.com" && password == "password123" {
            isLoggedIn = true // Trigger navigation
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
