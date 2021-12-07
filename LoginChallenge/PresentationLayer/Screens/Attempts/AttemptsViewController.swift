//
//  AttemptsViewController.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import UIKit

protocol AttemptsViewProtocol: NSObject {
    func changeState(_ state: AttemptsViewStates)
}

class AttemptsViewController: UIViewController {
    var presenter: AttemptsPresenterProtocol?
    
    private var attempts = [AttemptModel]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login Attempts"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = #colorLiteral(red: 0.04919287562, green: 0.04920699447, blue: 0.04918977618, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewLoaded()
    }
}

private extension AttemptsViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupTableView()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.dataSource = self
    }
}

extension AttemptsViewController: AttemptsViewProtocol {
    func changeState(_ state: AttemptsViewStates) {
        switch state {
        case .clear:
            break
        case let .render(model):
            attempts = model
            tableView.reloadData()
        case .error:
            break
        }
    }
}

extension AttemptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attempts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as UITableViewCell
        let model = attempts[indexPath.item]
        let status = model.status ? "Success" : "Failure"
        cell.textLabel?.text = String(format: "Status: %@ - Date: %@", status, model.date)
        return cell
    }
}
