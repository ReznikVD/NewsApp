//
//  Service.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    private let headers = [
        "X-RapidAPI-Key": "46b507aed8msh4a04fa0692eb23bp13baaajsn59643a26279b",
        "X-RapidAPI-Host": "free-news.p.rapidapi.com"
    ]
    
    func fetchTodayNews(completion: @escaping (Articles?, Error?) -> ()) {
        
        let urlString = "https://free-news.p.rapidapi.com/v1/search?q=today&lang=en&page_size=20"
        fetchNews(urlString: urlString, completion: completion)
    }
    
    func fetchTopNews(completion: @escaping (Articles?, Error?) -> ()) {
        
        let urlString = "https://free-news.p.rapidapi.com/v1/search?q=Sport&lang=en&page_size=5"
        fetchNews(urlString: urlString, completion: completion)
    }
    
    func fetchNews(urlString: String, completion: @escaping (Articles?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, resp, err in

            if let err = err {
                print(err)
                completion(nil, err)
            }

            guard let data = data else { return }

            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                print(error)
                completion(nil, err)
            }
        }.resume()
    }
}
