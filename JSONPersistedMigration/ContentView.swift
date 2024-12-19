//
//  ContentView.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var person: Person?// = .sample
    let userDefaultsManager = appSingletons.userDefaultsManager
    func fetch() {
        guard let person = userDefaultsManager.get(Person.self, forKey: UserDefaultsManager.key.person) else { return }
        self.person = person
    }
    
    func persist() {
        let person: Person = .sample
        do {
            try userDefaultsManager.set(person, forKey: UserDefaultsManager.key.person)
        } catch {
            print("Error fetching: \(error)")
        }

    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("name: \(viewModel.person?.name ?? "")")
            Text("age: \(viewModel.person?.age ?? "")")
            Text("email:\(viewModel.person?.email ?? "")")
            Button {
                viewModel.persist()
            } label: {
                Text("Persist Model")
            }
            .padding()
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
        }
        .padding()
        .task {
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
