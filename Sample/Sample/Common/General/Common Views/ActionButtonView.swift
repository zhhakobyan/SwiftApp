//
//  ActionButtonView.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import SwiftUI

struct ActionButtonView: View {
    @State var title: String
    var cornerRadius: CGFloat?
    var font: Font?
    var imageName: String?
    var actionHandler: (() -> Void)?

    var body: some View {
        Button {
            actionHandler?()
        } label: {
            Text(title)
        }
    }
}
struct ActionButtonView_Previews: PreviewProvider {
    @State static var title = "Search"

    static var previews: some View {
        ActionButtonView(title: title)
    }
}
