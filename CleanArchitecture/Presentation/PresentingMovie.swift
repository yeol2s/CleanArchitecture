//
//  PresentingMovie.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/31/24.
//
// MARK: - 화면에 나타내기 위한 모델(Entity -> Model)

import Foundation

struct PresentingMovie: Identifiable {
    let id: Int // hashable
    let title: String
    let imageURL: URL?
    let dateString: String // Date -> String 타입으로 변경(화면에 표시될 그저 데이터 형식으로 나타내기 위함)
}

