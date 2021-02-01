import Foundation

extension Optional where Wrapped == Date {
    var withAgo: String{
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.day, .hour, .minute, .second]
         
        if let published = self {
            let outputString = formatter.string(from: published, to: Date())!
            return outputString + " ago"
        }
        return "recently"
    }
}
