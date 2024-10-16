import SwiftUI

struct BannerView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(8)
                .shadow(radius: 5)
        }
        .padding([.top, .horizontal])
        .transition(.move(edge: .top).combined(with: .opacity))
        .animation(.easeInOut, value: message)
    }
}
