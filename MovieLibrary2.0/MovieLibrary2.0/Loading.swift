

import SwiftUI


struct Loading: View {
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7) // Adjust the trim to control the length of the spinner
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 30, height: 30)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                .onAppear {
                    self.isAnimating = true
                    
                }
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
