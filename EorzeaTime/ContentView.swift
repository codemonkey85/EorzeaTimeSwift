import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var currentEorzeaTimeString = getEorzeaTimeString(twentyFourHourTime: false)
    
    @State private var twentyFourHourTime: Bool = false
    
    @State private var activity: Activity<EorzeaTimeAttributes>? = nil
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Button("Start Live Activity") {
                startLiveActivity()
            }
            
            Button("End Live Activity") {
                endLiveActivity()
            }
            
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
    
    func startLiveActivity() {
        let initialContentState = EorzeaTimeAttributes.ContentState(eorzeaTime: getEorzeaTimeString(twentyFourHourTime: true))
        let activityAttributes = EorzeaTimeAttributes(name: "Eorzea Time Tracker")
        
        do {
            activity = try Activity<EorzeaTimeAttributes>.request(
                attributes: activityAttributes,
                content: .init(state: initialContentState, staleDate: nil),
                pushType: nil
            )
            print("Live Activity started successfully")
        } catch {
            print("Error starting activity: \(error.localizedDescription)")
        }
        
        updateLiveActivity()
    }
    
    func updateLiveActivity() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            let updatedContentState = EorzeaTimeAttributes.ContentState(eorzeaTime: getEorzeaTimeString(twentyFourHourTime: true))
            
            Task {
                if let activity = await activity {
                    await activity.update(.init(state: updatedContentState, staleDate: nil))
                    print("Live Activity updated: \(updatedContentState.eorzeaTime)")
                }
            }
        }
    }
    
    func endLiveActivity() {
        Task {
            if let activity = activity {
                await activity.end(
                    .init(state: EorzeaTimeAttributes.ContentState(eorzeaTime: getEorzeaTimeString(twentyFourHourTime: true)), staleDate: nil),
                    dismissalPolicy: .immediate
                )
                print("Live Activity ended")
            }
        }
    }
}

#Preview {
    ContentView()
}
