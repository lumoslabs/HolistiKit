import Foundation
import UIKitFringes

public class SpecDispatchHandler: DispatchHandling {

    private let dateProvider: SpecDateProvider
    private var asyncBlocks = [AsyncBlock]()

    public init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
        dateProvider.observe(on: self, selector: #selector(dateDidChange))
    }

    private struct AsyncBlock {
        let date: Date
        let block: () -> Void
    }

    @objc
    private func dateDidChange() {
        let currentDate = dateProvider.date
        asyncBlocks = asyncBlocks.compactMap { asyncBlock in
            if currentDate >= asyncBlock.date {
                asyncBlock.block()
                return nil
            }
            return asyncBlock
        }
    }

    public func sync(on: DispatchQueue, block: () -> Void) {
        block()
    }

    public func async(on _: DispatchQueue, block: @escaping () -> Void) {
        block()
    }
    
    public func async(on _: DispatchQueue, after: TimeInterval, block: @escaping () -> Void) {
        let executeOnOrAfter = dateProvider.date.addingTimeInterval(after)
        let asyncBlock = AsyncBlock(date: executeOnOrAfter,
                                    block: block)
        asyncBlocks.append(asyncBlock)
    }
}
