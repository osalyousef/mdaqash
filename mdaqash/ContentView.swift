import SwiftUI
struct ContentView: View {
    
    @State private var contentViewValue = 5000.0
    @State private var betValue = 5000 // Default value that exists in bets array
    @State private var playersViewSelect = false
    
    let bets = [5000, 10000, 50000]
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(colors: [.yellow, .indigo], center: .center, startRadius: 70, endRadius: 250)
                    .ignoresSafeArea()
                VStack {
                    Spacer(minLength: 180)
                    Form {
                        Section {
                            HStack {
                                Text("الفلوس")
                                    .font(.largeTitle)
                                
                                Spacer()
                                
                                Picker("الرهان", selection: $betValue) {
                                    ForEach(bets, id: \.self) { bet in
                                        Text("\(bet)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 80)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                VStack {
                    Spacer()
                    Spacer()
                    NavigationLink(destination: play(secondViewValue: $contentViewValue)
                        .toolbarRole(.editor)
                        ) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 52.0, height: 52.0)
                    }
                    .onChange(of: betValue) {
                        updateContentViewValue()
                    }
                    Spacer(minLength: 310)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Spacer(minLength: 50)
                        Text("حاسبه مداقش")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                    }
                }
            }
            .fullScreenCover(isPresented: $playersViewSelect) {
                play(secondViewValue: $contentViewValue)
            }
        }
    }

    private func updateContentViewValue() {
        contentViewValue = Double(betValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
