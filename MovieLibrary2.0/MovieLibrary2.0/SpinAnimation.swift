
import SwiftUI

struct SpinningStarAnimation: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Image(systemName: "camera.aperture")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}

struct StarAnimate_Previews: PreviewProvider {
    static var previews: some View {
        SpinningStarAnimation()
    }
}
