import Foundation
import SwiftUI

struct CardLook: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .foregroundColor(.textColor)
            .background(colorScheme == .light ? Color.lightBackground : Color.textColor)
            .cornerRadius(25)
            .shadow(color: colorScheme == .light ? Color.lightShadow :  Color.lightShadow.opacity(0.3), radius: 12, x: -7, y: -7)
            .shadow(color: colorScheme == .light ? Color.darkShadow : Color.black.opacity(0.5), radius: 12, x: 7, y: 7)
    }
}
