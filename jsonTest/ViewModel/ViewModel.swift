//
//  ViewModel.swift
//  jsonTest
//
//  Created by Bayram Yeleç on 25.09.2024.
//

import Foundation

class ViewModel {
    
    var models: [Model] = []
    
    func fetchData(completion: @escaping () -> Void) {
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            print("url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data , error == nil else {
                print("Hata")
                return
            }
            
            do {
                let model = try JSONDecoder().decode([Model].self, from: data)
                DispatchQueue.main.async {
                    self?.models = model
                    completion()
                }
            } catch {
                print("hataaa")
            }
        }
        task.resume()
        
    }
    
}
