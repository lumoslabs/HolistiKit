import Foundation

class NetworkRequestService: NetworkRequestingService {

    enum Response {
        case success([String : Any])
        case error(Error)
    }

    func request(_ urlString: String, handler: @escaping (Response) -> Void) {
        let urlSession = URLSession.shared
        let url = URL(string: urlString)!

        let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                handler(.error(error))
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                    handler(.success(json))
                }
                catch {
                    let jsonError = "JSON error: \(error)"
                    handler(.error(NSError(domain: jsonError, code: 1, userInfo: nil)))
                }
            }
        })
        task.resume()
    }
}


protocol NetworkRequestingService {

    func request(_ urlString: String, handler: @escaping (NetworkRequestService.Response) -> Void)
}
