//
//  JenkinsRequest.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/12/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//  Uses https://github.com/jansepar/node-jenkins-api
//

import Cocoa

class JenkinsRequest: NSObject, URLSessionDelegate {
    
    // MARK: Global Variables

    private let hostString: String! = "https://jenkins.reach.rackspace.com/job/Reach_Branch/"
    private let lastBuild = "https://jenkins.reach.rackspace.com/job/Reach_Branch/lastBuild/api/json"
    private var buildString: String!
    private var username: String! = ""
    private var password: String! = ""
    private var branchName: String!
    private var config: URLSessionConfiguration!
    private var session: URLSession!

    // MARK: Initialization
    
    override init(){
        super.init()
        buildString = hostString.appending("buildWithParameters?BRANCH=")

    }
    
    // MARK: Functions
    
    func setUser(user: String!, pass: String!) {
        username = user
        password = pass
        
        config = getConfigurationWithCredentials()
        session = URLSession.init(configuration: config)
    }
    
    func getLastBuild() {
        let encodedURL: URL! = encodeURL(name: lastBuild)
        let request: URLRequest! = createRequest(url: encodedURL, method: HTTPMethod.GET)
        
        createTask(request: request)
    }
    
    func createRequest(url: URL!, method: HTTPMethod) -> URLRequest! {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    func createTask(request: URLRequest!) {
        let task = session.dataTask(with: request!) {
            (data, response, error) in
            
            guard error == nil else {
                print("error\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse{
                if httpStatus.statusCode != 200 {
                    print("Status Code =\(httpStatus.statusCode)")
                    print("Response = \(response)")
                }
            }
            
            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
            }
            catch _ {
                print("Error Parsing JSON")
            }
            
            print(str)
        }
        
        task.resume()
    }
    
    func buildBranch(name: String) {
        branchName = name
        let branchBuild = buildString.appending(name)
        
        let encodedURL: URL! = encodeURL(name: branchBuild)

        let request: URLRequest! = createRequest(url: encodedURL, method: HTTPMethod.POST)
        
        
        //let queueLocation: String?
        
        createTask(request: request)

    }
    
    func encodeURL(name: String) -> URL! {
        return URL(string: name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
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
