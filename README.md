# SwiftUINavigationStackCoordinator

<img src="/Resource/app.gif" width="30%" height="30%"/>

## 파일구조

![structure.png](/Resource/structure.png)
 
## 코드
- ### Destination.swift

```swift
import Foundation

// 이동할 뷰 case  
enum Destination: Hashable {
    case firstView(number: Int)
    case secondView
    case thirdView(number: Int)
}
```

- ### Coordinator.swift

```swift
import Foundation
import Combine

// 뷰의 이동을 관리할 Coordinator생성
final class Coordinator<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []
    
    func push(_ path: T) {
        paths.append(path)
    }
    
    func pop() {
        paths.removeLast()
    }
    
    func pop(to: T) {
        guard let found = paths.firstIndex(where: { $0 == to }) else {
            return
        }
        
        let numToPop = (found..<paths.endIndex).count - 1
        paths.removeLast(numToPop)
    }
    
    func popToRoot() {
        paths.removeAll()
    }
}
```

- ### ContentView.swift

```swift
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
```

- ### FirstView.swift

```swift
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
```

## Reference
- https://www.curiousalgorithm.com/post/router-pattern-for-swiftui-navigation
- https://medium.com/@zuxbcvf/exploring-scalable-swiftui-navigation-30f8438e9d6d
