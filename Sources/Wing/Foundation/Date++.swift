//
//  Date++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation


/*
 eg:
 var date = Date() //PS: var is requared
 date.year += 2 //etc
 */
//MARK: Date Compontent get reset PS: current calendar with current zone
public extension Date {

    mutating func setValue(_ value: Int, for compontent: Calendar.Component) {
        guard let compontentValue = self.compontentValue(of: compontent),
            let date = Calendar.current.date(byAdding: compontent, value: value - compontentValue, to: self) else {
            return
        }
        self = date
    }

    var dateCompontents: DateComponents {
        get { Calendar.current.dateComponents(in: TimeZone.current, from: self) }
    }

    func compontentValue(of compontent: Calendar.Component) -> Int? {
        return self.dateCompontents.value(for: compontent)
    }

    var era: Int {
        get { return Calendar.current.component(.era, from: self) }
        set { self.setValue(newValue, for: .era) }
    }
    var year: Int {
        get { return Calendar.current.component(.year, from: self) }
        set { self.setValue(newValue, for: .year) }
    }
    var month: Int {
        get { return Calendar.current.component(.month, from: self) }
        set { self.setValue(newValue, for: .month) }
    }
    var day: Int {
        get { return Calendar.current.component(.day, from: self) }
        set { self.setValue(newValue, for: .day) }
    }
    var hour: Int {
        get { return Calendar.current.component(.hour, from: self) }
        set { self.setValue(newValue, for: .hour) }
    }
    var minute: Int {
        get { return Calendar.current.component(.minute, from: self) }
        set { self.setValue(newValue, for: .minute) }
    }
    var second: Int {
        get { return Calendar.current.component(.second, from: self) }
        set { self.setValue(newValue, for: .second) }
    }
    var nanosecond: Int {
        get { return Calendar.current.component(.nanosecond, from: self) }
        set { self.setValue(newValue, for: .nanosecond) }
    }
    var weekday: Int {
        get { return Calendar.current.component(.weekday, from: self) }
        set { self.setValue(newValue, for: .weekday) }
    }
    var weekdayOrdinal: Int {
        get { return Calendar.current.component(.weekdayOrdinal, from: self) }
        set { self.setValue(newValue, for: .weekdayOrdinal) }
    }
    var quarter: Int {
        get { return Calendar.current.component(.quarter, from: self) }
        set { self.setValue(newValue, for: .quarter) }
    }
    var weekOfMonth: Int {
        get { return Calendar.current.component(.weekOfMonth, from: self) }
        set { self.setValue(newValue, for: .weekOfMonth) }
    }
    var weekOfYear: Int {
        get { return Calendar.current.component(.weekOfYear, from: self) }
        set { self.setValue(newValue, for: .weekOfYear) }
    }
    var yearForWeekOfYear: Int {
        get { return Calendar.current.component(.yearForWeekOfYear, from: self) }
        set { self.setValue(newValue, for: .yearForWeekOfYear) }
    }
}

//MARK: Date is XXX
public extension Date {
    var isLeapMonth: Bool? {
        get { return Calendar.current.dateComponents(in: TimeZone.current, from: self).isLeapMonth }
    }

    var isLeapYear: Bool {
        get {
            let year = self.year
            return year % 400 == 0 || ((year % 100 != 0) && (year % 4 == 0))
        }
    }

    func inSameDayAs(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }

    var isToday: Bool {
        get { Calendar.current.isDateInToday(self) }
    }
    var isYesterday: Bool {
        get { Calendar.current.isDateInYesterday(self) }
    }
    var isTomorrow: Bool {
        get { Calendar.current.isDateInTomorrow(self) }
    }
    var isWeekend: Bool {
        get { Calendar.current.isDateInWeekend(self) }
    }
}

//MARK: string convert from date with formatter
public extension Date {
    func string(with dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }

    func string(with dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return self.string(with: dateFormatter)
    }
}

//MARK: usual formatter string
public extension Date {
    var ISO8601String: String {
        DateFormatter.ISO8601.string(from: self)
    }
    var ymdCNString: String {
        DateFormatter.ymdCNFormatter.string(from: self)
    }
    var ymdSlashString: String {
        DateFormatter.ymdSlashFormatter.string(from: self)
    }
}

/*
 
 */
//MARK: append interval
public extension Date {

    static func + (lhs: Self, interval: Double) -> Self {
        return Date(timeInterval: interval, since: lhs)
    }
    static func += (lhs: inout Self, interval: Double) -> Self {
        lhs = Date(timeInterval: interval, since: lhs)
        return lhs
    }
    static func - (lhs: Self, interval: Double) -> Self {
        return Date(timeInterval: -interval, since: lhs)
    }
    static func -= (lhs: inout Self, interval: Double) -> Self {
        lhs = Date(timeInterval: -interval, since: lhs)
        return lhs
    }
    static func ... (lhs: Self, rhs: Self) -> Double {
        return rhs.timeIntervalSince(lhs)
    }
}


public extension Date {
    var upToNow: String {
        get {
            let timeStamp = self.timeIntervalSince1970
            let currentTime = Date().timeIntervalSince1970
            let reduceTime : TimeInterval = currentTime - timeStamp
            let mins = Int(ceil(reduceTime / 60))
            if mins < 10 {
                return "刚刚"
            }
            if mins < 60 {
                return "\(mins)分钟前"
            }
            let hours = Int(ceil(reduceTime / 3600))
            if hours < 24 {
                return "\(hours)小时前"
            }
            let days = Int(ceil(reduceTime / 3600 / 24))
            if days < 3 {
                return "\(days)天前"
            }
            let date = NSDate(timeIntervalSince1970: timeStamp)
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyy年MM月dd日 HH:mm"
            return dfmatter.string(from: date as Date)
        }
    }
}
