//
//  ShowMoviesVC-Trailers.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

// MARK: - trailers table
extension ShowMovieVC : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Trailers section name
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("Trailers", comment: "Trailers Section")
        default:
            sectionName = ""
        }
        return sectionName
    }
    
    // MARK: - Open trailer video
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modelLayer.openTrailerLink(key: (movie?.trailers[indexPath.row].key)!)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Trailers sections number
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - No of trailers
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movie?.trailers.count ?? 0
    }
    
    // MARK: - Trailers cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: TRAILERS_CELL_ID, for: indexPath) as! ShowMovieTrailersCell
        
        let site : String = movie?.trailers[indexPath.row].site ?? ""
        let size : Int = movie?.trailers[indexPath.row].size ?? 0
        
        cell.labelName?.text = movie?.trailers[indexPath.row].name ?? ""
        cell.labelDescription?.text = "\(site), \(size)p"
        
        return cell
        
    }
    
}
