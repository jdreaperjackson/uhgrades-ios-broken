//
//  DataModel.swift
//  UHGrades
//
//  Created by John D. Jackson on 9/19/21.
//

import Foundation

// https://uhgrades-api.herokuapp.com/search/?search=Rizk
class DataModel {
  
  private var dataTask: URLSessionDataTask?
  
  func loadGrades(searchTerm: String, completion: @escaping(([Grade]) -> Void)) {
    dataTask?.cancel()
    guard let url = buildUrl(forTerm: searchTerm) else {
      completion([])
      return
    }
    
    dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else {
        completion([])
        return
      }
      
      if let gradeResponse = try? JSONDecoder().decode(gradeResponse.self, from: data) {
        completion(gradeResponse.grades)
      }
    }
    dataTask?.resume()
  }
  
  private func buildUrl(forTerm searchTerm: String) -> URL? {
    guard !searchTerm.isEmpty else { return nil }
    
    let queryItems = [
      URLQueryItem(name: "term", value: searchTerm),
      URLQueryItem(name: "entity", value: "grade"),
    ]
    var components = URLComponents(string: "https://uhgrades-api.herokuapp.com/search/?search=")
    components?.queryItems = queryItems
    
    return components?.url
  }
}

struct gradeResonse: Decodable {
  let grades: [Grade]
  
  enum CodingKeys: String, CodingKey {
    case grades = "results"
  }
}


struct Grade: Decodable {
  let id: Int
  let term: String
  let courseDecription: String
  let catalogNbr: String
  let instructorLast: String
  let instructorFirst: String
  let aCount: String
  let bCount: String
  let artistName: String
  let cCount: String
  let dCount: String
  let fCount: String
  let satisfactory: String
  let dropCount: String
  let percentA: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case term
    case courseDescription
    case catalogNbr
    case instructorLast
    case instructorFirst
    case aCount
    case bCount
    case cCount
    case dCount
    case fCount
    case satisfactory
    case dropCount
    case percentA
  }
}
