class NetworkActivityManager {

    private let sharedApplication: ApplicationProtocol
    private var activityCount = 0

    init(sharedApplication: ApplicationProtocol) {
        self.sharedApplication = sharedApplication
    }

    func activityStarted() {
        activityCount += 1
        sharedApplication.isNetworkActivityIndicatorVisible = true
    }

    func activityFinished() {
        activityCount -= 1
        if activityCount <= 0 {
            sharedApplication.isNetworkActivityIndicatorVisible = false
        }
    }
}
