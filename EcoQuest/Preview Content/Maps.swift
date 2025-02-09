import SwiftUI
import MapKit
import CoreLocation

struct MapsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.7692, longitude: -78.6767), // Hunt Library as starting point
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var showSidebar = false // Sidebar toggle
    @State private var searchQuery: String = "" // User input for search
    @State private var isEditing = false // To track if the search bar is active
    @State private var filterOption: String = "All" // Selected filter option
    @State private var selectedDistance: String = "" // Distance to the selected destination
    @State private var shortestETA: String = "" // Shortest ETA to the destination
    @State private var selectedDestination: CLLocationCoordinate2D? // Destination location

    let huntLibraryLocation = CLLocation(latitude: 35.7692, longitude: -78.6767) // Hunt Library coordinates
    let filterOptions = ["Fastest", "Cheapest", "All"]
    let geocoder = CLGeocoder() // Geocoder to convert address to coordinates

    var body: some View {
        ZStack {
            // Main Content
            VStack(spacing: 10) {
                // Top Navigation and Search
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        HStack {
                            // Distance and ETA Display
                            if !selectedDistance.isEmpty {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Distance: \(selectedDistance)")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                    if !shortestETA.isEmpty {
                                        Text("ETA: \(shortestETA)")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.leading, 10)
                            }

                            Spacer()

                            // Menu Button (Top Right)
                            Button(action: {
                                withAnimation {
                                    showSidebar.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 20) // Align the menu to the right

                        // Search Bar
                        HStack {
                            TextField("Search for a place", text: $searchQuery, onEditingChanged: { isEditing in
                                self.isEditing = isEditing
                            })
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !searchQuery.isEmpty {
                                        Button(action: {
                                            searchQuery = ""
                                            selectedDistance = ""
                                            shortestETA = ""
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 10)
                                        }
                                    } else {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    }
                                }
                            )
                            .padding(.horizontal)

                            // Search Button
                            Button("Search") {
                                performSearch()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, geometry.size.height * 0.02) // Push the search bar slightly down
                    }
                }
                .frame(height: 100) // Fix height of the search/navigation area

                // Map View
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Filter Picker (Bottom Section)
                Picker("Filter", selection: $filterOption) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20) // Add padding for alignment
                .padding(.bottom, 20) // Add padding to the bottom for spacing
            }

            // Sidebar Menu
            if showSidebar {
                SidebarMenu(showSidebar: $showSidebar)
            }
        }
        .navigationTitle("Search Places")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Perform a full search and calculate distance and ETA
    private func performSearch() {
        geocoder.geocodeAddressString(searchQuery) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Error finding location: \(error?.localizedDescription ?? "Unknown error")")
                selectedDistance = "Not Found"
                shortestETA = "N/A"
                return
            }

            // Update destination
            selectedDestination = location.coordinate
            region.center = location.coordinate

            // Calculate Distance
            let distanceInMeters = huntLibraryLocation.distance(from: location)
            let distanceInMiles = distanceInMeters * 0.000621371 // Convert meters to miles
            selectedDistance = String(format: "%.2f miles", distanceInMiles)

            // Calculate Shortest ETA
            let drivingSpeedMetersPerSecond = 15.0 // Approx. average driving speed
            let travelTimeInSeconds = distanceInMeters / drivingSpeedMetersPerSecond
            let travelTimeInMinutes = Int(travelTimeInSeconds / 60)
            shortestETA = "\(travelTimeInMinutes) min"
        }
    }
}
