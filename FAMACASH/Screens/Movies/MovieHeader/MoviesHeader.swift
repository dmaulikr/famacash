//
//  HeaderReusableView.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import UIKit

class MoviesHeader: UICollectionReusableView {
    
    //MARK:- Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieSegmentedControl: UISegmentedControl!
    
    //MARK: Properties
    
    static var languageDelegate: LanguageDelegate?
    static var movieSegmentDelegate: MovieSegmentDelegate?
    static let reuseId = "MoviesHeader"
    
    //MARK:- Actions
    
    @IBAction func languageButtonTapped(_ sender: Any) {
        MoviesHeader.languageDelegate?.chooseLanguage()
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        switch movieSegmentedControl.selectedSegmentIndex {
        case 0:
            MoviesHeader.movieSegmentDelegate?.loadMovie(movieType: .nowPlaying)
            setTitleLabel()
        case 1:
            MoviesHeader.movieSegmentDelegate?.loadMovie(movieType: .popular)
            setTitleLabel()
        case 2:
            MoviesHeader.movieSegmentDelegate?.loadMovie(movieType: .topRated)
            setTitleLabel()
        case 3:
            MoviesHeader.movieSegmentDelegate?.loadMovie(movieType: .upcoming)
            setTitleLabel()
        default:
            break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieSegmentedControl.removeAllSegments()
        movieSegmentedControl.insertSegment(withTitle: "now.playing".localized, at: 0, animated: true)
        movieSegmentedControl.insertSegment(withTitle: "popular".localized, at: 1, animated: true)
        movieSegmentedControl.insertSegment(withTitle: "top.rated".localized, at: 2, animated: true)
        movieSegmentedControl.insertSegment(withTitle: "upcoming".localized, at: 2, animated: true)
        
        movieSegmentedControl.selectedSegmentIndex = 0
        setTitleLabel()
        
        MoviesHeader.movieSegmentDelegate?.loadMovie(movieType: .nowPlaying)
    }
    
    override func prepareForReuse() {
        movieSegmentedControl.setTitle("now.playing".localized, forSegmentAt: 0)
        movieSegmentedControl.setTitle("popular".localized, forSegmentAt: 1)
        movieSegmentedControl.setTitle("top.rated".localized, forSegmentAt: 2)
        movieSegmentedControl.setTitle("upcoming".localized, forSegmentAt: 3)
        setTitleLabel()
    }
    
    private func setTitleLabel() {
        switch movieSegmentedControl.selectedSegmentIndex {
        case 0:
            titleLabel.text = "in.theaters".localized
        case 1:
            titleLabel.text = "most.popular".localized
        case 2:
            titleLabel.text = "top.rated.films".localized
        case 3:
            titleLabel.text = "upcoming".localized
        default:
            break
        }
    }
}
