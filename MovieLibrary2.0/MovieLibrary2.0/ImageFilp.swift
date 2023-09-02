//
//  ImageFlip.swift
//  MovieFinder
//
//  Created by Stephen Stefanatos on 7/26/23.
//

import SwiftUI

struct FlippingImageView: View {
    @State private var isFlipped = false
    let img: Image
    let overview: String
    let cast: [CastMember]
    var body: some View {
        VStack {
            if isFlipped {
                // Backside of the card image
                img
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
                    .border(Color.white) // Add styling for the backside image
                    
                    .opacity(0.2)
                    .overlay(
                        VStack(spacing: 0) {
                            Rectangle()
                                .frame(width: 330, height: 250)
                                .foregroundColor(.clear)
                                .overlay(
                                    VStack {
                                        Text("Overview").font(.title)
                                        Rectangle().frame(height:1)
                                            .foregroundColor(.white)
                                        ScrollView {
                                            Text(overview)
                                        }
                                        Spacer()
                                    }.padding()
                                )
                            //Spacer()
                            Rectangle()
                                .frame(width: 330, height: 250)
                                .foregroundColor(.clear)
                                .overlay(
                                    VStack {
                                        Text("Cast")
                                            .font(.title)
                                        
                                        Rectangle()
                                            .frame(height: 1)
                                            .padding(.horizontal)
                                            .foregroundColor(.white)

                                        ScrollView {
                                            LazyVGrid(columns: [GridItem(.fixed(130)), GridItem(.fixed(130))], spacing: 0) {
                                                ForEach(Array(cast.enumerated()), id: \.element.id) { (index, member) in
                                                    Text("\(member.name)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                            }
                                            .padding()
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                )
                        }
                            .foregroundColor(.white)
                    )
                    
            } else {
                // Front side of the card image
                img
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
                    .border(.white) // Add styling for the frontside image
                    
            }
        }.animation(.easeInOut(duration: 1.2))
        .rotation3DEffect(
            .degrees(isFlipped ? 360 : 0),
            axis: (x: 1, y: 0, z:0)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1.2)) {
                isFlipped.toggle()
            }
        }
    }
}
struct FlippingImageView_preview: PreviewProvider {
    static var previews: some View {
        FlippingImageView(img: Image("baby"), overview: "overview", cast: [])
    }
}

