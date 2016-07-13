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


class JenkinsRequest {
    // MARK: Global Variables //?BRANCH=hack-week/mac-branch-builder

    private let url: URL! = URL(string: "https://jenkins.reach.rackspace.com/job/Reach_Branch/")
    private let buildBranchUrl: URL! = URL(string: "https://jenkins.reach.rackspace.com/job/Reach_Branch/buildWithParameters/")
    private let username: String! = ""
    private let password: String! = ""
    private let branchName: String! = "hack-week/mac-branch-builder"

    // MARK: Initialization
    
    init(){
        
    }
    
    // MARK: Functions
    
    func buildBranch() {
        let login = String(format: "%@:%@", username, password)
        let loginData = login.data(using: String.Encoding.utf8)
        let base64EncodedCredential = loginData!.base64EncodedString()
        let base64LoginString = "Basic \(base64EncodedCredential)"
        let parameters = "BRANCH=\(branchName)"
        var request = URLRequest(url: buildBranchUrl)
        
        request.setValue(base64LoginString, forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        
        let session = URLSession()
        
        let task = session.dataTask(with: request) {
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
            print(str)
        }
        
        task.resume()
        
    }
    
}
