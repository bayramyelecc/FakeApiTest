//
//  DetailViewController.swift
//  jsonTest
//
//  Created by Bayram Yeleç on 26.09.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var items: Model?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        
        let imageGorsel = UIImageView()
        imageGorsel.contentMode = .scaleAspectFit
        imageGorsel.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrl = items?.image , let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageGorsel.image = image
                    }
                }
            }
        } else {
            imageGorsel.image = UIImage(systemName: "slowmo")
        }
        view.addSubview(imageGorsel)
        
        NSLayoutConstraint.activate([
            imageGorsel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageGorsel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageGorsel.widthAnchor.constraint(equalToConstant: 300),
            imageGorsel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        let aciklamaText = UILabel()
        aciklamaText.numberOfLines = 0
        aciklamaText.text = items?.description 
        aciklamaText.frame = CGRect(x: 20, y: 130, width: view.frame.width - 40, height: 0)
        aciklamaText.translatesAutoresizingMaskIntoConstraints = false
        aciklamaText.sizeToFit()
        view.addSubview(aciklamaText)
        
        NSLayoutConstraint.activate([
            aciklamaText.topAnchor.constraint(equalTo: imageGorsel.bottomAnchor, constant: 20),
            aciklamaText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aciklamaText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
}
