//
//  Grouping.swift
//  Zadatak1
//
//  Created by David Horvat on 24.04.2022..
//

import Foundation
import UIKit

struct MonthSection: Comparable {
    var month: Date
    var transactions: [Transactions]
}

extension MonthSection {
    
    static func < (lhs: MonthSection, rhs: MonthSection) -> Bool {
        lhs.month < rhs.month
    }
    
    static func == (lhs: MonthSection, rhs: MonthSection) -> Bool {
        lhs.month == rhs.month
    }
    
    static func groupTransactions(transactions: [Transactions]) -> [MonthSection] {
        let groups = Dictionary(grouping: transactions) { (transaction) -> Date in
            return firstDayOfMonth(date: parseDate(transaction.date))
        }
        
       return groups.map(MonthSection.init(month:transactions:)).sorted()
    }
    
    static private func parseDate(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        return dateFormatter.date(from: str)!
    }
 
    static private func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
}
