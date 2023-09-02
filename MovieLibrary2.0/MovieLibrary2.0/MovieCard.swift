import SwiftUI

struct MovieCard: View {
    let movie: Movie
    @State private var isHovered: Bool = false
    @State private var starColor: Color = .yellow

    var body: some View {
    AsyncImage(url: URL(string: movie.picture)) { image in
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 115, height: 175)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isHovered ? Color.green : Color.white, lineWidth: 2)
                        .overlay(
                            ZStack {
                                if movie.isNew {
                                    Text("New")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                        .offset(x: -50, y: -80) // Adjust the offset to position the label
                                }
                            }
                            
                        )
                )
                .padding(.bottom, 5)
            Text(movie.title)
                .foregroundColor(.white)
                .font(.headline)
                .lineLimit(1) // Limit the title to one line
                .truncationMode(.tail) // Add ... at the end if the title is longer
                .frame(width:125)
            if movie.genres.count > 0 {
                if movie.runtime == 0 {
                    Text("\(movie.genres[0])/Series")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding(.bottom, 5)
                } else {
                    Text("\(movie.genres[0])/Movie")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding(.bottom, 5)
                }
                
            }
            
            // Stars for reviews
            HStack(spacing: 5) {
                ForEach(1..<6) { index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(getStarColor(index: index))
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .onHover { hovered in
            isHovered = hovered
        }
        } placeholder: {
            
        }
    }

    func getStarColor(index: Int) -> Color {
        if Float(index) <= movie.rating {
            return .yellow
        } else if Float(index) - 0.5 <= Float(movie.rating) {
            return .yellow
        } else {
            return .gray
        }
    }
}



struct MovieCardPreview: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie(id: "String", title: "Boss Baby", picture: "https://image.tmdb.org/t/p/original/unPB1iyEeTBcKiLg8W083rlViFH.jpg", overview: "This is the overview", cast: [CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon")], year: 2017, advisedMinimumAudienceAge: 3, imdbRating: 64, imdbVoteCount: 1232, tmdbRating: 65, youtubeTrailerVideoLink: "urlasdfasdfasdfasdf", runtime: 97, streamingInfo: ["Apple", "Prime", "Disney+", "Hulu"], seasons: 3, genres: [], rating: 5, isNew: true))
    }
}
