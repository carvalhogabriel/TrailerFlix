//
//  TrailerViewController.swift
//  TrailerFlix
//
//  Created by Gabriel Carvalho Guerrero on 26/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit
import AVKit

class TrailerViewController: UIViewController {

    // MARK: - @IBOutlet's
    @IBOutlet weak var imageViewTrailer: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var viewTrailer: UIView!
    
    var trailer: Trailer!
    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    
    // MARK: - @IBAction's
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method's
    func prepareView() {
        labelTitle.text = trailer.title
        labelYear.text = "\(trailer.year)"
        var rating = "Ainda não avaliado"
        if trailer.rating > 0 {
            rating = ""
            for _ in 1...trailer.rating {
                rating += "⭐️"
            }
        }
        labelRating.text = rating
        imageViewTrailer.image = UIImage(named: "\(trailer.poster)-large")
    }
    
    func preparePlayer() {
        let url = URL(fileURLWithPath: trailer.url)
        player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = true
        playerController.player?.play()
        playerController.view.frame = viewTrailer.bounds
        viewTrailer.addSubview(playerController.view)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        preparePlayer()
    }
    
}
