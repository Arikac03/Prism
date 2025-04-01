import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Videographer image with fallback
            Image("videographer2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    Image(systemName: "video.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
            
            // Photographer image with fallback
            Image("photographer2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    Image(systemName: "camera.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
            
            // Model image with fallback
            Image("model2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
        }
        .padding()
    }
}

// Create a reusable image view with placeholder
struct ImageWithPlaceholder: View {
    let imageName: String
    let placeholderSystemName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                Image(systemName: placeholderSystemName)
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
            )
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 