//
//  PredictionViewController.swift
//  AeroPredict
//
//  Created by Hafsa Konain on 4/2/26.
//
import UIKit

protocol SaveFlightDelegate: AnyObject {
    func didSaveFlight(_ flight: FlightPrediction)
}

class PredictionViewController: UIViewController {

    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var factorsLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    var prediction: FlightPrediction?
       weak var delegate: SaveFlightDelegate?

       override func viewDidLoad() {
           super.viewDidLoad()

           title = "Prediction Details"
           view.backgroundColor = UIColor.systemGroupedBackground

           styleLabels()
           styleButton()
           loadPrediction()
       }

       private func styleLabels() {
           flightNumberLabel.font = UIFont.boldSystemFont(ofSize: 32)
           routeLabel.font = UIFont.boldSystemFont(ofSize: 24)
           delayLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
           riskLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
           factorsLabel.font = UIFont.systemFont(ofSize: 18)

           factorsLabel.numberOfLines = 0
       }

       private func styleButton() {
           saveButton.setTitle("Save Flight", for: .normal)
           saveButton.backgroundColor = .systemBlue
           saveButton.tintColor = .white
           saveButton.layer.cornerRadius = 16
           saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
       }

       private func loadPrediction() {
           guard let prediction = prediction else { return }

           flightNumberLabel.text = prediction.flightNumber
           routeLabel.text = "\(prediction.origin) → \(prediction.destination)"
           delayLabel.text = "Delay: \(prediction.delayProbability)%"
           riskLabel.text = "Risk: \(prediction.riskLevel.rawValue)"
           factorsLabel.text = "Factors: \(prediction.factors.joined(separator: ", "))"

           switch prediction.riskLevel {
           case .low:
               riskLabel.textColor = .systemGreen
               delayLabel.textColor = .systemGreen
           case .medium:
               riskLabel.textColor = .systemOrange
               delayLabel.textColor = .systemOrange
           case .high:
               riskLabel.textColor = .systemRed
               delayLabel.textColor = .systemRed
           }
       }

    @IBAction func saveTapped(_ sender: UIButton) {
        guard let prediction = prediction else { return }

                var flights = StorageManager.shared.loadFlights()

                if !flights.contains(where: { $0.flightNumber == prediction.flightNumber }) {
                    flights.append(prediction)
                    StorageManager.shared.saveFlights(flights)
                }

                delegate?.didSaveFlight(prediction)

                saveButton.setTitle("Saved ✓", for: .normal)
                saveButton.backgroundColor = .systemGreen
            }
        }
