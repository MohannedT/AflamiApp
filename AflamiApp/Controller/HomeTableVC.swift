//
//  HomeTableVC.swift
//  aflami
//
//  Created by Ahmed M. Hassan on 3/31/19.
//  Copyright © 2019 jets. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewController {
    
    let modelLayer : ModelLayer = ModelLayer()
    var moviesList : Array<Movie> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modelLayer.getMoviesList(completionHandler: { (value, error) in
            if let result = value {
                DispatchQueue.main.async {
                    self.moviesList = result
                    self.tableView.reloadData()
                }
                
            } else {
                print("Connection Error!")
            }
        })
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        /*
         self.modelLayer.getMovieThumbnail(movie: (moviesList?[0])!, completionHandler: { (image) in
         DispatchQueue.main.async {
         self.mImage.image = image
         }
         })
         */
        
        cell.textLabel?.text = moviesList[indexPath.row].title
        if let image = moviesList[indexPath.row].image {
            cell.imageView?.image = UIImage(data: image)
        } else {
            self.modelLayer.getMovieThumbnail(movie: (moviesList[indexPath.row]), completionHandler: { (image) in
                cell.imageView?.image = image
            })
        }
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier!{
        case "detailsView":
            if let detailsVC = segue.destination as? DetailedMovieTableVC{
                let indexPath = self.tableView.indexPathForSelectedRow
                detailsVC.movie = moviesList[(indexPath?.row)!]
            }
            
        default:
            print("")
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
}
