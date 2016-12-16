//
//  ViewController.swift
//  ExifSample
//
//  Created by tanaka.kenji on 2016/12/15.
//  Copyright © 2016年 tanaka.kenji. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIImagePickerの生成
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 選択したアイテムの元のバージョンのAssets Library URL
        let assetUrl = info[UIImagePickerControllerReferenceURL] as! URL
        
        // PHAsset = Photo Library上の画像、ビデオ、ライブフォト用の型
        let result = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
        
        let asset = result.firstObject
        
        // コンテンツ編集セッションを開始するためのアセットの要求
        asset?.requestContentEditingInput(with: nil, completionHandler: { contentEditingInput, info in
            // contentEditingInput = 編集用のアセットに関する情報を提供するコンテナ
            let url = contentEditingInput?.fullSizeImageURL
            // 対象アセットのURLからCIImageを生成
            let inputImage = CIImage(contentsOf: url!)!
            
            // CIImageのpropertiesから画像のメタデータを取得する
            // 横幅 - 4032
            let pixelWidth  = inputImage.properties["PixelWidth"]
            // 縦幅 - 3024
            let pixelHeight = inputImage.properties["PixelHeight"]
            // 横幅dpi - 72
            let dpiWidth    = inputImage.properties["DPIWidth"]
            // 縦幅dpi - 72
            let dpiHeight   = inputImage.properties["DPIHeight"]
            // ??? - 8
            let depth       = inputImage.properties["Depth"]
            
            // プロファイル名 #とは - sRGB IEC61966-2.1
            let profileName = inputImage.properties["ProfileName"]
            // カラーモデル - RGB
            let colorModel  = inputImage.properties["ColorModel"]
            // 画像の向き（角度） - 1
            let orientation = inputImage.properties["Orientation"]
            
            // 各種規格
            // Exif
            let exif    = inputImage.properties["{Exif}"]
            // ExifAux
            let exifAux = inputImage.properties["{ExifAux}"]
            // GPS
            let gps     = inputImage.properties["{GPS}"]
            // TIFF
            let tiff    = inputImage.properties["{TIFF}"]
            // IPTC
            let iptc    = inputImage.properties["{IPTC}"]
            // JFIF
            let jfif    = inputImage.properties["{JFIF}"]
            
            print(inputImage.properties)
            print("")
            print("----------")
            print("")
            
            print("PixelWidth: \(pixelWidth)")
            print("")
            print("PixelHeight: \(pixelHeight)")
            print("")
            print("DPIWidth: \(dpiWidth)")
            print("")
            print("DPIHeight: \(dpiHeight)")
            print("")
            print("Depth: \(depth)")
            print("")
            
            print("ProfileName: \(profileName)")
            print("")
            print("ColorModel: \(colorModel)")
            print("")
            print("Orientation: \(orientation)")
            print("")
            
            print("Exif: \(exif)")
            print("")
            print("ExifAux: \(exifAux)")
            print("")
            print("GPS: \(gps)")
            print("")
            print("TIFF: \(tiff)")
            print("")
            print("IPTC: \(iptc)")
            print("")
            print("JFIF: \(jfif)")
            print("")
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

