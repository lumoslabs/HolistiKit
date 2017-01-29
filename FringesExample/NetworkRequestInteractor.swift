import Foundation

class NetworkRequestInteractor {

    weak var delegate: NetworkRequestInteractorDelegate?
    private let urlSession: URLSessionProtocol
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    private var networkActivity: NetworkActivityManager.Activity?

    init(errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager,
         urlSession: URLSessionProtocol) {
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
        self.urlSession = urlSession
    }

    func requestJSON() {
        startRequest()
    }

    private func startRequest() {
        networkActivity?.finish()
        networkActivity = networkActivityManager.activityStarted()
        
        let urlString = "https://httpbin.org/get"
        let url = URL(string: urlString)!

        let task = urlSession.urlDataTask(with: url, completionHandler: { [weak self] (data, response, error) -> Void in
            self?.networkActivity?.finish()
            if let error = error {
                self?.errorLogger.log(String(describing: error))
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                    self?.delegate?.received(data: json)
                }
                catch {
                    self?.errorLogger.log("JSON parsing error.")
                }
            }
        })
        task.resume()
    }

    deinit {
        networkActivity?.finish()
    }
}
