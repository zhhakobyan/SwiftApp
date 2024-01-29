//
//  EmptyContentText.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import SwiftUI

struct EmptyContentText: View {
    @State var title: String
    @State var subTitle: String?
    @State var buttonTitle: String?
    var actionHandler: (() -> Void)?
    let width = 300.0
    
    var body: some View {
        VStack(alignment: .center, spacing: ProjectLayout.indent24, content: {
            Text(title)
            Text(subTitle ?? "")
            if let title = buttonTitle {
                ActionButtonView(title: title,
                                 actionHandler: {
                    actionHandler?()
                })
            }
        }).padding()
            .frame(width: width)
    }
}

struct EmptyContentText_Previews: PreviewProvider {
    @State static var title = "No internet"
    @State static var subitle = "Your network is spotty"
    @State static var buttonTitle = "Retry"

    static var previews: some View {
        EmptyContentText(title: title,
                         subTitle: subitle,
                         buttonTitle: buttonTitle).background(.gray)
    }
}

