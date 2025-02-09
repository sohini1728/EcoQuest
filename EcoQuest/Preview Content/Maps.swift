import SwiftUI
import MapKit

struct MapsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.7847, longitude: -78.6821),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var searchQuery: String = ""
    @State private var filterSelection: String = "All"
    @State private var showSidebar = false // State to toggle sidebar

    let filters = ["All", "Cheapest", "Fastest"]

    var body: some View {
        ZStack {
            // Main Map Content
            VStack(spacing: 10) {
                // Search Bar
                HStack {
                    TextField("Search", text: $searchQuery)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )
                        .padding(.horizontal)
                }

                // Map View
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Filter Dropdown
                HStack {
                    Text("Filter")
                        .font(.headline)
                    Spacer()
                    Picker("Filter", selection: $filterSelection) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 150)
                    .padding(.trailing)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Map Filter")
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
