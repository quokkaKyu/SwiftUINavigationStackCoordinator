import SwiftUI

struct ThirdView: View {
    @EnvironmentObject private var coordinator: Coordinator<Destination>
    let number: Int
    private let title = "ThirdView"
    var body: some View {
        VStack {
            Spacer()
            Text("\(number)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan)
        .navigationTitle(title)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    coordinator.popToRoot()
                }, label: {
                    Text("PopToRoot")
                })
            })
        })
        .toolbar(content: {
            Button(action: {
                coordinator.pop(to: .secondView)
            }, label: {
                Text("PopToSecondView")
            })
        })
    }
}

#Preview {
    NavigationStack {
        ThirdView(number: 3)
    }
}
