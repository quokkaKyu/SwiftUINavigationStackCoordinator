import SwiftUI

struct SecondView: View {
    @EnvironmentObject private var coordinator: Coordinator<Destination>
    private let title = "SecondView"
    var body: some View {
        VStack {
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brown)
        .navigationTitle(title)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    coordinator.push(.thirdView(number: 3))
                }, label: {
                    Text("ThirdView")
                })
            })
        })
    }
}

#Preview {
    NavigationStack {
        SecondView()
    }
}
