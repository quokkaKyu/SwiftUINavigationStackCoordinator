import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var coordinator: Coordinator<Destination>
    private let title = "FirstView"
    let number: Int
    var body: some View {
        VStack {
            Text("\(number)")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondary)
        .navigationTitle(title)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    coordinator.push(.secondView)
                }, label: {
                    Text("SecondView")
                })
            })
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    coordinator.pop()
                }, label: {
                    Text("ContentView")
                })
            })
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        FirstView(number: 1)
    }
}
