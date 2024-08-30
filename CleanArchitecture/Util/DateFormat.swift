//
//  DateFormat.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/29/24.
//
// MARK: - Date 포맷 형식 확장 구현
// DateFormatter 객체로 String -> Date, Date -> String 변환하는 확장 정의

import Foundation

// String -> Date
extension String {
    // 타입속성으로 정의(DateForematter 포맷 형식 지정하여 객체 생성)
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func date() -> Date {
        // 문자열로 된 날짜 형식을 date 메서드를 통해 Date 객체로 변환하여 반환
        Self.formatter.date(from: self) ?? Date()
    }
}

// Date -> String
extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()
    
    func string() -> String {
        Self.formatter.string(from: self)
    }
}
