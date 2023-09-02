//
//  MovieDetailView.swift
//  MovieFinder
//
//  Created by Stephen Stefanatos on 7/25/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.3)
            VStack {
                AsyncImage(url: URL(string: movie.picture)) { image in
                    VStack(spacing: 0) {
                        HStack(spacing:0) {
                            Spacer()
                            FlippingImageView(img: image, overview: movie.overview, cast: movie.cast)
                            Spacer()
                        }
                        
                        
                        VStack(spacing:0) {
                            Rectangle()
                                .frame(width: 335, height: 40)
                                .foregroundColor(.black)
                                .overlay(
                                    HStack {
                                        if movie.year != 0 {
                                            Text("\"\(movie.title)\" (\(String(movie.year)))")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        } else {
                                            Text("\"\(movie.title)\"")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        }
                                        
                                    }
                                )
                            Rectangle()
                                .frame(width: 335, height: 80)
                                .foregroundColor(.black)
                                .opacity(0.4)
                                .overlay(
                                    HStack {
                                        Image("IMDb")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height:50)
                                            .border(.white)
                                        Text("\(movie.imdbRating)%")
                                        Rectangle().frame(width: 1, height: 70)
                                        
                                        if movie.advisedMinimumAudienceAge == -1 {
                                            Text("NA")
                                        } else {
                                            Text("\(movie.advisedMinimumAudienceAge)+")
                                        }
                                        
                                        Rectangle().frame(width: 1, height: 70)
                                        
                                        if movie.runtime != 0 {
                                            Text("\(movie.runtime) minutes")
                                        } else {
                                            Text("\(movie.seasons) Seasons")
                                        }
                                        
                                        
                                        
                                    }.foregroundColor(.white)
                                )
                            Rectangle()
                                .frame(width: 335, height: 30)
                                .foregroundColor(.black)
                                
                                .overlay(
                                    HStack {
                                        if movie.streamingInfo.count == 0 {
                                            Text("Not on any streaming platforms").foregroundColor(.white)
                                        }
                                        ForEach(movie.streamingInfo, id: \.self) { streamingService in
                                            Text("\(streamingService)").foregroundColor(.white)
                                                .font(.headline)
                                        }
                                    }
                                )
                        }
                        
                    }.padding(.vertical)
                    } placeholder: {
                        Loading()
                    }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(id: "String", title: "Boss Baby", picture: "https://image.tmdb.org/t/p/original/unPB1iyEeTBcKiLg8W083rlViFH.jpg", overview: "This is the overview", cast: [CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon")], year: 2017, advisedMinimumAudienceAge: 3, imdbRating: 64, imdbVoteCount: 1232, tmdbRating: 65, youtubeTrailerVideoLink: "urlasdfasdfasdfasdf", runtime: 97, streamingInfo: ["Apple", "Prime", "Disney+", "Hulu"], seasons: 3, genres: ["Action/Adventure"], rating: 5, isNew: true))
    }
}
