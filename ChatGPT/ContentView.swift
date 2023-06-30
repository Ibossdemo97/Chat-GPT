//
//  ContentView.swift
//  ChatGPT
//
//  Created by Luyện Hà Luyện on 13/01/2023.
//

import SwiftUI
import CoreData
import OpenAISwift

final class ViewModel: ObservableObject {
    init() {}
        
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
            case .failure:
                break
            }
        })
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(models, id: \.self) { string in
                Text(string)
            }
            Spacer()
            HStack {
                TextField("Type here...", text: $text)
                Button("Send") {
                    send()
                }
            }
        }
        .onAppear {
            viewModel.setup()
        }
        .padding()
    }
    func send() {
        guard text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        models.append("Me: \(text)")
        viewModel.send(text: text) { response in
            DispatchQueue.main.async {
                self.models.append("Chat GPT: "+response)
                self.text = ""
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
