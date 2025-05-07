import UIKit

protocol ViewInput {
    func downloadImages(completion: @escaping ([UIImage?]) -> Void)
}
