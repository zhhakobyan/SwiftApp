//
//  SearchView.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import SwiftUI

enum FocusedField {
    case seachField
}

struct SearchView: View {
    @Binding var text: String
    var searchButtonHandler: () -> Void
    @FocusState private var focusedField: FocusedField?

    let height = 60.0
    let backgroundColor = Color.gray.opacity(0.5)
    let searchImageName = "magnifyingglass"
    let emptyPlaceholder = "search"
    
    var body: some View {
        let placeholder = $text.wrappedValue.isEmpty ? emptyPlaceholder : $text.wrappedValue
        HStack(alignment: .firstTextBaseline, spacing: ProjectLayout.indent16, content: {
            HStack(alignment: .center, spacing: ProjectLayout.indent8, content: {
                Spacer()
                SwiftUI.Image(systemName: searchImageName)
                TextField(placeholder, text: $text)
                    .focused($focusedField, equals: .seachField)
                    .modifier(ClearButton(text: $text, searchButtonHandler: searchButtonHandler))
                    .onSubmit {
                        searchButtonHandler()
                    }
            }).frame(height: height)
        }).background(backgroundColor)
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    let clearImageName = "xmark"
    var searchButtonHandler: () -> Void

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
//            if !text.isEmpty {
                Button(action: {
                    text = ""
                    searchButtonHandler()
                }, label: {
                    SwiftUI.Image(systemName: clearImageName)
                        .foregroundColor(Color.white)
                        .padding()
                })
//            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var value = "What are you looking for?"

    static var previews: some View {
       SearchView(text: $value) {}
    }
}
