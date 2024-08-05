//
//  APIRequestURLSession.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import Foundation

class APIRequestURL {
    func isConnectedToInterNet() -> Bool {
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response: URLResponse?
        do {
            try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
        }
        catch {
            return false
        }
        //NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as Data?
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        return Status
    }

    func getRequest<T:Decodable>(serviceName:String,success successBlock: @escaping ((T) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)){
        if isConnectedToInterNet() {
            guard let url = URL(string: serviceName) else {
                failedBlock(ErrorMessages.urlSide.value())
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
            //request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    failedBlock(error!.localizedDescription)
                    return
                }
                guard let data = data else {
                    failedBlock(ErrorMessages.clientSide.value())
                    return
                }
                
                guard let responseData = response as? HTTPURLResponse else {
                    failedBlock(ErrorMessages.urlSide.value())
                    return
                }
                
                switch responseData.statusCode {
                case 200...299:
                    do {
                        let obj = try JSONDecoder().decode(T.self , from: data)
                        successBlock(obj)
                    }
                    catch {
                        failedBlock(ErrorMessages.clientSide.value())
                    }
                    break
                case 400...499:
                    failedBlock(ErrorMessages.clientSide.value())
                    break
                case 500...599:
                    failedBlock(ErrorMessages.serverSide.value())
                    break
                default:
                    break
                }
                 
            }.resume()
            
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
    
    func postRequest(serviceName:String,httpMethod:String,andParams params: [String:Any],success successBlock: @escaping ((Bool) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)){
        if isConnectedToInterNet() {
            let strData = convertDictionaryToJSON(params)
            guard let url = URL(string: serviceName) else {
                failedBlock(ErrorMessages.urlSide.value())
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"// httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
//            if let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) {
//                request.httpBody = jsonData
//            }
            let postData = strData!.data(using: .utf8)
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    failedBlock(error!.localizedDescription)
                    return
                }
                guard let data = data else {
                    failedBlock(ErrorMessages.clientSide.value())
                    return
                }
                
                guard let responseData = response as? HTTPURLResponse else {
                    failedBlock(ErrorMessages.urlSide.value())
                    return
                }
                
                switch responseData.statusCode {
                case 200...299:
                    do {
                        //let obj = try JSONDecoder().decode(T.self , from: data)
                        successBlock(true)
                    }
                    catch {
                        failedBlock(ErrorMessages.interNetCheck.value())
                    }
                    break
                case 400...499:
                    failedBlock(ErrorMessages.clientSide.value())
                    break
                case 500...599:
                    failedBlock(ErrorMessages.serverSide.value())
                    break
                default:
                    break
                }
                 
            }.resume()
            
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
}
