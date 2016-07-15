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
    private var branchName: String! = ""
    private var config: URLSessionConfiguration!
    private var session: URLSession!
    private var queueID: Int!
    private var buildNumber: Int!

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
    
    func buildBranch(name: String, completion: (AnyObject) -> ()) {
        branchName = name
        let branchBuild = buildString.appending(name)
        
        let encodedURL: URL! = encodeURL(name: branchBuild)
        
        let request: URLRequest! = createRequest(url: encodedURL, method: HTTPType.POST)
        
        createTask(request: request, requestType: RequestType.BUILD_BRANCH, completion: completion)
        
        //make sure our build has started (poll for matching queue ids, then when matched we will use that json to get build number)
        
    }
    
    func getBuildNumber() -> Int {
        return buildNumber
    }
    
    func getStatusOfTest(name: TestType) {
        
    }
    
    func getStatusOfBuild() {
        
    }
    
    func setQueueId(id: Int) {
        queueID = id
    }
    
    func getQueueId() -> Int! {
        return queueID
    }
    
    func getCurrentBuildInformation(completion: (AnyObject) -> ()) { //GET REQUEST TO POLL API AND RETURN JSON OF LATEST BUILD
        let encodedURL: URL! = encodeURL(name: lastBuild)
        let request: URLRequest! = createRequest(url: encodedURL, method: HTTPType.GET)
        
        createTask(request: request, requestType: RequestType.GET_BUILD_INFORMATION, completion: completion)
    }
    
    private func createRequest(url: URL!, method: HTTPType) -> URLRequest! {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private func createTask(request: URLRequest!, requestType: RequestType, completion: (AnyObject) -> ()) {
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
            
            let json = JSON(data: data!)
            
            switch(requestType) {
            case .BUILD_BRANCH:
                if let queueLocation = json["Location"].string {
                    completion(queueLocation)
                }
                break
            case .GET_BUILD_INFORMATION:
                let build = self.getBuildInformation(json: json)
                completion(build!)
                break
            case .GET_STATUS_OF_BUILD:
                break
            case .GET_STATUS_OF_TESTS:
                break
            }
            //get last build queue number

            
//            //get last build number
            
        }
        task.resume()
        
    }

    private func getBuildInformation(json: JSON) -> [String]! {
        var buildInformation: [String] = []
        //get last build result
        if let result = json["result"].string {
            buildInformation.append(result)
        }
        
        if let buildNumber = json["number"].number {
            buildInformation.append(buildNumber.stringValue)
        }
    
        //get build url
        if let buildUrl = json["url"].string {
            buildInformation.append(buildUrl)
        }
        
        if let queueNumber = json["queueId"].number {
            buildInformation.append(queueNumber.stringValue)
        }

        return buildInformation
    }
    
    private func setQueueId() {
        
    }
    
    private func pollQueueForBuildNumber() {
        
    }
    
    private func pollForBuildUpdates() {
        
    }

    private func encodeURL(name: String) -> URL! {
        return URL(string: name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    private func getConfigurationWithCredentials() -> URLSessionConfiguration {
        let login = String(format: "%@:%@", username, password)
        let loginData = login.data(using: String.Encoding.utf8)
        
        let base64EncodedCredential = loginData!.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64EncodedCredential)"]
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        
        return config
    }
    
}
