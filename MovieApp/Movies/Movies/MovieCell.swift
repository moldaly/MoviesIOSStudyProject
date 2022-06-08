//
//  MovieCell.swift
//  Movies
//
//  Created by Aida Moldaly on 18.05.2022.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet var imageCellView: UIImageView!
    @IBOutlet var ratingView: UILabel!
    @IBOutlet var nameView: UILabel!
    @IBOutlet var ratingContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with movie: Movie) {
        let url = URL(string: movie.posterUrl ?? "")
        imageCellView.kf.setImage(with: url)
        nameView.text = movie.name
        ratingView.text = "★ \(movie.rating)"
        
        if movie.rating < 4 {
            ratingContainerView.backgroundColor = .systemRed
        } else if movie.rating < 7 {
            ratingContainerView.backgroundColor = .systemOrange
        } else {
            ratingContainerView.backgroundColor = .systemGreen
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


