import SwiftUI
import MapKit
import CoreLocation

struct MapsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.7692, longitude: -78.6767), // Hunt Library as starting point
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var searchQuery: String = "" // User input for search
    @State private var destination: MapLocation? // Selected destination
    @State private var distanceFromCurrentLocation: String = "" // Distance in miles
    @State private var userLocation: CLLocation? = CLLocation(latitude: 35.7692, longitude: -78.6767) // Default user location
    @State private var searchResults: [MKLocalSearchCompletion] = [] // Autofill suggestions
    @State private var isEditing = false // To track if the search bar is active

    private let searchCompleter = MKLocalSearchCompleter() // Autocomplete search completer

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 10) {
                    // Search Bar with a "Search" Button
                    HStack {
                        TextField("Search for a place", text: $searchQuery, onEditingChanged: { isEditing in
                            self.isEditing = isEditing
                            updateSearchSuggestions()
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
                                        searchResults = []
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

                    // Suggestions List
                    if isEditing && !searchResults.isEmpty {
                        List(searchResults, id: \.title) { result in
                            Button(action: {
                                autofillSearch(result)
                                selectSuggestion(result)
                            }) {
                                VStack(alignment: .leading) {
                                    Text(result.title)
                                        .font(.headline)
                                    if !result.subtitle.isEmpty {
                                        Text(result.subtitle)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                    }

                    // Map View
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: destination == nil ? [] : [destination!]) { location in
                        MapMarker(coordinate: location.coordinate, tint: .red)
                    }
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // Distance Display
                    if let _ = destination {
                        Text("Distance: \(distanceFromCurrentLocation)")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top)
                    }

                    Spacer()
                }
                .navigationTitle("Search Places")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    configureSearchCompleter()
                }
            }
        }
    }

    // Configure MKLocalSearchCompleter
    private func configureSearchCompleter() {
        searchCompleter.delegate = SearchCompleterDelegate { results in
            DispatchQueue.main.async {
                self.searchResults = results
            }
        }
    }

    // Update suggestions based on query
    private func updateSearchSuggestions() {
        searchCompleter.queryFragment = searchQuery
    }

    // Autofill the search query with the selected suggestion
    private func autofillSearch(_ suggestion: MKLocalSearchCompletion) {
        searchQuery = suggestion.title // Fill the search bar with the selected suggestion
        isEditing = false // Close the suggestion list
    }

    // Perform a full search on button press
    private func performSearch() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchQuery

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, let item = response.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            destination = MapLocation(coordinate: coordinate)
            region.center = coordinate

            // Calculate distance
            if let userLocation = userLocation {
                let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distanceInMeters = userLocation.distance(from: destinationLocation)
                distanceFromCurrentLocation = formatDistance(distanceInMeters)
            } else {
                distanceFromCurrentLocation = "Location not available"
            }
        }
    }

    // Handle suggestion selection
    private func selectSuggestion(_ suggestion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, let item = response.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            destination = MapLocation(coordinate: coordinate)
            region.center = coordinate

            // Calculate distance
            if let userLocation = userLocation {
                let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distanceInMeters = userLocation.distance(from: destinationLocation)
                distanceFromCurrentLocation = formatDistance(distanceInMeters)
            } else {
                distanceFromCurrentLocation = "Location not available"
            }
        }
    }

    // Format distance in miles
    private func formatDistance(_ distanceInMeters: CLLocationDistance) -> String {
        let distanceInMiles = distanceInMeters * 0.000621371 // Convert meters to miles
        return String(format: "%.2f miles", distanceInMiles)
    }
}

// Struct for Identifiable Map Locations
struct MapLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

// Custom Delegate for Search Completer
class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    private let updateHandler: ([MKLocalSearchCompletion]) -> Void

    init(updateHandler: @escaping ([MKLocalSearchCompletion]) -> Void) {
        self.updateHandler = updateHandler
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        updateHandler(completer.results)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error with search completer: \(error.localizedDescription)")
    }
}
