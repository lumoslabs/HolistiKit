import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var factory: SpecLocationManagerFactory!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    var errorHandler: SpecErrorHandler!
    var settingsApp: SpecSettingsApp!
    
    override func setUp() {
        super.setUp()

        errorHandler = SpecErrorHandler()
        dialogManager = SpecDialogManager(errorHandler: errorHandler)
        let locationServices = SpecLocationServices()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        settingsApp = SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                                      locationServices: locationServices)
        factory = SpecLocationManagerFactory(dialogManager: dialogManager,
                                             errorHandler: errorHandler,
                                             locationServices: locationServices,
                                             locationAuthorizationStatus: locationAuthorizationStatus)
        subject = factory.create()
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
