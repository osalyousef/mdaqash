import SwiftUI
import TextFieldStepper

struct play: View {
    
    let x = Image(systemName: "ev.plug.dc.chademo.fill")
    let image = Image(systemName: "plus.circle.fill")
    let config = TextFieldStepperConfig(
        increment: 500,
        maximum: 1_000_000,
        valueColor: .black
    )
    let config2 = TextFieldStepperConfig(
        increment: 500,
        maximum: 1_000_000,
        valueColor: .red
    )
    
    @Binding var secondViewValue: Double
    @State var defaultValue = 0.0
    @State var minusValue = 0.0
    
    
    @State private var showError = false
    @State private var showHighBetAlert = false
    @State private var isMax = false

    
    @State private var betss = [Double]()
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(colors: [.red, .indigo], center: .center, startRadius: 70, endRadius: 230)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Spacer(minLength: 330)
                    HStack {
                        Text("الفلوس: \(secondViewValue.formatted())")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                        Button(action: {
                            for _ in 1..<(betss.count) {
                                let yy = betss[1]
                                secondViewValue = yy
                            }
                            
                        }) {
                            Image(systemName: "arrow.uturn.left")
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                                .foregroundStyle(Color.white)
                            
                        }
                    }
                    Spacer(minLength: 600)
                }
                VStack {
                        Section {
                            TextFieldStepper(
                                doubleValue: $defaultValue,
                                unit: "$",
                                label: "كم داقشت؟",
                                config: config
                            )
                            .closeKeyboard(on: .All)
                        }
                        .padding(5)
                        .background(Color.white)
                        .frame(width: 300)
                        .clipShape(Capsule())
                        
                        Section {
                            TextFieldStepper(
                                doubleValue: $minusValue,
                                unit: "-",
                                label: "كم تعطيهم؟",
                                config: config2
                            )
                            .closeKeyboard(on: .All)
                            .padding(5)
                            .background(Color.white)
                            .frame(width: 300)
                            .clipShape(Capsule())
                        }
                        HStack {
                                Button(action: {
                                    let xx = (secondViewValue + defaultValue) - minusValue
                                    secondViewValue = xx
                                    defaultValue = 0
                                    minusValue = 0
                                    betss.insert(secondViewValue, at: 0)
                                    
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 52.0, height: 52.0)
                                        .foregroundStyle(.mint)
                                }
                            }
                        
                        VStack(alignment: .trailing) {
                                                            }
                        
                            Button(action: {
                                showHighBetAlert = true
                            }) {
                                Text("")
                            }
                            .alert("وصلت مليون !" , isPresented: $showError) {
                                NavigationLink(destination: ContentView()) {
                                    Text("ارجع للقائمة")
                                }
                            }
                            .alert(isPresented: $showHighBetAlert) {
                                Alert(title: Text("High Bet Alert!"), message: Text("You've reached 1 million or more. Are you sure you want to proceed?"), primaryButton: .default(Text("Continue"), action: {
                                    // Add action to perform if user confirms high bet
                                }), secondaryButton: .cancel())
                            
                        }
                    }      
                }
            }
        }
    }
struct Play_Previews: PreviewProvider {
    static var previews: some View {
        play(secondViewValue: .constant(6000))
    }
}
