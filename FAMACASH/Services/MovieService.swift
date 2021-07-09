//
//  MovieService.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import UIKit

class MovieService {
    
    //MARK: - Properties
    static let shared = MovieService()
    let cache = NSCache<NSString, UIImage>()
    let apiKey = PlistService.getPlistKey(key: .apiKey)
    
    
    func getMovies(movieType: MovieType, pageIndex: String , language: String, completion: @escaping (Result<[Movie], APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.baseURL + movieType.value) else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        var queryItem = [URLQueryItem(name: Keys.API_KEY,  value: apiKey)]
        queryItem.append(URLQueryItem(name: Keys.LANGUAGE,  value: language))
        queryItem.append(URLQueryItem(name: "page",  value: pageIndex))
        
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
                let str = String(data: data, encoding: .utf8) {
                print(str)
            }
            do{
                let movieResponse = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    func getSelectedMovie(movieId: Int, language: String, completion: @escaping (Result< SelectedMovie, APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.selectedMovie + "\(movieId)") else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        var queryItem = [URLQueryItem(name: Keys.API_KEY,  value: apiKey)]
        queryItem.append(URLQueryItem(name: Keys.LANGUAGE,  value: language))
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            
            let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
                let str = String(data: data, encoding: .utf8) {
                print(str)
            }
            
            do{
                let movieResponse = try JSONDecoder().decode(SelectedMovie.self, from: data)
                completion(.success(movieResponse))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    func getMovieRatings(movieId: Int, pageIndex: String, language: String, completion: @escaping (Result< [Rating], APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.baseURL + "\(movieId)" + "/reviews") else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        var queryItem = [URLQueryItem(name: Keys.API_KEY,  value: apiKey)]
        queryItem.append(URLQueryItem(name: Keys.LANGUAGE,  value: language))
        queryItem.append(URLQueryItem(name: "page",  value: pageIndex))
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            
            let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
                let str = String(data: data, encoding: .utf8) {
                print(str)
            }
            
            
            do{
                let movieResponse = try JSONDecoder().decode(Ratings.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }

    func getTrailers(movieId: Int, language: String, completion: @escaping (Result< [Trailer], APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.selectedMovie + "\(movieId)/videos") else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        var queryItem = [URLQueryItem(name: Keys.API_KEY,  value: apiKey)]
        queryItem.append(URLQueryItem(name: Keys.LANGUAGE,  value: language))
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let trailerResponse = try JSONDecoder().decode(Trailers.self, from: data)
                completion(.success(trailerResponse.results))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    func getImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
