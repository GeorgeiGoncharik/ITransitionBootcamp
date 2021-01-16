import Foundation
import SwiftUI

extension View {
    
    func cardLook() -> some View {
        modifier(CardLook())
    }
    
    func cardText() -> some View {
        modifier(CardText())
    }
    
    func cardAccent() -> some View {
        modifier(CardAccent())
    }
}
