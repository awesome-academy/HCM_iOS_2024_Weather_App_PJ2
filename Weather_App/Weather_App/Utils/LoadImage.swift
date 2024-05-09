//
//  LoadImage.swift
//  Weather_App
//
//  Created by ho.bao.an on 09/05/2024.
//

import UIKit
import SDWebImage

extension UIImageView {
    private var url: String {
        guard let url = Bundle.main.infoDictionary?["URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        return url.replacingOccurrences(of: "\\", with: "")
    }

    func loadImage(withIcon icon: String) {
        let imgURLString = "\(url)/img/w/\(icon).png"
        guard let imageURL = URL(string: imgURLString) else {
            print("Invalid URL Image")
            return
        }

        self.sd_setImage(with: imageURL, placeholderImage: nil, options: [], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            }
        })
    }
}
