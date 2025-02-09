import SwiftUI

struct ProfilePage: View {
    @State private var showSidebar = false // State to toggle sidebar
    @Environment(\.presentationMode) var presentationMode // For navigating back

    var body: some View {
        ZStack {
            // Background Image
            GeometryReader { geometry in
                Image("profile") // Replace "profile" with your actual asset name
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()

            // Top Navigation
            VStack {
                HStack {
                    // Back Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }

                    Spacer()

                    // Sidebar Toggle Button
                    Button(action: {
                        withAnimation {
                            showSidebar.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20) // Adjust for safe area padding
                Spacer()
            }

            // Sidebar Menu (Right Side)
            if showSidebar {
                SidebarMenu(showSidebar: $showSidebar)
            }
        }
    }
}

#Preview {
    ProfilePage()
}
