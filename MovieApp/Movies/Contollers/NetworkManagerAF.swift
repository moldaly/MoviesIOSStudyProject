//
//  NetworkManagerAL.swift
//  Movies
//
//  Created by Aida Moldaly on 08.06.2022.
//

import Foundation
import Alamofire

class NetworkManagerAF {
    private let API_KEY = "e516e695b99f3043f08979ed2241b3db"
    
    static var shared = NetworkManagerAF()
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        return components
    }()
    
    
    func loadGenres(completion: @escaping ([Genre]) -> Void) {
        var components = urlComponents
        components.path = "/3/genre/movie/list"
        
        guard let requestUrl = components.url else {
            return
        }
        AF.request(requestUrl).responseJSON { response in
            guard let data = response.data else {
                print("Error: Did not receive data")
                return
            }
            do {
                let genresEntity = try JSONDecoder().decode(GenresEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(genresEntity.genres)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func loadTodayMovies(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/movie/now_playing") { movies in
            completion(movies)
        }
    }
    
    func loadSoonMovies(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/movie/upcoming") { movies in
            completion(movies)
        }
    }
    
    func loadTrendingMovies(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/trending/movie/week") { movies in
            completion(movies)
        }
    }
    
    
    private func loadMovies(path: String, completion: @escaping ([Movie]) -> Void) {
        var components = urlComponents
        components.path = path
        
        guard let requestUrl = components.url else {
            return
        }
        AF.request(requestUrl).responseJSON { response in
            guard let data = response.data else {
                    print("Error: Did not receive data")
                    return
                }
                do {
                    let moviesEntity = try JSONDecoder().decode(MoviesEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesEntity.results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
    }
    
    func loadCastIDByMovieID(id: Int, completion: @escaping ((Int)) -> Void ) {
        loadCastID(path: "/3/movie/\(id)/credits") { id in
            completion(id)
        }
    }
    

    
    private func loadCastID(path: String, completion: @escaping (Int) -> Void) {
        var components = urlComponents
        components.path = path
        
        guard let requestUrl = components.url else {
            return
        }
        AF.request(requestUrl).responseJSON { response in
            guard let data = response.data else {
                    print("Error: Did not receive data")
                    return
                }
                do {
                    let castIDEntity = try JSONDecoder().decode(CastIDEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(castIDEntity.id)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(0)
                    }
                }
            }
    }
    

    func loadCastInfoByCastID(id: Int, completion: @escaping ([Cast]) -> Void ) {
        loadCast(path: "/3/person/\(id)") { casts in
            completion(casts)
        }
    }

    
    private func loadCast(path: String, completion: @escaping ([Cast]) -> Void) {
        var components = urlComponents
        components.path = path
        
        guard let requestUrl = components.url else {
            return
        }
        AF.request(requestUrl).responseJSON { response in
            guard let data = response.data else {
                    print("Error: Did not receive data")
                    return
                }
                do {
                    let castEntity = try JSONDecoder().decode(CastEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(castEntity.cast)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
    }
}