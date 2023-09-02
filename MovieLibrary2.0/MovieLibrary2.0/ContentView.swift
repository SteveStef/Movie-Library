import SwiftUI


struct SortingData {
    var text: String
    var color: Color
}

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var selectedMovie: Movie? = nil
    @State private var isLoading: Bool = false
    @State private var noResults: Bool = false
    @State private var noResultSearch: String = ""
    @State private var sorts: [SortingData] = [SortingData(text: "New", color: .white),SortingData(text: "Rating", color: .white)]
    
    @State private var movies: [Movie] = [
//        Movie(id: "String", title: "Boss Baby", picture: "https://image.tmdb.org/t/p/original/unPB1iyEeTBcKiLg8W083rlViFH.jpg", overview: "This is the overview", cast: [CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon"),CastMember(id: "2312", name: "Conrad Vernon")], year: 2017, advisedMinimumAudienceAge: 3, imdbRating: 64, imdbVoteCount: 1232, tmdbRating: 65, youtubeTrailerVideoLink: "urlasdfasdfasdfasdf", runtime: 97, streamingInfo: ["Apple", "Prime", "Disney+", "Hulu"], seasons: 3, genres: ["Adventure"], rating: 3.4, isNew: true)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.94)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title
                    HStack {
                        SpinningStarAnimation()
                        Text("Movie Library")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    
                    // Header with Search Bar
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            TextField("Search", text: $searchText, onCommit: {
                                fetchMovieInfo()
                            })
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        }
                        .padding(.horizontal, 20)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(15)
                        
                        Spacer()
                    }
                    
                    .padding(.horizontal)
//                    HStack {
//                        Spacer()
//                        ForEach(0..<2) { i in
//                            Rectangle()
//                                .frame(width:60, height: 30)
//                                .foregroundColor(sorts[i].color)
//                                .opacity(0.2)
//                                .cornerRadius(10)
//                                .overlay(
//                                    Text("\(sorts[i].text)")
//                                        .foregroundColor(.white)
//                                        .font(.body)
//
//                                ).onTapGesture {
//                                    sortMovies(index: i)
//                                }
//                        }
//                    }.padding(.top)
//                        .padding(.trailing)
                    Spacer()
                    if noResults {
                        VStack {
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text("No movies found for: \(noResultSearch)")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    // Display Cards with Hover Effect
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 200, maximum: 200)), GridItem(.flexible(minimum: 180, maximum: 180))], spacing: 20) {
                            ForEach(movies, id: \.id) { movie in
                                MovieCard(movie: movie)
                                    
                                    .onTapGesture {
                                        selectedMovie = movie // Store the selected movie in the @State variable
                                    }
                            }
                        }
                        .padding()
                    }
                    HStack {
                        Spacer()
                        Spacer()
                    }.padding()
                    .background(Color.gray.opacity(0.5))
                }
            }.accentColor(.white)
                .sheet(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
        }
    }
    
    
    func sortMovies(index: Int) {
        //sorts[index].color = .yellow
        var tmp_movies = movies
        if index == 1 {
            tmp_movies = tmp_movies.sorted(by: { $0.rating > $1.rating })
           // sorts[0].color = .white
        } else {
            //sorts[1].color = .white
            tmp_movies = tmp_movies.sorted(by: { $0.year > $1.year })
        }
        self.movies = tmp_movies
    }
    
    func fetchMovieInfo() {
        if searchText == "" {
            noResults = true
            noResultSearch = searchText
            return
        }
        self.movies = []
        let apiKey = "31818e65d0msh509791404056ebfp13f890jsndb84eb325b10"
        let apiHost = "streaming-availability.p.rapidapi.com"
        
        let userInputEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        
        let urlString = "https://streaming-availability.p.rapidapi.com/v2/search/title?title=\(userInputEncoded)&country=us&show_type=all&output_language=en"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": apiHost
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let moviesData = jsonResult["result"] as? [[String: Any]] {
                            for movieData in moviesData {
                                var mov: Movie = Movie(id: UUID().uuidString, title: "", picture: "", overview: "", cast: [], year: 0, advisedMinimumAudienceAge: 0, imdbRating: 0, imdbVoteCount: 0, tmdbRating: 0, youtubeTrailerVideoLink: "", runtime: 0, streamingInfo: [], seasons: 0, genres: [], rating: 0, isNew: false)
                                
                                mov.title = movieData["title"] as? String ?? ""
                                mov.overview = movieData["overview"] as? String ?? ""
                                mov.imdbRating = movieData["imdbRating"] as? Int ?? 0
                                mov.runtime = movieData["runtime"] as? Int ?? 0
                                mov.year = movieData["year"] as? Int ?? 0
                                mov.isNew = mov.year == 2023
                                mov.rating = Float(mov.imdbRating) / 100.0 * 5
                                mov.advisedMinimumAudienceAge = movieData["advisedMinimumAudienceAge"] as? Int ?? 0
                                
                                if let cast = movieData["cast"] as? [String] {
                                    mov.cast = cast.map { name in
                                        CastMember(id: UUID().uuidString, name: name)
                                    }
                                }

                                if let posterURLs = movieData["posterURLs"] as? [String: Any],
                                   let original = posterURLs["original"] as? String {
                                    mov.picture = original
                                }
                                
                                if let seasons = movieData["seasons"] as? [[String: Any]] {
                                    mov.seasons = seasons.count
                                }
                                
                                if let genre = movieData["genres"] as? [[String: Any]] {
                                    
                                    for n in 0...genre.count-1 {
                                        if let g = genre[n]["name"] as? String {
                                            mov.genres.append(g)
                                        }
                                    }
                                }

                                if let streamInfo = movieData["streamingInfo"] as? [String: Any],
                                   let us = streamInfo["us"] as? [String: Any] {
                                    let streamingPlatforms: [String: String] = [
                                        "prime": "Prime",
                                        "apple": "Apple",
                                        "netflix": "Netflix",
                                        "disney": "Disney+",
                                        "hulu": "Hulu",
                                        "peacock": "Peacock",
                                        "hbo": "HBO Max"
                                    ]
                                    
                                    for (platformKey, platformName) in streamingPlatforms {
                                        if us[platformKey] != nil {
                                            mov.streamingInfo.append(platformName)
                                        }
                                    }
                                }


                                movies.append(mov)
                                
                            }
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
            if movies.count == 0 {
                noResults = true
                noResultSearch = searchText
            } else {
                noResults = false
            }
            self.isLoading = false
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
