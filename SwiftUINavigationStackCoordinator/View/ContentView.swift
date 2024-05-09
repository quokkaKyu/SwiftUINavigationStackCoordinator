import SwiftUI

struct ContentView: View {
    @ObservedObject private var coordinator = Coordinator<Destination>()
    private let title = "ContentView"
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .navigationBarTitleDisplayMode(.large)
            .toolbar(content: {
                Button(action: {
                    coordinator.push(.firstView(number: 1))
                }, label: {
                    Text("FirstView")
                })
            })
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .firstView(let number): FirstView(number: number)
                case .secondView: SecondView()
                case .thirdView(let number): ThirdView(number: number)
                }
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}
