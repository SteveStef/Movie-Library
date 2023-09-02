import SwiftUI

struct PopupView: View {
        @State private var showFilterNotification = false
        @State private var selectedFilter = "All"
        
        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    Button(action: {
                        showFilterNotification.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                
                if showFilterNotification {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showFilterNotification = false
                        }
                    
                    withAnimation {
                        VStack {
                            Text("Filter Options")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .transition(.move(edge: .bottom))
                                .onTapGesture {} // To prevent the tap from dismissing the rectangle
                            
                            Button(action: {
                                selectedFilter = "Movies"
                                showFilterNotification = false
                            }) {
                                Text("Movies")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            Divider()
                                .background(Color.white)
                            
                            Button(action: {
                                selectedFilter = "Series"
                                showFilterNotification = false
                            }) {
                                Text("Series")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            Divider()
                                .background(Color.white)
                            
                            Button(action: {
                                selectedFilter = "All"
                                showFilterNotification = false
                            }) {
                                Text("All")
                                    .foregroundColor(.red) // Highlighting "All" as a destructive action
                                    .padding()
                            }
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .transition(.move(edge: .bottom))
                    }
                }
            }
        }
    }

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
