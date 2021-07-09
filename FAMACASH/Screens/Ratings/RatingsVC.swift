//
//  RatingsVC.swift
//  FAMACASH
//
//  Created by MD  on 08/07/21.
//

import UIKit

class RatingsVC: UIViewController {

    @IBOutlet weak var tblRatings: UITableView!
    
    static let reuseId = "RatingsVC"
    var refreshController: UIRefreshControl = UIRefreshControl()
    var ratingsViewModel = [RatingsViewModel]()
    var movieId: Int?
    var pageIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadRatings()
    }

}

//MARK: VC Extension, Methods and Actions
extension RatingsVC {
    private func setupVC(){
        
        tblRatings.register(UINib(nibName: RatingsCell.resuseId, bundle: nil), forCellReuseIdentifier: RatingsCell.resuseId)
        tblRatings.delegate = self
        tblRatings.dataSource = self
        tblRatings.contentInsetAdjustmentBehavior = .never
        
        self.navigationController?.navigationBar.isHidden = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let orientation = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(orientation, forKey: Keys.ORIENTATION )
        } else {
            let orientation = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(orientation, forKey: Keys.ORIENTATION )
        }
    }
    
    private func setupPullToRefresh(){
        refreshController.bounds = CGRect(x: 0, y: 50,
                                          width: refreshController.bounds.size.width,
                                          height: refreshController.bounds.size.height)
        refreshController.addTarget(self, action: #selector(refreshMovies),
                                    for: UIControl.Event.valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "refresh.catalog".localized,
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        refreshController.tintColor = .label
        tblRatings.refreshControl = refreshController
    }
    
    @objc func refreshMovies(sender:AnyObject) {
        self.pageIndex = 1
        loadRatings()
        refreshController.endRefreshing()
    }
    
    private func loadRatings(){
        guard let currentLanguage = UserDefaults.standard.string(forKey: Keys.APP_LANGUAGE)  else { return }
        
        showActivityIndicator()
        MovieService.init().getMovieRatings(movieId: self.movieId!, pageIndex: "\(pageIndex)", language: currentLanguage) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success (let movies):
                self.ratingsViewModel.append(contentsOf: movies.map( { return RatingsViewModel($0)}))
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.tblRatings.reloadData()
                }
            case .failure (let error):
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func showError(error: String){
        let alert = UIAlertController(title: "error".localized,
                                      message: error,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok".localized,
                                      style: .default,
                                      handler: nil ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RatingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        print("Difference : -------------\(maximumOffset - currentOffset)--------")
        if maximumOffset - currentOffset <= 10.0 {
            print("you reached end of the table")
            self.pageIndex = self.pageIndex + 1
                self.loadRatings()
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : RatingsCell = tableView.dequeueReusableCell(withIdentifier: RatingsCell.resuseId, for: indexPath) as! RatingsCell
        cell.selectedMovieRate = ratingsViewModel[indexPath.row]
        
        return cell
    }
    
    
}
