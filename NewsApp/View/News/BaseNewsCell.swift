//
//  BaseNewsCell.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class BaseNewsCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    let titleLabel = UILabel(text: "Label", font: .systemFont(ofSize: 16, weight: .regular))
    var publishedTimeLabel = UILabel(text: "time", font: .systemFont(ofSize: 14, weight: .light))
    let topicLabel = UILabel(text: "topic", font: .systemFont(ofSize: 14, weight: .light))
    let imageView = UIImageView(cornerRadius: 8)
    
    // MARK: - Properties
    
    var article: NewsResult!
    
    // MARK: - Methods
    
    func whenPublished(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar.locale = Locale(identifier: "us-US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let publishedDate = dateFormatter.date(from: date) else {
            return "Unknown"
        }
        
        let timeInterval = Date() - publishedDate
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        formatter.calendar = dateFormatter.calendar
        

        guard let formattedString = formatter.string(from: TimeInterval(timeInterval)) else {
            return "Unknown"
        }
   
        return formattedString.components(separatedBy: ",")[0]
    }
}
