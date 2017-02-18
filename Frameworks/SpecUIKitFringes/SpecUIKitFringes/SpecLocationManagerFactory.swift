import UIKitFringes

public class SpecLocationManagerFactory {
    
    private let dialogManager: SpecDialogManager
    private let errorHandler: SpecErrorHandler
    private let userLocation: SpecUserLocation
    private let locationServices: SpecLocationServices
    private let locationAuthorizationStatus: SpecLocationAuthorizationStatus

    init(dialogManager: SpecDialogManager,
         errorHandler: SpecErrorHandler,
         userLocation: SpecUserLocation,
         locationServices: SpecLocationServices,
         locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        self.dialogManager = dialogManager
        self.errorHandler = errorHandler
        self.userLocation = userLocation
        self.locationServices = locationServices
        self.locationAuthorizationStatus = locationAuthorizationStatus
    }

    func create() -> SpecLocationManager {
        return SpecLocationManager(dialogManager: dialogManager,
                                   errorHandler: errorHandler,
                                   userLocation: userLocation,
                                   locationServices: locationServices,
                                   locationAuthorizationStatus: locationAuthorizationStatus)
    }
}
