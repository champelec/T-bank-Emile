import UIKit
import Alamofire

final class ImageDownloader: ViewInput {
    func downloadImages(completion: @escaping ([UIImage?]) -> Void) {
        let urls = ["https://www.alleycat.org/wp-content/uploads/2016/06/Day-32-Denby.jpg",
                    "https://i.bigenc.ru/resizer/resize?sign=ZsmpjGkl2ga8dDG74SLngQ&filename=vault/0995c4be88c50ceb10096ba695c2c03b.webp&width=1024",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6PrxMYTq5vrDjYPYr5mb1FY_1pAWmcQkssA&s"]
        var images = [UIImage?](repeating: nil, count: urls.count)
        let group = DispatchGroup()

        for (index, urlString) in urls.enumerated() {
            group.enter()
            AF.download(urlString).responseData { response in
                if let data = response.value {
                    images[index] = UIImage(data: data)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(images)
        }
    }
}
