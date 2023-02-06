//
//  VenuesTableDataProvider.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit

/// Displays table content
protocol VenuesTableDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell(in tableView: UITableView)
    func display(cellsWith viewModels: [VenuesTableCell.ViewModel],
                 in tableView: UITableView)
    
}

final class VenuesTableDataSource: NSObject, VenuesTableDataSourceProtocol {
    
    private var viewModels: [VenuesTableCell.ViewModel] = []
   
    func registerCell(in tableView: UITableView) {
        let identifier = VenuesTableCell.reuseIdentifier
        tableView.register(VenuesTableCell.self,
                           forCellReuseIdentifier: identifier)
    }
    
    func display(cellsWith viewModels: [VenuesTableCell.ViewModel],
                 in tableView: UITableView) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard (0..<viewModels.count).contains(indexPath.row) else {
            return UITableViewCell()
        }
        let identifier = VenuesTableCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        (cell as? VenuesTableCell)?.configure(viewModel: viewModels[indexPath.row])
        return cell
    }

}
