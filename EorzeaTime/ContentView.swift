import SwiftUI

struct ContentView: View {
    @State private var currentEorzeaTimeString = getEorzeaTimeString(twentyFourHourTime: false)
    @State private var twentyFourHourTime: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Eorzea Time:")
            HStack {
                Image(systemName: "clock")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(currentEorzeaTimeString)
            }
            HStack {
                Text("24 Hour Time")
                Toggle("", isOn: $twentyFourHourTime)
                    .labelsHidden()
            }
            .padding()
        }
        .onReceive(timer) { _ in
            currentEorzeaTimeString = getEorzeaTimeString(twentyFourHourTime: twentyFourHourTime)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
