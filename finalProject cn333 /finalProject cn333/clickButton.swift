//
//  clickButton.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import SwiftUI

struct clickButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 350, height: 60, alignment: .center)
            .background(Color(red: 12.0 / 255.0, green: 121.0 / 255.0, blue: 150.0 / 255.0))
            .cornerRadius(10)
    }
}

struct clickButton: View {
    @Binding var textColor: Color
    var answer: String
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            self.onTap()
        }) {
            Text(answer)
                .modifier(clickButtonModifier())
                .foregroundColor(textColor)
        }
    }
}

struct clickButton_Previews: PreviewProvider {
    static var previews: some View {
        clickButton(textColor: .constant(.white), answer: "Hello", onTap: {})
    }
}

