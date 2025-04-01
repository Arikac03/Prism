import SwiftUI
import PhotosUI

struct CreatorDetailsView: View {
    let role: String
    @State private var equipment = ""
    @State private var experience = ""
    @State private var location = ""
    @State private var selectedWork: [PhotosPickerItem] = []
    @State private var portfolioImages: [Image] = []
    let onComplete: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Complete Your \(role) Profile")
                    .font(.title2)
                    .bold()
                
                // Equipment Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Equipment")
                        .font(.headline)
                    
                    TextEditor(text: $equipment)
                        .frame(height: 100)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2))
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // Experience Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Experience")
                        .font(.headline)
                    
                    TextEditor(text: $experience)
                        .frame(height: 100)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2))
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // Location Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Location")
                        .font(.headline)
                    
                    TextField("City, State", text: $location)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // Portfolio Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Portfolio")
                        .font(.headline)
                    
                    PhotosPicker(selection: $selectedWork, maxSelectionCount: 8, matching: .images) {
                        Label("Add Work", systemImage: "photo.stack.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .foregroundColor(.purple)
                            .cornerRadius(8)
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(0..<portfolioImages.count, id: \.self) { index in
                            portfolioImages[index]
                                .resizable()
                                .scaledToFill()
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                Button {
                    onComplete()
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
        .onChange(of: selectedWork) { oldValue, newValue in
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