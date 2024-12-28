//
//  APICallManager.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//

import Foundation
import Alamofire

class APICallManager: AsynchronousOperation {
    //private var sessionManager: ATSessionManager?
    private let url: String
    private let method: RequestMethod
    private let body: Data?
    private let parametersURL: Parameters?
    private var successCallback: ((Data) -> Void)?
    private var failureCallback: ((String) -> Void)?
    static var banderaToken = false
    static var login = false
    
    init(url: String,
    method: RequestMethod,
    body: Data? = nil,
    parametersURL: Parameters? = nil,
    onSuccess successCallback: ((Data) -> Void)?,
         onFailure failureCallback: ((String) -> Void)?) {
        //self.sessionManager = ATSessionManager()
        self.url = url
        self.method = method
        self.body = body
        self.parametersURL = parametersURL
        self.successCallback = successCallback
        self.failureCallback = failureCallback
        super.init()
    }
    override func main() {
        var request: URLRequest?
        if parametersURL != nil {
            var urlComponents = URLComponents(string: url)
            urlComponents?.setQueryItems(with: parametersURL!)
            print(urlComponents?.url!.absoluteString as Any)
            if let url = urlComponents?.url {
                request = URLRequest(url: url)
            }
            } else {
                request = URLRequest(url: URL(string: url)!)
                print(request?.url?.absoluteString as Any)
            }
            switch method {
                case .get:
                request?.httpMethod = HTTPMethod.get.rawValue
                break
                case .post:
                request?.httpMethod = HTTPMethod.post.rawValue
                break
                case .put:
                request?.httpMethod = HTTPMethod.put.rawValue
                break
                case .delete:
                request?.httpMethod = HTTPMethod.delete.rawValue
                break
            }
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /* if AppManager.shared.bearerToken == "" {} else {
                            if !APICallManager.banderaToken {
                                request?.setValue(AppManager.shared.bearerToken , forHTTPHeaderField:"Authorization")
                            } else {
                                request?.setValue(FreeStationViewController.NewTokenEtime, forHTTPHeaderField:"Authorization")
                                APICallManager.banderaToken = false
                            }
                        }*/
        if body != nil {
            request?.httpBody = body
        }
        
        ATSesionManager.instance.getSession().request(request!).responseString {
            response in
            print("response 😵‍💫 " + self.url + " URL ")
            print("😮 Response: \(response)")
            
            switch response.result {
            case .success(_):
                self.successCallback?(response.data!)
            case .failure(let error):
                if let callBack = self.failureCallback {
                    callBack(error.localizedDescription)
                }
            }
            self.successCallback = nil
            self.failureCallback = nil
            self.completeOperation()
        }
    }
    
    override func cancel() {
    super.cancel()
}
    
    func cancelServices() {
    //sessionManager?.mman?.session.invalidateAndCancel()
    //sessionManager?.mman?.session.finishTasksAndInvalidate()
    //sessionManager = nil
    }
    
    static func jsonEncorderBody<T: Encodable>(_ body: T) throws -> Data{
        var jsonData:Data? = nil
        do {
    let jsonEncoder = JSONEncoder()
            jsonData = try jsonEncoder.encode(body)
            let body = String(data: jsonData!, encoding: .utf8)!
            print(" 🤐 JSON body: " + body)
            return jsonData!
        }
        catch let error {
            throw error
        }
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
    self.queryItems = parameters.map {
    var value: String? = nil
    if let number = $0.value as? Int {
    let a: Int? = number
    let b = a.map(String.init) ?? ""
    print(b)
    value = b
    } else if let boolean = $0.value as? Bool {
    let a: String? = boolean.description
    value = a
    } else if let numberArray = $0.value as? [Int] {
        let b = numberArray.map(String.init).joined(separator: ",")
        print(b)
        value = b
            } else {
                value = $0.value as? String
            }
        return URLQueryItem(name: $0.key, value: value)
        }
    }
}
    
enum RequestMethod {
    case get
    case post
    case put
    case delete
}
