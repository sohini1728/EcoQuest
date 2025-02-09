import Foundation
import SwiftUI

struct SidebarMenu: View {
    @Binding var showSidebar: Bool

    var body: some View {
        ZStack(alignment: .trailing) {
            // Dimmed background to close sidebar
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showSidebar = false
                    }
                }

            // Sidebar Menu Content
            VStack(alignment: .leading, spacing: 20) {
                Text("Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                NavigationLink(destination: MapsView()) {
                    Label("Map", systemImage: "map")
                        .font(.headline)
                        .padding(.vertical, 10)
                }

                NavigationLink(destination: Rewards()) {
                    Label("Rewards", systemImage: "star")
                        .font(.headline)
                        .padding(.vertical, 10)
                }

                NavigationLink(destination: ProfilePage()) {
                    Label("Profile", systemImage: "person.crop.circle")
                        .font(.headline)
                        .padding(.vertical, 10)
                }

                Spacer()
            }
            .frame(maxWidth: 250)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
