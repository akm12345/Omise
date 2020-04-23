//
//  CharityTableViewCell.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit

class CharityTableViewCell: UITableViewCell, CellConfigurable {
    
    //MARK:- IBoutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    //MARK:- View lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Thsi method is uesd to display  charity name and charity image from rowModel
    func setUp(rowViewModel: RowViewModel) {
        if let rowViewModel = rowViewModel as? CharityListViewModel{
            self.loadImageUsingCacheWithUrl(urlString: rowViewModel.imageUrl)
            self.charityNameLabel.text = rowViewModel.charityName
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

//MARK:- Image Downloading and caching
extension CharityTableViewCell {
    
    ///Used to download image from URL and set it to image cache
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data, let image = UIImage(data: data) {
                    self.logoImageView.image = image
                    imageCache.setObject(image, forKey: link as AnyObject)
                }
            }
        }).resume()
    }
    
    ///Used to load image from cache if it exists, else download from the URL
    func loadImageUsingCacheWithUrl(urlString: String) {
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.logoImageView.image = cachedImage
        } else {
            downloadImageFrom(link: urlString, contentMode: .scaleAspectFit)
        }
    }
}


