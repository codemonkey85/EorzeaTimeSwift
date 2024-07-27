import SwiftUI

struct ContentView: View {
    @State private var currentTime = getEorzeaTime(twentyFourHourTime: false)
    @State private var twentyFourHourTime: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(systemName: "clock")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("The Time in Eorzea is now:")
            Text(currentTime)
            HStack {
                Text("24 Hour Time")
                Toggle("", isOn: $twentyFourHourTime)
                    .labelsHidden()
            }
            .padding()
        }
        .onReceive(timer) { _ in
            currentTime = getEorzeaTime(twentyFourHourTime: twentyFourHourTime)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
