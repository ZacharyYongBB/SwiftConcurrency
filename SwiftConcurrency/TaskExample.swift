//
//  TaskExample.swift
//  SwiftConcurrency
//
//  Created by Zachary on 15/2/23.
//

import SwiftUI

class TaskExampleViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil

    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        // extremely long task hard to cancel
//         {
//            blah blah
//
//            try Task.checkCancellation()
//        }
        
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("Image returned successfully")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct TaskExampleHomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click me! 🥲") {
                    TaskExample()
                }
            }
        }
    }
    
}

struct TaskExample: View {
    
    @StateObject private var vm = TaskExampleViewModel()
//    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await vm.fetchImage()
        }
//        .onDisappear() {
//            fetchImageTask?.cancel()
//        }
//        .onAppear() {
//            fetchImageTask = Task {
//                print(Thread())
//                print(Task.currentPriority)
//                await vm.fetchImage()
//            }
//            Task {
//                print(Thread())
//                print(Task.currentPriority)
//                await vm.fetchImage2()
//            }
            
            
            
//            Task(priority: .high) {
//                try await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield()
//                print("High: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .userInitiated) {
//                print("UserInitiated: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("Medium: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .low) {
//                print("Low: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("Utility: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("Background: \(Thread()) : \(Task.currentPriority)")
//            }
            
//            Task(priority: .userInitiated) {
//                print("UserInitiated: \(Thread()) : \(Task.currentPriority)")
//
//                Task.detached {
//                    print("UserInitiated2: \(Thread()) : \(Task.currentPriority)")
//                }
//            }
            
            
            
//        }
    }
}

struct TaskExample_Previews: PreviewProvider {
    static var previews: some View {
        TaskExample()
    }
}
