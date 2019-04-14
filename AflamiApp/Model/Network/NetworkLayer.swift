//
//  NetworkLayer.swift
//  aflami
//
//  Created by Ahmed M. Hassan on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer{
    
    init() {
        
    }
    
    //MARK - Send all requests to server
    func executeNetwordRequest(url : String, completionHandler : @escaping ([String : Any]?, Error?) -> Void){
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    completionHandler(value as? [String : Any], nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    //MARK - Get image using thumbnail id
    func getImageUsingPosterPath(posterPath : String, imageSize : APIImageSize, completionHandler : @escaping (Data?, Error?) -> Void){
        let mURL = URL(string: "https://image.tmdb.org/t/p/\(imageSize.rawValue)\(posterPath)")!
        
        // Creating a session object with the default configuration.
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        _ = session.dataTask(with: mURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Do something with your image.
                        completionHandler(imageData, nil)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
            }.resume()
    }
    
    
    
}
