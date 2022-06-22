//
//  ImageCacheManager.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/22.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shard = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    
    func setImageUrl(_ url: String) {
        
        let cacheKey = NSString(string: url) //캐시에 사용될 key값
        if let cachedImage = ImageCacheManager.shard.object(forKey: cacheKey) {
            //해당 key에 캐시이미지가 저장되어 있으면 이미지를 사용
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shard.setObject(image, forKey: cacheKey)
                            //다운로드된 이미지를 캐시에 저장
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}

