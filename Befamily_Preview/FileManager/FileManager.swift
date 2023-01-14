//
//  FileManager.swift
//  Befamily_Preview
//
//  Created by Jung Hwan Park on 2023/01/09.
//

import Foundation
import UIKit

extension FileManager
{
    func loadImage(with pi: String) -> UIImage?
    {
        let url = URL.documentsDirectory.appendingPathComponent("\(pi).jpg")
        do
        {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveImage(with pi : PreviewImage)
    {
        self.downloadImage(pi)
        { img in
            /// If image is system image, then a fail has occured downloading the image, so no need to save image in directory
            if img == UIImage(systemName: "photo")!
            {
                return
            }
            else
            {
                if let data = img.jpegData(compressionQuality: 1.0)
                {
                    do
                    {
                        let url = URL.documentsDirectory.appendingPathComponent("\(pi.imageID).jpg")
                        print(url)
                        try data.write(to: url)
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    print("Could not save image")
                }
            }
        }
    }
    
    func downloadImage(_ pi: PreviewImage, completion: @escaping (_ img: UIImage) -> Void)
    {
        DispatchQueue.global(qos: .background).async
        {
            if let imageUrl = URL(string: pi.link ?? "https://source.unsplash.com/random")
            {
                URLSession.shared.dataTask(with: imageUrl)
                { (data, res, err) in
                    if let _ = err
                    {
                        completion(UIImage(systemName: "photo")!)
                    }
                    DispatchQueue.main.async
                    {
                        if let data = data, let image = UIImage(data: data)
                        {
                            completion(image)
                        }
                    }
                }.resume()
            }
        }
    }
}

