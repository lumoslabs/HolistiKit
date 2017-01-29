import Foundation

class URLSessionInteractor {

    weak var delegate: URLSessionInteractorDelegate?
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

    enum RequestFormat {
        case json
        case html
    }

    func request(_ format: RequestFormat) {
        switch format {
        case .html:
            startRequest("https://httpbin.org/html")
        case .json:
            startRequest("https://httpbin.org/delay/3")
        }
    }

    private func startRequest(_ urlString: String) {
        networkActivity?.finish()
        networkActivity = networkActivityManager.activityStarted()
        
        let url = URL(string: urlString)!
        let task = urlSession.urlDataTask(with: url) { [weak self] (data, response, error) -> Void in
            self?.networkActivity?.finish()
            self?.handle(data: data, response: response, error: error)
        }
        task.resume()
    }

    private func handle(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            errorLogger.log(String(describing: error))
            return
        }

        guard let data = data else {
            errorLogger.log("There was no Data.")
            return
        }
        guard let response = response else {
            errorLogger.log("There was no URLResponse.")
            return
        }
        handle(data: data, response: response)
    }

    private func handle(data: Data, response: URLResponse) {
        guard let mimeType = response.mimeType else {
            errorLogger.log("Response had no MIME type.")
            return
        }
        switch mimeType {
        case "text/html":
            let html = String(data: data, encoding: encoding(for: response.textEncodingName))!
            delegate?.received(html: html)
        case "application/json":
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
                delegate?.received(json: json)
            }
            catch {
                errorLogger.log("JSON parsing error.")
            }
        default:
            errorLogger.log("Unhandeled response type")
        }
    }

    private func encoding(for name: String?) -> String.Encoding {
        let fallback = String.Encoding.utf8
        guard let cfString = name as CFString? else { return fallback }
        let cfStringEncoding = CFStringConvertIANACharSetNameToEncoding(cfString)
        if cfStringEncoding == kCFStringEncodingInvalidId { return fallback }
        let encodingUInt = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding)
        if encodingUInt == UInt(kCFStringEncodingInvalidId) { return fallback }
        return String.Encoding(rawValue: encodingUInt)
    }

    deinit {
        networkActivity?.finish()
    }
}
