//
//  FileDownloader.swift
//  Pokemon
//
//  Created by Rifat Monzur on 26/9/24.
//
import Foundation
import Alamofire

struct FileDownloader: FileDownloaderDef {
    func downloadFile(url: String, completion: ((URL?) -> ())?) {
        AF.download(url).responseURL { response in
            guard let url = try? response.result.get() else {
                completion?(nil)
                return
            }
            
            completion?(url)
        }
    }
}
