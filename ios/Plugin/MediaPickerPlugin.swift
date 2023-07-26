import Foundation
import Capacitor
import UIKit
import Photos
import ImageIO
import DKImagePickerController

@objc(MediaPickerPlugin)
public class MediaPickerPlugin: CAPPlugin {
    
    var call: CAPPluginCall?
    var imagePicker: DKImagePickerController!
    
    @objc func getMedia(_ call: CAPPluginCall) {
        self.call = call
        self.imagePicker = DKImagePickerController()
        self.imagePicker.assetType = .allAssets // This allows the picker to select both images and videos

        DispatchQueue.main.async {
            self.bridge?.viewController?.present(self.imagePicker, animated: true) {
                self.imagePicker.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                    var resultArray = [Any]()
                    let dispatchGroup = DispatchGroup()

                    for asset in assets {
                        dispatchGroup.enter()
                        asset.fetchImageData { data, info in
                            if let data = data {
                                let sourceOptionsDict = [kCGImageSourceShouldCache: false] as CFDictionary
                                let source = CGImageSourceCreateWithData(data as CFData, sourceOptionsDict)!
                                let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as NSDictionary?
                                let exifData = metadata?["{Exif}"] as? NSDictionary
                                resultArray.append([
                                    "data": data.base64EncodedString(),
                                    "exifData": exifData as Any
                                ])
                                dispatchGroup.leave()
                            }
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        self.call?.resolve([
                            "results": resultArray
                        ])
                    }
                }
            }
        }
    }
}
