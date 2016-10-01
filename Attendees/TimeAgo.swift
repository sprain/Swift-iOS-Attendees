
// https://github.com/zemirco/swift-timeago/blob/master/swift-timeago/TimeAgo.swift

import Foundation



public func timeAgoSince(date: NSDate) -> String {
    
    let calendar = Calendar.current
    let unitFlags = Set<Calendar.Component>([.second, .minute, .hour, .day, .weekOfYear, .month, .year])
    let components = calendar.dateComponents(unitFlags, from: date as Date, to: Date())
    
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.long
    formatter.timeStyle = DateFormatter.Style.short
    
    if components.year! >= 2 {
        //return "\(components.year!) years ago"
    }
    
    if components.year! >= 1 {
        //return "Last year"
    }
    
    if components.month! >= 2 {
        //return "\(components.month) months ago"
        return formatter.string(from: date as Date)
    }
    
    if components.month! >= 1 {
        return "Last month"
    }
    
    if components.weekOfYear! >= 2 {
        return "\(components.weekOfYear!) weeks ago"
    }
    
    if components.weekOfYear! >= 1 {
        return "Last week"
    }
    
    if components.day! >= 2 {
        return "\(components.day!) days ago"
    }
    
    if components.day! >= 1 {
        return "Yesterday"
    }
    
    if components.hour! >= 2 {
        return "\(components.hour!) hours ago"
    }
    
    if components.hour! >= 1 {
        return "An hour ago"
    }
    
    if components.minute! >= 2 {
        return "\(components.minute!) minutes ago"
    }
    
    if components.minute! >= 1 {
        return "A minute ago"
    }
    
    if components.second! >= 3 {
        return "\(components.second!) seconds ago"
    }
    
    return "Just now"
    
}
