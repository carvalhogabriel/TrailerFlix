//
//  ViewController.swift
//  TrailerFlix
//
//  Created by Gabriel Carvalho Guerrero on 26/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlet's
    @IBOutlet weak var tableView: UITableView!
    
    var trailers: [Trailer] = []
    
    // MARK: - @IBAction's
    @IBAction func watchRandomTrailer(_ sender: UIButton) {
        let randomIndex = Int(arc4random_uniform(UInt32(trailers.count)))
        showTrailer(index: randomIndex)
    }
    
    // MARK: - Method's
    func showTrailer(index: Int) {
        let trailer = trailers[index]
        performSegue(withIdentifier: "trailerSegue", sender: trailer)
    }
    
    func loadTrailers() {
        guard let url = Bundle.main.url(forResource: "trailers", withExtension: ".json") else {return}
        do {
            let trailersData = try Data(contentsOf: url)
            trailers = try JSONDecoder().decode([Trailer].self, from: trailersData)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrailers()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TrailerViewController
        vc.trailer = (sender as! Trailer)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let trailer = trailers[indexPath.row]
        cell.textLabel?.text = trailer.title
        cell.detailTextLabel?.text = "\(trailer.year)"
        cell.imageView?.image = UIImage(named: "\(trailer.poster)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        showTrailer(index: index)
    }
}
