//
//  ViewController.swift
//  MonthlyCalender
//
//  Created by Admin Macappstudio on 09/04/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var MonthlyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var SelectedDate = Date()
    var totalSquares = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setCellsView()
        setMonthView()
    }

    @IBAction func NextMonth(_ sender: Any) {
        SelectedDate = CalenderHelper().plusMonth(date: SelectedDate)
        setMonthView()

    }
    
    @IBAction func PreviousMonth(_ sender: Any) {
        SelectedDate = CalenderHelper().minusMonth(date: SelectedDate)
        setMonthView()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        Cell.DateofMonth.text = totalSquares[indexPath.item]
        return Cell
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalenderHelper().daysInMonth(date: SelectedDate)
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: SelectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        MonthlyLabel.text = CalenderHelper().monthString(date: SelectedDate)
            + " " + CalenderHelper().yearString(date: SelectedDate)
        collectionView.reloadData()
    }
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
}

