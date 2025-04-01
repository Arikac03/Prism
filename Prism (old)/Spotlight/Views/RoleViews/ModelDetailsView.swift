import SwiftUI
import PhotosUI

struct ModelDetailsView: View {
    @State private var measurements = ModelMeasurements()
    @State private var location = ""
    @State private var travelRadius = "50"
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var portfolioImages: [Image] = []
    let onComplete: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Complete Your Model Profile")
                    .font(.title2)
                    .bold()
                
                // Measurements Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Measurements")
                        .font(.headline)
                    
                    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 15) {
                        GridRow {
                            MeasurementField(title: "Height", text: $measurements.height)
                            MeasurementField(title: "Bust", text: $measurements.bust)
                        }
                        GridRow {
                            MeasurementField(title: "Waist", text: $measurements.waist)
                            MeasurementField(title: "Hips", text: $measurements.hips)
                        }
                        GridRow {
                            MeasurementField(title: "Shoe Size", text: $measurements.shoes)
                            MeasurementField(title: "Hair Color", text: $measurements.hair)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // Location Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Location & Travel")
                        .font(.headline)
                    
                    TextField("City, State", text: $location)
                        .textFieldStyle(.roundedBorder)
                    
                    HStack {
                        Text("Travel Radius:")
                        Slider(value: .init(get: {
                            Double(travelRadius) ?? 50
                        }, set: { newValue in
                            travelRadius = "\(Int(newValue))"
                        }), in: 0...500, step: 25)
                        Text("\(travelRadius) miles")
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // Portfolio Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Portfolio")
                        .font(.headline)
                    
                    PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 6, matching: .images) {
                        Label("Add Photos", systemImage: "photo.stack.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .foregroundColor(.purple)
                            .cornerRadius(8)
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(0..<portfolioImages.count, id: \.self) { index in
                            portfolioImages[index]
                                .resizable()
                                .scaledToFill()
                                .frame(height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                Button {
                    // Save measurements and other data here
                    onComplete() // This will trigger the completion in OnboardingView
                } label: {
                    Text("Complete Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPhotos) { oldValue, newValue in
            Task {
                for item in newValue {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        portfolioImages.append(Image(uiImage: uiImage))
                    }
                }
            }
        }
    }
}

struct MeasurementField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(title, text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
} 