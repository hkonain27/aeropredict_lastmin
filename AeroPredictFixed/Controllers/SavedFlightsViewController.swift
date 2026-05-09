//
//  SavedFlightsViewController.swift
//  AeroPredict
//
//  Created by Hafsa Konain on 4/2/26.
//
//
//  SavedFlightsViewController.swift
//  AeroPredict
//
import UIKit

    class SavedFlightsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var emptyLabel: UILabel!

        var savedFlights: [FlightPrediction] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            title = "Saved Flights"

            view.backgroundColor = UIColor.systemGroupedBackground

            tableView.dataSource = self
            tableView.delegate = self

            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.rowHeight = 120

            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .secondaryLabel
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            savedFlights = StorageManager.shared.loadFlights()

            emptyLabel.isHidden = !savedFlights.isEmpty

            tableView.reloadData()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return savedFlights.count
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let flight = savedFlights[indexPath.row]

            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell",
                                                     for: indexPath)

            cell.backgroundColor = .clear
            cell.selectionStyle = .none

            var content = cell.defaultContentConfiguration()

            content.text =
            "\(flight.flightNumber)   \(flight.origin) → \(flight.destination)"

            content.secondaryText =
            "Delay: \(flight.delayProbability)%   Risk: \(flight.riskLevel.rawValue)"

            content.textProperties.font =
            UIFont.boldSystemFont(ofSize: 22)

            content.secondaryTextProperties.font =
            UIFont.boldSystemFont(ofSize: 18)

            switch flight.riskLevel {

            case .low:
                content.secondaryTextProperties.color = .systemGreen

            case .medium:
                content.secondaryTextProperties.color = .systemOrange

            case .high:
                content.secondaryTextProperties.color = .systemRed
            }

            cell.contentConfiguration = content

            let bgView = UIView()
            bgView.backgroundColor = .white
            bgView.layer.cornerRadius = 22
            bgView.layer.masksToBounds = true

            cell.backgroundView = bgView

            return cell
        }
    }
