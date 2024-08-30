//
//  DTOs.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/29/24.
//
// MARK: - DTO(Data Transfer Object)
/*
 DTO 란? '데이터 전송 객체'
    데이터 전송을 위한 객체로 프로스세스 간에 데이터를 전달하는 객체를 의미
    데이터를 전송하기 위해 사용되므로 내부에는 비즈니스 로직같은 코드는 없고 순수하게 전달하고 싶은 데이터만 담겨있다.(주로 클라이언트와 서버가 데이터를 주고받을 때 사용함)
 */

import Foundation

// 특정 서버 API(yts)의 응답 요구사항에 맞춰져 있는 DTO
// 특정 서버에 종속적인 형태(이 중 하나의 필드라도 네이밍이 변경되거나 구성이 변경되면 앱이 동작하지 않음)
struct BaseResponse<T: Decodable>: Decodable {
    let status: String
    let status_message: String
    let data: T
}

struct MovieDataDTO: Decodable {
    let movie_count, limit: Int
    let movies: [MovieDTO]
}

struct MovieDTO: Decodable {
    let id: Int
    let url: String
    let title: String
    let summary: String
    let background_image: String
    let medium_cover_image: String
    let rating: Double
    let year: Int
    var myRating: Float?
    let date_uploaded: String
}

// 확장으로 Entity로 변환하여 반환하는 메서드 구현
// 실제로 MovieDTO에 가지고 있는 이미지 URL들은 여러가지가 있지만 내가 갖고 있는 Entity는 단순히 화면을 나타내주기 위한 이미지 URL만 알고 있기 때문에 어떠한 소스가 이미지로 들어오는지 엔터티는 모르는 상태
extension MovieDTO {
    func toEntity() -> MovieEntity {
        MovieEntity(id: id, title: title, imageURL: background_image, uploadedDate: date_uploaded.date())
    }
}
