//
//  JenkinsRequest.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/12/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//  Uses https://github.com/jansepar/node-jenkins-api
//

import Cocoa
import JavaScriptCore


class JenkinsRequest: NSObject, URLSessionDelegate {
    // MARK: Global Variables //?BRANCH=hack-week/mac-branch-builder

    private let hostString: String! = "https://jenkins.reach.rackspace.com/job/Reach_Branch/"
    private var buildString: String!
    private let username: String! = ""
    private let password: String! = ""
    private var branchName: String!

    // MARK: Initialization
    
    override init(){
        super.init()
        buildString = hostString.appending("buildWithParameters?BRANCH=")
    }
    
    // MARK: Functions
    
    func buildBranch(name: String) {
//        let encodedURL: URL! = encodeUrlWithBranch(name: name)
//        
//        let config = getConfigurationWithCredentials()
//        var request = URLRequest(url: encodedURL)
//        request.httpMethod = HTTPMethod.POST.rawValue
//        
//        let session = URLSession.init(configuration: config)
//        
//        let task = session.dataTask(with: request) {
//            (data, response, error) in
//            
//            guard error == nil else {
//                print("error\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse{
//                if httpStatus.statusCode != 200 {
//                    print("Status Code =\(httpStatus.statusCode)")
//                    print("Response = \(response)")
//                }
//            }
//            
//            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(str)
//        }
//        
//        task.resume()
        print("Built:", name)
    }
    
    func encodeUrlWithBranch(name: String) -> URL! {
        buildString = buildString.appending(name)
        return URL(string: buildString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    func getConfigurationWithCredentials() -> URLSessionConfiguration {
        let login = String(format: "%@:%@", username, password)
        let loginData = login.data(using: String.Encoding.utf8)
        
        let base64EncodedCredential = loginData!.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64EncodedCredential)"]
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        
        return config
    }
    
}
