//
//  FileDownloaderDef.swift
//  Pokemon
//
//  Created by Rifat Monzur on 26/9/24.
//

import Foundation

protocol FileDownloaderDef {
    func downloadFile(url: String, completion: ((URL?) -> ())?)
}
